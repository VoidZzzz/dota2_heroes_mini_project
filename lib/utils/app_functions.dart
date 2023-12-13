import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'app_enums.dart';

class AppFunctions {

  static Color getAttributeColor({required EnumPrimaryAttribute attribute}){
    if (attribute == EnumPrimaryAttribute.agility) {
      return Colors.green;
    } else if (attribute == EnumPrimaryAttribute.strength) {
      return Colors.red;
    } else if (attribute == EnumPrimaryAttribute.intelligence) {
      return Colors.blue;
    } else {
      return Colors.purpleAccent;
    }
  }

  static Widget getAttributeImage({required EnumPrimaryAttribute attribute}) {
    Widget imageWidget(String image) {
      return Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      );
    }

    if (attribute == EnumPrimaryAttribute.agility) {
      return imageWidget("assets/images/agility.jpeg");
    } else if (attribute == EnumPrimaryAttribute.strength) {
      return imageWidget("assets/images/strength.jpeg");
    } else if (attribute == EnumPrimaryAttribute.intelligence) {
      return imageWidget("assets/images/intel.jpeg");
    } else {
      return imageWidget("assets/images/universal.jpeg");
    }
  }

  static List<Widget> generateIcons({required List<EnumRoles> roles}) {
    Map<EnumRoles, IconData> roleIconMap = {
      EnumRoles.carry: TablerIcons.sword,
      EnumRoles.support: Iconsax.shield,
      EnumRoles.disabler: Iconsax.shapes,
      EnumRoles.nuker: TablerIcons.bomb,
      EnumRoles.initiator: TablerIcons.ad,
      EnumRoles.escape: TablerIcons.rocket,
      EnumRoles.pusher: TablerIcons.trees,
      EnumRoles.other: Icons.question_mark,
    };
    Map<EnumRoles, Color> roleColorMap = {
      EnumRoles.carry: Colors.red,
      EnumRoles.support: Colors.green,
      EnumRoles.disabler: Colors.purple,
      EnumRoles.nuker: Colors.black,
      EnumRoles.initiator: Colors.black,
      EnumRoles.escape: Colors.pink,
      EnumRoles.pusher: Colors.greenAccent,
      EnumRoles.other: Colors.grey,
    };

    List<Widget> icons = [];
    for (var role in roles) {
      IconData iconData = roleIconMap[role]!;
      Color iconColor = roleColorMap[role]!;
      icons.add(Icon(
        iconData,
        size: 30,
        color: iconColor,
      ));
    }
    return icons;
  }
}
