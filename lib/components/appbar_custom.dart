import 'package:flutter/material.dart';
import 'package:sound_life/styles/styles.dart';

AppBar customAppBar() {
    return AppBar(
      title: Text('Song Life', style: CustomStyles().textoTitulo,),
    );
  }