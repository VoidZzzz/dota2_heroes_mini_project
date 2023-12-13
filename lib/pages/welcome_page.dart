import 'dart:convert';

import 'package:dota_heroes_app/pages/home_page.dart';
import 'package:dota_heroes_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/hero_model.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<HeroModel> heroesList = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..repeat();

    fetchAllHeroesAndMoveToHomePage();
  }

  Future<void> fetchAllHeroesAndMoveToHomePage()async{
    const String uri = "https://abusing-scripts.vercel.app/api/heros";
    Response response = await http.get(Uri.parse(uri));
    if(response.statusCode == 200 || response.statusCode == 201){
      var convertedResponse = jsonDecode(response.body);
      for(var r in convertedResponse)
      {
        heroesList.add(HeroModel.fromJson(json: r));
      }
    }
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return HomePage(heroesList: heroesList,);
      }));
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundImage(),
          Positioned(
            bottom: 30,
            child: animatedText(),
          )
        ],
      ),
    );
  }

  Widget animatedText() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Opacity(
            opacity: animationController.value,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  "Welcome!",
                  style: AppConstants.titleTextStyle,
                ),
              ),
            ),
          );
        });
  }

  Widget backgroundImage() {
    return SizedBox.expand(
      child: Image.network(
        "https://wallpapers.com/images/hd/dota-2-phone-rcl35t6l3spfvkbb.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
