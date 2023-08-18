import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_main_screen.dart';
import 'package:unuseful/src/home/view/home_screen.dart';
import 'package:unuseful/src/meal/view/meal_screen.dart';
import 'package:unuseful/src/patient/view/patient_screen.dart';
import 'package:unuseful/src/specimen/view/specimen_main_screen.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';

class MenuModel {
  final IconData icon;
  final String menuName;
  final String routeName;

  MenuModel({
    required this.icon,
    required this.menuName,
    required this.routeName,
  });

  static MenuModel getMenuInfo (String routeName){
    return menus.firstWhere((element) => element.routeName == routeName);
  }

}

List<MenuModel> menus = [
  MenuModel(
      icon: Icons.home_filled,
      menuName: '홈',
      routeName: HomeScreen.routeName),
  MenuModel(
      icon: Icons.phone_android,
      menuName: '전화번호',
      routeName: TelePhoneMainScreen.routeName),
  MenuModel(
      icon: Icons.set_meal, menuName: '식단', routeName: MealScreen.routeName),
  MenuModel(
      icon: Icons.edit_note,
      menuName: '진검 검사결과',
      routeName: SpecimenMainScreen.routeName),
  MenuModel(
      icon: Icons.local_hospital,
      menuName: '재원 환자',
      routeName: PatientScreen.routeName),
  MenuModel(
      icon: Icons.calendar_month,
      menuName: '전산정보팀 일정',
      routeName: HitScheduleMainScreen.routeName),
];




