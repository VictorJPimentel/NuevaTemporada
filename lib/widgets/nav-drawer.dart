import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Nosotros'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WebView(
                  initialUrl: 'https://iglesianuevatemporada.org/nosotros/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ministerio'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WebView(
                  initialUrl: 'https://iglesianuevatemporada.org/ministerios/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Contactos'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WebView(
                  initialUrl: 'https://iglesianuevatemporada.org/nosotros/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Donaciones'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WebView(
                  initialUrl: 'https://iglesianuevatemporada.org/donaciones/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
