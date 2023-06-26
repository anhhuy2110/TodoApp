import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * Style of Text, Button ...
 */

class FontFamily {
  static const sen = 'Sen';
}

class AppStyles {
  static const TextStyle h1 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 109.66, color: Colors.black);
  static const TextStyle h2 =  TextStyle(
      fontFamily: FontFamily.sen, fontSize: 67.77, color: Colors.black);
  static const TextStyle h3 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 41.89, color: Colors.black);
  static const TextStyle h4 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 25.89, color: Colors.black);
  static const TextStyle h5 =
      TextStyle(fontFamily: FontFamily.sen, fontSize: 16, color: Colors.black);
  static const TextStyle h6 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 9.89, color: Colors.black);

  static const TextStyle h2landing = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 67.77, color: Color(0xff777777), height: 0.5,fontWeight: FontWeight.bold);

  static const TextStyle h3HomePage = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 41.89, color: Colors.black);

  static const TextStyle h5text =
      TextStyle(fontFamily: FontFamily.sen, fontSize: 16, color: Colors.black);
  
}