/*import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Feed(postsCount: 5),
      ),
    );
  }
}

class Feed extends StatefulWidget {
  final int postsCount;

  Feed({required this.postsCount});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  ButtonStyle customButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD60909)),
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1D1818)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.postsCount,
            itemBuilder: (context, index) {
              return FeedPost(
                author: 'Dia',
                videoUrl: 'https://www.youtube.com/watch?v=2uyHqRGJmZ4',
                titulo: 'Muscle Up',
                duracion: 212,
                series: 3,
                musculos: ['Abdomen', 'Brazo'],
                grupos: ['Grupo 3', 'Grupo 4'],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (currentPage > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text('Publicación Anterior'),
              style: customButtonStyle(), // Aplicar el estilo personalizado
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                if (currentPage < widget.postsCount - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text('Siguiente Publicación'),
              style: customButtonStyle(), // Aplicar el estilo personalizado
            ),
          ],
        ),
      ],
    );
  }
}

class FeedPost extends StatelessWidget {
  final String author;
  final String videoUrl;
  final String titulo;
  final int duracion;
  final int series;
  final List<String> musculos;
  final List<String> grupos;

  FeedPost({
    required this.author,
    required this.videoUrl,
    required this.titulo,
    required this.duracion,
    required this.series,
    required this.musculos,
    required this.grupos,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600; // Detectar si es un dispositivo móvil

    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              author,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
              ),
            ),
            builder: (context, player) {
              return isMobile // Ajustar el tamaño en función del dispositivo
                  ? player // En dispositivos móviles, mantener el tamaño original
                  : SizedBox(
                      width: 400, // Ancho reducido en dispositivos de escritorio
                      height: 225, // Alto reducido en dispositivos de escritorio
                      child: player,
                    );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titulo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text('Duración: $duracion minutos'),
                Text('Series: $series'),
                Text('Musculos: ${musculos.join(', ')}'),
                Text('Grupos: ${grupos.join(', ')}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/