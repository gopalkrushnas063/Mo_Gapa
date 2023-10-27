import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final makeListTile = ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  leading: Container(
    padding: const EdgeInsets.only(right: 12.0),
    decoration: const BoxDecoration(
      border: Border(
        right: BorderSide(width: 1.0, color: Colors.orange),
      ),
    ),
    child: SvgPicture.asset(
      "assets/images/adventure.svg",
      width: 32,
      height: 32,
      color: Colors.indigo,
    ),
  ),
  title: const Text(
    "କୁହୁକ ଚଢେଇ କଥା",
    style: TextStyle(
        color: Colors.indigo, fontSize: 21, fontWeight: FontWeight.bold),
  ),
  subtitle: const Row(
    children: <Widget>[
      Icon(Icons.linear_scale, color: Colors.orange),
      Text(
        " ଦୁଃସାହସିକତା",
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
      )
    ],
  ),
  trailing:
      const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),
);
