import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App One',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUniLinks();
    // getDataFromUrl();
  }

  void initUniLinks() {
    uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.scheme == 'com.testing.one') {
        data = uri.queryParameters['param'];
        setState(() {});

        // Do something with the data
        print("param :: $data");
      }
    }, onError: (err) {
      // Handle error
    });

    // For iOS, you need to call this method to initially handle the incoming URL
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      Uri? initialUri = await getInitialUri();
      if (initialUri != null && initialUri.scheme == 'com.testing.one') {
        data = initialUri.queryParameters['param'];
        setState(() {});
        // Do something with the data
      }
    } on PlatformException {
      // Handle error
    }
  }

  void getDataFromUrl() {
    final Uri uri = Uri.parse(window.defaultRouteName);
    if (uri.queryParameters.containsKey('data')) {
      data = uri.queryParameters['data'];
      // Do something with the data
      setState(() {});

      print('Received data: $data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("app one = ${data}"),
      ),
    );
  }
}
