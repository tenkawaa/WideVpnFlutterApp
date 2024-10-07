import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var navBar = CupertinoNavigationBar(
  leading: const Row(
    children: [
      Text("WIDE", style: TextStyle(fontWeight: FontWeight.w900)),
      SizedBox(width: 8),
      Text("VPN"),
    ],
  ),
  trailing: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        onPressed: () => debugPrint("buy premium"),
        icon: const Icon(
            CupertinoIcons.arrow_up_circle_fill,
        ),
        color: const CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.black,
            darkColor: CupertinoColors.white
        ),
        iconSize: 23,
        focusColor: CupertinoColors.transparent,
      ),
      const Text("Buy Premium", style: TextStyle(fontWeight: FontWeight.bold))
    ],
  ),
  border: const Border(bottom: BorderSide(color: CupertinoColors.transparent)),
);

const itemsAppBar = [
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.tray_arrow_down)),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.tray_2)),
];