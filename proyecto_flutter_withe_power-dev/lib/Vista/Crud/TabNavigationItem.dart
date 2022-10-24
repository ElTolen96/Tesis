import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_withe_power/Vista/Crud/EntradaUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/FavoritoUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/HomePage.dart';
import 'package:proyecto_withe_power/Vista/Crud/prueba.dart';
import 'package:proyecto_withe_power/Vista/Iniciales/Login.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: HomePage(),
      icon: Icon(Icons.home),
      title: Text("Home"),
    ),
    TabNavigationItem(
      page: EntradaUsuario(),
      icon: Icon(Icons.search),
      title: Text("Search"),
    ),
    TabNavigationItem(
      page: FavoritoUsuario(),
      icon: Icon(Icons.home),
      title: Text("Home"),
    ),
  ];
}