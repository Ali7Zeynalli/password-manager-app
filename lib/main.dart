import 'package:acharlarim/providers/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() {
  runApp(
    ChangeNotifierProvider<General>(
      create: (context) => General(),
      child: MyApp(),
    ),
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Password Manager",
      theme: generalProvider.isDarkTheme
          ? ThemeData.dark().copyWith(
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: "Quicksand",
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
              accentColor: Colors.indigoAccent[200],
              appBarTheme: AppBarTheme(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: "Quicksand",
                      bodyColor: Colors.white,
                    ),
              ),
            )
          : ThemeData.light().copyWith(
              textTheme:
                  Theme.of(context).textTheme.apply(fontFamily: "Quicksand"),
              primaryColor: Colors.indigo,
              accentColor: Colors.indigoAccent,
              appBarTheme: AppBarTheme(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: "Quicksand",
                      bodyColor: Colors.white,
                    ),
              ),
            ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/add": (context) => Add(),
        "/settings": (context) => Settings(),
      },
    );
  }
}
