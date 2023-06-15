import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Two',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String customUrlScheme =
                'com.testing.one://?param=Hello From App Two'; // Replace 'myapp' with the target app's custom URL scheme
            String playStoreUrl =
                'https://play.google.com/store/apps/details?id=com.yanyan.techblog';

            try {
              launch(customUrlScheme);
            } catch (e) {
              launch(playStoreUrl);
              print("launch error ::::::::::::::::::::::::::::::::::: $e");
            }
          },
          child: Text("Open App One"),
        ),
      ),
    );
  }
}
