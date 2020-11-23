import 'package:NewsPapersCo/src/Api/NewsPaper.dart';
import 'package:NewsPapersCo/src/Themes/colors_style.dart';
import 'package:NewsPapersCo/src/models/Categoria.dart';
import 'package:NewsPapersCo/src/widgets/listanoticias.dart';
import 'package:NewsPapersCo/src/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsPaperApi>(context);
    print(newsService.isLoading);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          _ListaCategorias(),
          if (!newsService.isLoading)
            Expanded(
                child: ListaNoticias(
                    newsService.getArticulosCategoriaSeleccionada)),
          if (newsService.isLoading)
            Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ))
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<NewsPaperApi>(context).categories;
    final responsive = Responsive.of(context);
    final newsService = Provider.of<NewsPaperApi>(context);
    return Container(
      width: responsive.width,
      height: responsive.ip(12),
      padding: EdgeInsets.only(top: responsive.ip(1)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Styles.whiteColor),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int i) {
          final cNombre = categorias[i].nombre;
          return Container(
            width: responsive.ip(14),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _ButtonCategoria(categorias[i]),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${cNombre[0].toUpperCase()}${cNombre.substring(1)}',
                    style: TextStyle(
                      fontSize: responsive.ip(1.6),
                      fontWeight:
                          (newsService.selectedCategory == categorias[i].name)
                              ? FontWeight.bold
                              : FontWeight.normal,
                      color:
                          (newsService.selectedCategory == categorias[i].name)
                              ? Colors.red
                              : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ButtonCategoria extends StatelessWidget {
  final Category categorias;

  const _ButtonCategoria(this.categorias);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final newsService = Provider.of<NewsPaperApi>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsPaperApi>(context, listen: false);
        newsService.selectedCategory = categorias.name;
      },
      child: Container(
        width: responsive.ip(6),
        height: responsive.ip(6),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: (newsService.selectedCategory == this.categorias.name)
                  ? Colors.redAccent
                  : Colors.black,
            )),
        child: Icon(
          categorias.icon,
          color: (newsService.selectedCategory == this.categorias.name)
              ? Colors.red
              : Colors.black,
        ),
      ),
    );
  }
}
