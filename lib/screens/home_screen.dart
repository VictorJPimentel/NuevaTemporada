import 'package:flutter/material.dart';
import 'package:nueva_temporada/models/channel_model.dart';
import 'package:nueva_temporada/models/video_model.dart';
import 'package:nueva_temporada/screens/video_screen.dart';
import 'package:nueva_temporada/widgets/nav-drawer.dart';
// import 'package:nueva_temporada/landing_page.dart';
import 'package:nueva_temporada/widgets/topvideos.dart';
import 'package:nueva_temporada/services/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MotionTabController _tabController;
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCjuGjYdLrhk4tB3eB6DTuYg');
    setState(() {
      _channel = channel;
    });
  }

  // _buildProfileInfo() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
  //     padding: EdgeInsets.all(10.0),
  //     height: 100.0,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 1),
  //           blurRadius: 6.0,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         CircleAvatar(
  //           backgroundColor: Colors.white,
  //           radius: 35.0,
  //           backgroundImage: NetworkImage(_channel.profilePictureUrl),
  //         ),
  //         SizedBox(width: 12.0),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 _channel.title,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               Text(
  //                 '${_channel.subscriberCount} subscribers',
  //                 style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontSize: 16.0,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
        height: 260.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              width: 1000.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 1,
                ),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    topRight: const Radius.circular(8.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints.expand(
                height: 200.0,
              ),
              child: Image.network(video.thumbnailUrl, fit: BoxFit.cover),
              // Image(
              //   width: 350.0,
              //   height: 250.0,
              //   image: NetworkImage(video.thumbnailUrl),
              //   fit: BoxFit.fill,
              // ),
            )
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

  _buildTopVideo() {
    return TopVideoScreen(id: 'L1zgwfXPAfw');
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

  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: NavDrawer(),
        appBar: AppBar(
          title: Image.asset(
            'assets/images/LogoIglesiaNuevaTemporada-1.png',
            height: 70,
            width: 100,
          ),
        ),
        bottomNavigationBar: MotionTabBar(
          labels: ["Videos", "Home", "Noticias"],
          initialSelectedTab: "Home",
          tabIconColor: Colors.teal,
          tabSelectedColor: Colors.teal,
          onTabItemSelected: (int value) {
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.menu, Icons.home, Icons.menu],
          textStyle: TextStyle(color: Colors.teal),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                  child: _channel != null
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
                          child: ListView.builder(
                            itemCount: 1 + _channel.videos.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 1) {
                                return _buildTopVideo();
                              }
                              if (index == 0) {
                                return _buildProfileInfo();
                              }
                              Video video = _channel.videos[index - 1];
                              return _buildVideo(video);
                            },
                          ),
                        )
                      : const SizedBox.shrink()),
            ),
            Container(
              child: Builder(builder: (BuildContext context) {
                return WebView(
                  initialUrl: 'https://iglesianuevatemporada.org',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _webViewController = webViewController;
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');

                    _webViewController
                        .evaluateJavascript("javascript:(function() { " +
                            "var head = document.getElementsByTagName('header')[0];" +
                            "head.parentNode.removeChild(head);" +
                            "var footer = document.getElementsByTagName('footer')[0];" +
                            "footer.parentNode.removeChild(footer);" +
                            "})()")
                        .then((value) =>
                            debugPrint('Page finished loading Javascript'))
                        .catchError((onError) => debugPrint('$onError'));
                  },
                  gestureNavigationEnabled: true,
                );
              }),
            ),
            Container(
              child: Builder(builder: (BuildContext context) {
                return WebView(
                  initialUrl: 'https://iglesianuevatemporada.orflug/noticias',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _webViewController = webViewController;
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');

                    _webViewController
                        .evaluateJavascript("javascript:(function() { " +
                            "var head = document.getElementsByTagName('header')[0];" +
                            "head.parentNode.removeChild(head);" +
                            "var footer = document.getElementsByTagName('footer')[0];" +
                            "footer.parentNode.removeChild(footer);" +
                            "})()")
                        .then((value) =>
                            debugPrint('Page finished loading Javascript'))
                        .catchError((onError) => debugPrint('$onError'));
                  },
                  gestureNavigationEnabled: true,
                );
              }),
            ),
          ],
        ));
  }
}
