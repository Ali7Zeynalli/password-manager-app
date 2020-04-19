import 'package:acharlarim/providers/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() => runApp(
      ChangeNotifierProvider<General>(
        create: (context) => General(),
        child: MyApp(),
      ),
    );

// ThemeData(
//               primaryColor: Colors.blueGrey[900],
//               accentColor: Colors.blueGrey[900],
//               fontFamily: "Quicksand")
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: generalProvider.isDarkTheme
          ? ThemeData.dark().copyWith(
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: "Quicksand",
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
              accentColor: Colors.indigoAccent.withOpacity(0.3),
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
              accentColor: Colors.indigoAccent,
              primaryColor: Colors.indigo,
              appBarTheme: AppBarTheme(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: "Quicksand",
                      bodyColor: Colors.white,
                    ),
              ),
            ),
      home: Home(),
    );
  }
}
