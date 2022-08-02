import 'package:booster/booster.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../Configurations/Colors.dart';

class ChatTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final bool isChat;
  final int? counter;

  ChatTile(
      {required this.image,
      required this.title,
      required this.description,
      required this.time,
      this.counter,
      this.isChat = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Booster.dynamicFontSize(
                label: title,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Booster.dynamicFontSize(
                label: description,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0x991A1A1A),
              ),
            ),
            trailing: _getBadge(counter!)),
        Divider()
      ],
    );
  }

  _getBadge(int counter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Booster.dynamicFontSize(
          label: time.toString(),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0x991A1A1A),
        ),
        if (counter != 0) Booster.verticalSpace(3),
        if (counter != 0)
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: MyAppColors.appColor),
            child: Center(
              child: Text(
                counter.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }
}
