import 'package:flutter/material.dart';

import 'not_hesaplama_arayuzu.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.green[800],
    ),
    home: NotHesaplamaArayuzu(),
  ));
}
