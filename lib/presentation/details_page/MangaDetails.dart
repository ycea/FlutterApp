import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/extensions/LocalContextX.dart';

import '../../domain/models/card.dart';

class MangaDetail extends StatelessWidget {
  final CardData cardData;
  const MangaDetail(this.cardData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(cardData.name, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  cardData.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: double.infinity,

                    child: Image.network(
                      cardData.imageUrl ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Placeholder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  context.locale.description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cardData.description ?? "",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
