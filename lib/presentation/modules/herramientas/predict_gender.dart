import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _nameController = TextEditingController();
  String gender = "";
  String message = "";
  Color backgroundColor = Colors.white;

  Future<void> predictGender() async {
    String name = _nameController.text.trim();
    if (name.isEmpty) return;

    try {
      var response = await Dio().get("https://api.genderize.io/?name=$name");
      String predictedGender = response.data["gender"] ?? "unknown";

      setState(() {
        gender = predictedGender;
        backgroundColor =
            (gender == "male") ? Colors.blue[100]! : Colors.pink[100]!;
        message = "Género estimado: ${gender.toUpperCase()}";
      });
    } catch (e) {
      setState(() {
        message = "Error al predecir género";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          title: Text("Predicción de Género",
              style: TextStyle(color: Colors.white)),
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
                onPressed: predictGender, child: Text("Predecir Género")),
            SizedBox(height: 20),
            Text(message,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
