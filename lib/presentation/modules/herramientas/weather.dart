import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = "JPJ3X77J44UA5Z66MUQLQQMDF"; // API Key de VisualCrossing
  String city = "Santo Domingo";
  String description = "";
  double temperature = 0.0;
  String iconUrl = "";

  // Función para obtener los datos del clima
  Future<void> fetchWeather() async {
    try {
      var response = await Dio().get(
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city?unitGroup=us&key=$apiKey&contentType=json",
      );

      setState(() {
        // Extrayendo la descripción y la temperatura del JSON
        description = response.data["currentConditions"]["conditions"];
        temperature = response.data["currentConditions"]["temp"];
        // Usamos un icono genérico para ilustrar el clima
        iconUrl =
            "https://cdn.weatherapi.com/weather/64x64/day/113.png"; // Icono predeterminado
      });
    } catch (e) {
      setState(() {
        description = "Error al obtener el clima";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Llamada a la función de obtener clima
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clima en Santo Domingo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconUrl.isNotEmpty)
                Image.network(iconUrl,
                    width: 100), // Mostrar el ícono del clima
              SizedBox(height: 16),
              Text(
                city,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Text(
                "${fahrenheitToCelsius(temperature).toStringAsFixed(1)} °C",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchWeather, // Botón para actualizar clima
                child: Text("Actualizar Clima"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
