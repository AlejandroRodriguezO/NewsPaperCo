import 'package:NewsPapersCo/src/pages/tab1page.dart';
import 'package:NewsPapersCo/src/pages/tab2page.dart';
import 'package:NewsPapersCo/src/provider/Navegacion.dart';
import 'package:NewsPapersCo/src/provider/dark_mode.dart';
import 'package:NewsPapersCo/src/widgets/responsive.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _NavegacionModel(),
      bottomNavigationBar: _Navegacion(),
    );
  }
}

class _NavegacionModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegarModel = Provider.of<Navegacion>(context);
    return PageView(
      controller: navegarModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [Tab1Page(), Tab2Page()],
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeState>(context);
    final navegarModel = Provider.of<Navegacion>(context);
    return ConvexAppBar(
      initialActiveIndex: navegarModel.paginaActual,
      onTap: (i) => navegarModel.paginaActual = i,
      style: TabStyle.react,
      backgroundColor: theme.darkTheme ? Colors.black45 : Colors.redAccent,
      items: [
        TabItem(
          icon: Icon(Icons.home, color: Colors.white,),
          title: 'Inicio',
        ), 
        TabItem(
          icon: Icon(FontAwesomeIcons.newspaper, color: Colors.white),
          title: 'Categorias',
        ),
      ],
    );
  }
}
