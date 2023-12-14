import 'package:dota_heroes_app/models/hero_model.dart';
import 'package:dota_heroes_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

import '../utils/app_functions.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.hero});

  final HeroModel hero;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heroImageWidget(),
          heroNameWidget(),
          rolesWidget(),
          const Spacer(),
          backButton(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget rolesWidget() {
    return Wrap(
      children: widget.hero.roles!
          .map(
            (e) => Padding(
              padding:
                  const EdgeInsets.only(left: AppConstants.horizontalPadding),
              child: Text(
                AppFunctions.getStringFromEnum(role: e),
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget backButton() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width -
            AppConstants.horizontalPadding * 2,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          },
          child: const Text(
            "Back to home",
            style: AppConstants.defaultTextStyle,
          ),
        ),
      ),
    );
  }

  Widget heroImageWidget() {
    return Hero(
      tag: widget.hero.id!,
      child: Image.network(
        widget.hero.image!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }

  Widget heroNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppConstants.horizontalPadding),
      child: Text(
        widget.hero.name!,
        style: AppConstants.titleTextStyleBlack,
      ),
    );
  }
}
