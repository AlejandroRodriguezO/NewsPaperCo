import 'package:NewsPapersCo/src/models/NewsResponse.dart';
import 'package:NewsPapersCo/src/provider/dark_mode.dart';
import 'package:NewsPapersCo/src/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int i) {
        return _Noticia(
          noticia: this.noticias[i],
          index: i,
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({this.noticia, this.index});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () async {
          final url = '${this.noticia.url}';
          if (await canLaunch(url)) {
            await launch(
              url,
              forceWebView: true,
            );
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              _TarjetaTopBar(noticia),
              _TarjetaTitulo(noticia),
              _TarjetaImagen(noticia),
              _TarjetaDescripcion(noticia),
            ],
          ),
        ),
      ),
    );
  }
}

class _TarjetaDescripcion extends StatelessWidget {
  final Article noticia;

  const _TarjetaDescripcion(this.noticia);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: responsive.ip(1.3),
      ),
      padding: EdgeInsets.symmetric(horizontal: responsive.ip(1.5)),
      child: Column(
        children: [
          Text(
            '${noticia.description}',
            style: TextStyle(fontSize: responsive.ip(1.7)),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: responsive.ip(4),
          )
        ],
      ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: (noticia.urlToImage != null)
          ? FadeInImage(
              placeholder: AssetImage('assets/giphy.gif'),
              image: NetworkImage(noticia.urlToImage),
            )
          : FadeInImage(
              placeholder: AssetImage('assets/giphy.gif'),
              image: AssetImage('assets/no-image.png'),
            ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final theme = Provider.of<ThemeState>(context);
    return Container(
      padding: EdgeInsets.only(
        right: responsive.ip(1.5),
        left: responsive.ip(1.5),
        bottom: responsive.ip(1.5),
        top: responsive.ip(1),
      ),
      child: Text(
        '${noticia.title}',
        style: TextStyle(
            fontSize: responsive.ip(2),
            fontWeight: FontWeight.w700,
            color: theme.darkTheme ? Colors.white : Colors.black),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  const _TarjetaTopBar(this.noticia);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final String publicado = '${noticia.publishedAt}';

    String date = publicado.substring(0, 10);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.ip(1.5)),
      margin: EdgeInsets.only(top: responsive.ip(1)),
      child: Row(
        children: [
          Text(
            '${noticia.source.name} | ',
            style: TextStyle(color: Colors.red,fontSize: responsive.ip(1.5)),
          ),
          Text(
            '$date',
            style: TextStyle(color: Colors.red,fontSize: responsive.ip(1.5)),
          ),
        ],
      ),
    );
  }
}
