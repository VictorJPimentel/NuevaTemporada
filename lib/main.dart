// import 'package:nueva_temporada/screen/SplashScreen.dart';
// import 'package:nueva_temporada/screen/home.dart';
// import 'package:nueva_temporada/screen/loginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(new MyApp());
//   });
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.

//   final MaterialColor blackColor = const MaterialColor(
//     0xFF000000,
//     const <int, Color>{
//       50: const Color(0xFF000000),
//       100: const Color(0xFF000000),
//       200: const Color(0xFF000000),
//       300: const Color(0xFF000000),
//       400: const Color(0xFF000000),
//       500: const Color(0xFF000000),
//       600: const Color(0xFF000000),
//       700: const Color(0xFF000000),
//       800: const Color(0xFF000000),
//       900: const Color(0xFF000000),
//     },
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ShareLife',
//       color: blackColor,
//       home: SplashScreen(),
//       routes: <String, WidgetBuilder>{
//         '/HomeScreen': (BuildContext context) => new MainScreen()
//       },
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   var loggedIn = false;6
//   @override
//   void initState() {
//     super.initState();
//     loadSharedPref();
//   }

//   void loadSharedPref() async {
//     final prefs = await SharedPreferences.getInstance();

//     setState(() {
//       loggedIn = prefs.getBool('login') ?? false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     loadSharedPref();
//     return loggedIn ? HomePage() : LoginScreen();
//   }
// }

///////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nueva_temporada/widgets/nav-drawer.dart';

void main() {
  runApp(MyApp());
}

final MaterialColor blackColor = const MaterialColor(
  0xFF000000,
  const <int, Color>{
    50: const Color(0xFF000000),
    100: const Color(0xFF000000),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: const Color(0xFF000000),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nueva Temporada',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Nueva Temporada'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Noticias',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
