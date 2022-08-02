import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Configurations/Colors.dart';

customAppBar(
    {required String text,
    bool showBackArrow = false,
    bool showSearch = false,
    bool showSettings = false,
    bool showAddIcon = false,
    bool centerTitle = false,
    VoidCallback? onSearchTap,
    VoidCallback? onSettingTap,
    VoidCallback? onAddIconTap}) {
  return AppBar(
    actions: [
      if (showSearch)
        InkWell(
          onTap: () => onSearchTap!(),
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.search,
              color: MyAppColors.appColor,
              size: 25,
            ),
          ),
        ),
      if (showAddIcon)
        InkWell(
          onTap: () => onAddIconTap!(),
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.add,
              color: MyAppColors.appColor,
              size: 25,
            ),
          ),
        ),
      if (showSettings)
        InkWell(
          onTap: () => onSettingTap!(),
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/icons/app_icons/settings.svg',
              color: MyAppColors.appColor,
              height: 20,
              width: 20,
            ),
          ),
        ),
    ],
    centerTitle: centerTitle,
    leading: showBackArrow
        ? InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.arrow_back,
                color: MyAppColors.appColor,
                size: 25,
              ),
            ),
          )
        : null,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        text,
        style: TextStyle(color: MyAppColors.appColor),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
