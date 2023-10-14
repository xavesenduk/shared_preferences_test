import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Web Shared Preferences'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                sharedPreferences.setString('access_token', accessToken);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyTokenPage(
                      title: 'Flutter Web Shared Preferences',
                    ),
                  ),
                );
              },
              // Remove token is fairly equal to log-in
              child: const Text('Write Token'),
            ),
          ],
        ),
      ),
    );
  }

  final String accessToken = 'access_token_is_here';
}

class MyTokenPage extends StatefulWidget {
  const MyTokenPage({super.key, required this.title});

  final String title;

  @override
  State<MyTokenPage> createState() => _MyTokenPageState();
}

class _MyTokenPageState extends State<MyTokenPage> {
  late SharedPreferences sharedPreferences;
  String accessToken = '';

  @override
  void initState() {
    initSharedPreferences();

    super.initState();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString('access_token')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(accessToken),
            TextButton(
              onPressed: () {
                sharedPreferences.remove('access_token');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                      title: 'Flutter Web Shared Preferences',
                    ),
                  ),
                );
              },
              // Remove token is fairly equal to log-out
              child: const Text('Remove Token'),
            ),
          ],
        ),
      ),
    );
  }
}
