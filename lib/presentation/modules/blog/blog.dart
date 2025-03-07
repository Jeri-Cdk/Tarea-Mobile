import 'package:app2/models/post.dart';
import 'package:app2/services/wordpress_services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final ApiService apiService = ApiService("https://sebasweb.net/");

  late Future<List<Post>> futurePosts;
  late Future<String> futureSiteName;

  @override
  void initState() {
    super.initState();
    futurePosts = apiService.fetchPosts();
    futureSiteName = apiService.fetchSiteName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: futureSiteName,
          builder: (context, snapshot) {
            return Text(
              snapshot.hasData ? snapshot.data! : "Cargando...",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            );
          },
        ),
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
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error al cargar noticias"));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          post.excerpt
                              .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              final url = Uri.parse(post.link);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            child: Text("Leer más",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
