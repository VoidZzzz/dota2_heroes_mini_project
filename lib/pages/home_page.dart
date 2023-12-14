import 'package:dota_heroes_app/pages/detail_page.dart';
import 'package:dota_heroes_app/utils/app_constants.dart';
import 'package:dota_heroes_app/utils/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';
import '../models/hero_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.heroesList});

  final List<HeroModel> heroesList;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  bool xListHasBeenScrolled = false;

  @override
  void initState() {
    scrollController.addListener(() {
      listenToScroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  void listenToScroll() {
    if (scrollController.position.pixels > 1000) {
      xListHasBeenScrolled = true;
    } else {
      xListHasBeenScrolled = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.heroesList.length,
                    itemBuilder: (context, index) {
                      return heroWidget(hero: widget.heroesList[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButton(),
    );
  }

  Widget heroWidget({required HeroModel hero}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return DetailPage(hero: hero);
          }),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: AppFunctions.getAttributeColor(
                        attribute: hero.primaryAttribute!)
                    .withOpacity(0.05),
                offset: const Offset(5, 5),
                spreadRadius: 0,
                blurRadius: 2)
          ],
          border: Border.all(
              color: AppFunctions.getAttributeColor(
                  attribute: hero.primaryAttribute!),
              width: 2),
          color:
              AppFunctions.getAttributeColor(attribute: hero.primaryAttribute!)
                  .withOpacity(0.05),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                onTapHeroImage(hero.image!);
              },
              child: Hero(
                tag: hero.id!,
                child: Container(
                  height: 60,
                  width: 60,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    hero.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hero.name ?? "",
                  style: AppConstants.titleTextStyleBlack,
                ),
                Row(
                  children: AppFunctions.generateIcons(roles: hero.roles!),
                )
              ],
            ),
            const Spacer(),
            AppFunctions.getAttributeImage(attribute: hero.primaryAttribute!)
          ],
        ),
      ),
    );
  }

  Widget floatingButton() {
    return AnimatedOpacity(
      opacity: xListHasBeenScrolled ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration:
            const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        padding: const EdgeInsets.all(10),
        child: IconButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInBack);
          },
          icon: const Icon(
            TablerIcons.upload,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void onTapHeroImage(String img) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }

  Widget customAppBar() {
    return const Text(
      "All Heroes List",
      style: AppConstants.titleTextStyleBlack,
    );
  }
}
