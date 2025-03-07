import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String message = "";
  String imageUrl = "";
  int? age;

  Future<void> predictAge() async {
    String name = _nameController.text.trim();
    if (name.isEmpty) return;

    try {
      var response = await Dio().get("https://api.agify.io/?name=$name");
      int predictedAge = response.data["age"] ?? 0;

      setState(() {
        age = predictedAge;
        if (age! < 18) {
          message = "Eres joven!";
          imageUrl = "assets/joven.jpg"; // Reemplazar con imagen real
        } else if (age! < 60) {
          message = "Eres adulto!";
          imageUrl = "assets/adulto.jpg";
        } else {
          message = "Eres anciano!";
          imageUrl = "assets/anciano.jpg";
        }
      });
    } catch (e) {
      setState(() {
        message = "Error al predecir edad";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Predicción de Edad",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Ingrese su nombre"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictAge,
              child: Text("Predecir Edad"),
            ),
            SizedBox(height: 20),
            if (age != null)
              Text("Edad estimada: $age años",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            if (message.isNotEmpty)
              Text(message,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (imageUrl.isNotEmpty) Image.asset(imageUrl, height: 200),
          ],
        ),
      ),
    );
  }
}
