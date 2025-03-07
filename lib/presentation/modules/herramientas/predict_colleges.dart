import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final TextEditingController _countryController = TextEditingController();
  List universities = [];

  Future<void> fetchUniversities() async {
    String country = _countryController.text.trim();
    if (country.isEmpty) return;

    try {
      var response = await Dio()
          .get("http://universities.hipolabs.com/search?country=$country");
      setState(() {
        universities = response.data;
      });
    } catch (e) {
      setState(() {
        universities = [];
      });
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Universidades", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _countryController,
              decoration:
                  InputDecoration(labelText: "Ingrese un país en inglés"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: fetchUniversities,
                child: Text("Buscar Universidades")),
            SizedBox(height: 20),
            Expanded(
              child: universities.isEmpty
                  ? Center(child: Text("No hay universidades disponibles"))
                  : ListView.builder(
                      itemCount: universities.length,
                      itemBuilder: (context, index) {
                        var uni = universities[index];
                        return Card(
                          child: ListTile(
                            title: Text(uni["name"],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(uni["domains"].join(", ")),
                            trailing: IconButton(
                              icon: Icon(Icons.open_in_new,
                                  color: Colors.redAccent),
                              onPressed: () => _launchURL(uni["web_pages"][0]),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
