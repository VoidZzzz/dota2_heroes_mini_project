import 'package:dota_heroes_app/utils/app_enums.dart';

class HeroModel {
  int? id;
  String? name;
  EnumPrimaryAttribute? primaryAttribute;
  String? attackType;
  List<EnumRoles>? roles;
  String? image;

  HeroModel(
      {required this.id,
      required this.primaryAttribute,
      required this.name,
      required this.image,
      required this.attackType,
      required this.roles});

  factory HeroModel.fromJson({required Map<String, dynamic> json}) {
    EnumRoles convertToEnum(String role) {
      var tempEnum = EnumRoles.carry;
      if (role.toString().toUpperCase() == "CARRY") {
        tempEnum = EnumRoles.carry;
      } else if (role.toString().toUpperCase() == "SUPPORT") {
        tempEnum = EnumRoles.support;
      } else if (role.toString().toUpperCase() == "NUKER") {
        tempEnum = EnumRoles.nuker;
      } else if (role.toString().toUpperCase() == "DISABLER") {
        tempEnum = EnumRoles.disabler;
      } else if (role.toString().toUpperCase() == "ESCAPE") {
        tempEnum = EnumRoles.escape;
      } else if (role.toString().toUpperCase() == "INITIATOR") {
        tempEnum = EnumRoles.escape;
      } else if (role.toString().toUpperCase() == "PUSHER") {
        tempEnum = EnumRoles.pusher;
      } else {
        tempEnum = EnumRoles.other;
      }
      return tempEnum;
    }

    var tempAttribute = EnumPrimaryAttribute.universal;

    if (json['primary_attr'].toString().toUpperCase() == "STR") {
      tempAttribute = EnumPrimaryAttribute.strength;
    } else if (json['primary_attr'].toString().toUpperCase() == "AGI") {
      tempAttribute = EnumPrimaryAttribute.agility;
    } else if (json['primary_attr'].toString().toUpperCase() == "INT") {
      tempAttribute = EnumPrimaryAttribute.intelligence;
    } else if (json['primary_attr'].toString().toUpperCase() == "ALL") {
      tempAttribute = EnumPrimaryAttribute.universal;
    }

    List<EnumRoles> tempRoles = [];

    for (var r in json['roles']) {
      tempRoles.add(convertToEnum(r));
    }

    return HeroModel(
        id: json['id'] ?? 0,
        primaryAttribute: tempAttribute,
        name: json['localized_name'] ?? "",
        image: json['imageUrl'] ?? "",
        attackType: json['attack_type'] ?? "",
        roles: tempRoles);
  }
}
