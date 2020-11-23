import 'package:NewsPapersCo/src/Api/NewsPaper.dart';
import 'package:NewsPapersCo/src/Themes/colors_style.dart';
import 'package:NewsPapersCo/src/pages/HomePage.dart';
import 'package:NewsPapersCo/src/provider/Navegacion.dart';
import 'package:NewsPapersCo/src/provider/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeState themeChangeProvider = new ThemeState();
   @override
  void initState() {

    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Navegacion()),
        ChangeNotifierProvider(create: (_) => NewsPaperApi()),
        ChangeNotifierProvider(create: (_)=> themeChangeProvider)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NewsPaperCo',
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        home: HomePage(),
      ),
    );
  }
}
