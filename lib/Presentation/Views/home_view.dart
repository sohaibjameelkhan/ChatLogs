import 'package:chatlogs/Infrastructure/Services/auth_services.dart';
import 'package:chatlogs/Presentation/Views/login_screen.dart';
import 'package:chatlogs/Presentation/Views/recent_chat_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Infrastructure/Providers/user_provider.dart';
import 'list_of_users.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "HomeScreen");
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(RecentChatList());
                  },
                  child: Text("Go to chat list screen")),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(ListofUsers());
                  },
                  child: Text("Users List")),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    authServices.signOut().whenComplete(() {
                      Get.offAll(LoginScreen());
                      Fluttertoast.showToast(msg: "Logout SuccessFully");
                    });
                  },
                  child: Text("Logout")),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
