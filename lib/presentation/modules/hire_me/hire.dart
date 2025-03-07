import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HireMeScreen extends StatelessWidget {
  // Cambia con tu imagen
  final String name = "Jeriel Gómez";
  final String title = "FullStack Developer";
  final String description =
      "Soy un desarrollador apasionado con experiencia en Web y Mobile con Flutter, creando aplicaciones móviles y web atractivas y funcionales.";

  final List<String> skills = [
    "Flutter",
    "Dart",
    "TypeScript",
    "JavaScript",
    "NodeJS",
    "MongoDB",
    "TSQL",
    "NestJS",
    "ReactJS",
    "REST APIs",
    "Git/GitHub",
    "UI/UX Design"
  ];

  final List<Map<String, String>> experience = [
    {
      "role": "Sofware Developer",
      "company": "Codika",
      "years": "Julio 2024 - Actualidad"
    },
    {"role": "Freelancer", "company": "JendyTech", "years": "Since 2020"},
  ];

  final String linkedInUrl =
      "https://www.linkedin.com/in/jeriel-gomez-4b566522b/";
  final String githubUrl = "https://github.com/Jeri-Dev";
  final String email = "mailto:jgomezinf19@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Hire Me",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 245, 116, 116),
                Color.fromARGB(255, 216, 78, 78),
                Color(0xFFB71C1C)
              ], // Tonos intensos de rojo
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto de perfil
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/me.jpeg"),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 20),

            // Habilidades
            _buildSectionTitle("Habilidades"),
            Wrap(
              spacing: 10,
              children: skills
                  .map((skill) => Chip(
                        label: Text(skill,
                            style: GoogleFonts.poppins(fontSize: 14)),
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Experiencia
            _buildSectionTitle("Experiencia"),
            Column(
              children: experience
                  .map((exp) => ListTile(
                        leading: Icon(Icons.work, color: Colors.redAccent),
                        title: Text(exp["role"]!,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold)),
                        subtitle: Text("${exp["company"]} - ${exp["years"]}",
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Contacto
            _buildSectionTitle("Contacto"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(TablerIcons.brand_linkedin, linkedInUrl),
                SizedBox(width: 10),
                _buildSocialButton(TablerIcons.brand_github, githubUrl),
                SizedBox(width: 10),
                _buildSocialButton(TablerIcons.inbox, email),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.redAccent.withOpacity(0.2),
        child: Icon(icon, color: Colors.redAccent),
      ),
    );
  }
}
