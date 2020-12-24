import 'package:flutter/material.dart';
import 'package:nueva_temporada/models/channel_model.dart';
import 'package:nueva_temporada/models/video_model.dart';
import 'package:nueva_temporada/screens/video_screen.dart';
import 'package:nueva_temporada/widgets/nav-drawer.dart';
import 'package:nueva_temporada/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCjuGjYdLrhk4tB3eB6DTuYg');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: 320.0,
        child: Column(
          children: <Widget>[
            Container(
              width: 1000.0,
              height: 0.5,
              decoration: BoxDecoration(color: Colors.black),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: 1000.0,
              height: 50.0,
              //decoration: BoxDecoration(color: Colors.white),
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
            Image(
              width: 350.0,
              height: 250.0,
              image: NetworkImage(video.thumbnailUrl),
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  _buildTopVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: 320.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              width: 1000.0,
              height: 50.0,
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            Image(
              width: 350.0,
              height: 250.0,
              image: NetworkImage(video.thumbnailUrl),
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          endDrawer: NavDrawer(),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Videos"),
                Tab(text: "Home"),
                Tab(text: "Adds"),
              ],
            ),
            title: Image.asset(
              'assets/images/LogoIglesiaNuevaTemporada-1.png',
              height: 70,
              width: 100,
            ),
          ),
          body: _channel != null
              ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!_isLoading &&
                        _channel.videos.length !=
                            int.parse(_channel.videoCount) &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
                      _loadMoreVideos();
                    }
                    return false;
                  },
                  child: TabBarView(children: [
                    ListView.builder(
                      itemCount: 1 + _channel.videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (index == 0) {
                        //   // return _buildProfileInfo();
                        // }
                        if (index == 0) {
                          Video video = _channel.videos[0];
                          return _buildTopVideo(video);
                        }
                        Video video = _channel.videos[index - 1];
                        return _buildVideo(video);
                      },
                    ),
                    Icon(Icons.apps),
                    Icon(Icons.apps),
                  ]),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
