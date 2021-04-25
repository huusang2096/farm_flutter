// To parse this JSON data, do
//
//     final gardenResponse = gardenResponseFromJson(jsonString);

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GardenMenu {
  IconData icon;
  ActionTypeMenu acitonType;

  GardenMenu({this.icon, this.acitonType});

  List<GardenMenu> getListMenu() {
    List<GardenMenu> list = [];
    list.add(new GardenMenu(
        icon: Icons.remove_red_eye, acitonType: ActionTypeMenu.view));
    list.add(new GardenMenu(icon: Icons.edit, acitonType: ActionTypeMenu.edit));
    list.add(new GardenMenu(
        icon: Icons.close_rounded, acitonType: ActionTypeMenu.delete));
    list.add(new GardenMenu(
        icon: Icons.menu_outlined, acitonType: ActionTypeMenu.menu));
    return list;
  }
}

enum ActionTypeMenu { view, edit, delete, menu }
