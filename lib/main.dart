import 'package:app/features/mainScrean/presentation/MainScreanUI.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "RPS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MainScreanUI(),
    ),
  );
}
