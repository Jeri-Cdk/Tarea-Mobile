import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _pokemonController = TextEditingController();
  String name = "";
  String imageUrl = "";
  int baseExperience = 0;
  List<String> abilities = [];

  Future<void> fetchPokemon() async {
    String pokemonName = _pokemonController.text.trim().toLowerCase();
    if (pokemonName.isEmpty) return;

    try {
      var response =
          await Dio().get("https://pokeapi.co/api/v2/pokemon/$pokemonName");

      setState(() {
        name = response.data["name"];
        imageUrl = response.data["sprites"]["front_default"];
        baseExperience = response.data["base_experience"];
        abilities = (response.data["abilities"] as List)
            .map((item) => item["ability"]["name"].toString())
            .toList();
      });
    } catch (e) {
      setState(() {
        name = "No encontrado";
        imageUrl = "";
        baseExperience = 0;
        abilities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Buscar Pokémon"), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pokemonController,
              decoration: InputDecoration(labelText: "Ingrese un Pokémon"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: fetchPokemon, child: Text("Buscar")),
            SizedBox(height: 20),
            if (imageUrl.isNotEmpty)
              CachedNetworkImage(imageUrl: imageUrl, width: 150),
            if (name.isNotEmpty)
              Text(name.toUpperCase(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (baseExperience > 0)
              Text("Experiencia Base: $baseExperience",
                  style: TextStyle(fontSize: 18)),
            if (abilities.isNotEmpty) ...[
              SizedBox(height: 10),
              Text("Habilidades:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: abilities
                    .map((ability) => Chip(label: Text(ability)))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
