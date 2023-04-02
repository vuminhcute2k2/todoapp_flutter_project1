import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name){
          case "/":
            return MaterialPageRoute(builder: (context) => HomePageScreen(),
            settings: settings,
          );
          
        }
        return null;
      },
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const HomePageScreen(),
    );
  }
}

