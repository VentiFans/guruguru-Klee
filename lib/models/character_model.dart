// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Character {
  int id;
  String name;
  AssetImage icon;
  String displayDescribeA;
  String displayDescribeB;
  String action;
  String actionLong;
  String engName;

  Character(this.id, this.name, this.icon, this.displayDescribeA,
      this.displayDescribeB, this.action, this.actionLong, this.engName,
      [clicktime = 0]);
}

class ChModel {
  static Character Klee =
      Character(0, "可莉", AssetImage("assets/head_icon/klee_head_icon.png"), "常去禁闭室的", "最活泼的小可爱", "哒", "哒哒哒", "Klee");

  static Character Nahida =
      Character(1, "纳西妲", AssetImage("assets/head_icon/nahida_head_icon.png"), "天天读心的", "最萝莉的神明", "呐", "呐呐", "Nahida");

  static Character Kirara = Character(
      2, "琦良良", AssetImage("assets/head_icon/kirara_head_icon.png"), "成天忙碌送货的", "最萌的猫又", "喵", "喵呜", "Kirara");

  static Character Dori = Character(3, "多莉", AssetImage("assets/head_icon/dori_head_icon.png"), "最爱钱的", "很会精打细算的小商人",
      " Duang ", "Duangduang", "Dori");

  static Character Barbara = Character(
      4, "芭芭拉", AssetImage("assets/head_icon/barbara_head_icon.png"), "奶水最够的", "最棒的蒙德偶像", "哼", "冲呀", "Barbara");

  static List<Character> characters = [Klee, Nahida, Kirara, Dori, Barbara];
  static List<String> charactersByIndex = [
    "Klee",
    "Nahida",
    "Kirara",
    "Dori",
    "Barbara"
  ];

  Character getCharacter(int index){
    return characters[index];
  }

  String getCharacterNameByIndex(int index){
    return charactersByIndex[index];
  }
}
