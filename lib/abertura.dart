import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:estudo/main.dart';

class Abertura extends StatefulWidget {
  const Abertura({super.key});
  @override
  State <Abertura> createState() => _Estadofoto();
}

class _Estadofoto extends State<Abertura> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) =>  Telalogin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) =>
   Scaffold(
  body: Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
    image: AssetImage('assets/Primeiro.png'),
  fit: BoxFit.cover,

  ),
  )));
}

