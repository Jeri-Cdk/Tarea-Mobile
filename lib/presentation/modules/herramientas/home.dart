import 'package:app2/presentation/modules/blog/blog.dart';
import 'package:app2/presentation/modules/herramientas/pokemon.dart';
import 'package:app2/presentation/modules/herramientas/predict_age.dart';
import 'package:app2/presentation/modules/herramientas/predict_colleges.dart';
import 'package:app2/presentation/modules/herramientas/predict_gender.dart';
import 'package:app2/presentation/modules/herramientas/weather.dart';
import 'package:app2/presentation/modules/hire_me/hire.dart';
import 'package:app2/presentation/widgets/predictor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> pages = [Herramientas(), BlogScreen(), HireMeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(TablerIcons.tools),
              label: "Herramientas",
              backgroundColor: Colors.redAccent),
          BottomNavigationBarItem(
              icon: Icon(TablerIcons.brand_wordpress),
              label: "Blog",
              backgroundColor: Colors.redAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: "Contratame",
              backgroundColor: Colors.redAccent),
        ],
        currentIndex: currentIndex,
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
      ),
    );
  }
}

class Herramientas extends StatelessWidget {
  const Herramientas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 26.h,
              width: 100.w,
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
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/toolbox.png',
                    width: 100.sp,
                    height: 40.sp,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "JeriToolBox",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: 100.w,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Herramientas IA",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        children: [
                          PredictorCard(
                            title: "Predictor de Edad",
                            icon: TablerIcons.number,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AgeScreen()));
                            },
                            color1: const Color(0xFFFF5252),
                            color2: Colors.deepOrange,
                          ),
                          SizedBox(width: 12),
                          PredictorCard(
                            title: "Predicción de Género",
                            icon: TablerIcons.gender_bigender,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GenderScreen()));
                            },
                            color1: Colors.blueAccent,
                            color2: Colors.blueGrey,
                          ),
                          SizedBox(width: 12),
                          PredictorCard(
                            title: "Predicción de Universidades",
                            icon: TablerIcons.school,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UniversitiesScreen()));
                            },
                            color1: Colors.greenAccent,
                            color2: Colors.teal,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Herramientas varias",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => WeatherScreen())),
                        child: Container(
                          height: 150,
                          width: double
                              .infinity, // Aquí puedes poner el 100% del ancho
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00B0FF),
                                Color(0xFFB3E5FC)
                              ], // Gradiente azul claro
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Clima Actual",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => PokemonScreen())),
                        child: Container(
                          height: 150,
                          width: double
                              .infinity, // Aquí puedes poner el 100% del ancho
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFD600),
                                Color(0xFFFF6D00)
                              ], // Gradiente amarillo y naranja
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.catching_pokemon,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Predicción Pokémon",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
