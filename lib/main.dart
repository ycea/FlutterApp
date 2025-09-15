import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Савинов Р. Д. ПИбд-32'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: _color, title: Text(widget.title)),
      body: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
        "Атака титанов",
        imageUrl:
            "https://static.wikia.nocookie.net/shingekinokyojin/images/d/d4/SnK_-_Manga_Volume_1.png/revision/latest/scale-to-width-down/1000?cb=20210116221213&path-prefix=ru",
      ),
      _CardData(
        "Фрирен: провожающая в последний путь",
        imageUrl:
            "https://static.wikia.nocookie.net/frieren/images/0/0e/Volume_2_ENG.png/revision/latest?cb=20241218020401&path-prefix=ru",
      ),
      _CardData(
        "Берсерк",
        imageUrl:
            "https://static.wikia.nocookie.net/berserk/images/d/de/V1-Cover-Manga.jpg/revision/latest?cb=20210211210752&path-prefix=ru",
      ),
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((card) => _Card.fromData(card)).toList(),
        ),
      ),
    );
  }
}

class _CardData {
  final String name;
  final IconData icon; // for the future update
  final String? imageUrl;
  const _CardData(
    this.name, {
    this.imageUrl,
    this.icon = Icons.ac_unit_outlined,
  });
}

class _Card extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? imageUrl;
  const _Card(this.name, {this.icon = Icons.ac_unit_outlined, this.imageUrl});
  factory _Card.fromData(_CardData data) =>
      _Card(data.name, icon: data.icon, imageUrl: data.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 6),
          BoxShadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 6),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 200,
                    height: 240,
                    child: Image.network(
                      imageUrl ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Placeholder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
