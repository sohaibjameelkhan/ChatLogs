import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatlogs/Infrastructure/Helpers/helper.dart';
import 'package:chatlogs/Infrastructure/Models/user_model.dart';
import 'package:chatlogs/Infrastructure/Services/user_services.dart';
import 'package:chatlogs/Presentation/Views/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Configurations/Colors.dart';
import '../../Infrastructure/Providers/user_provider.dart';
import '../../Configurations/res.dart';

class ListofUsers extends StatefulWidget {
  const ListofUsers({Key? key}) : super(key: key);

  @override
  State<ListofUsers> createState() => _ListofUsersState();
}

class _ListofUsersState extends State<ListofUsers> {
  UserServices userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return StreamProvider.value(
        value:
            userServices.streamAllUsers(FirebaseAuth.instance.currentUser!.uid),
        initialData: [UserModel()],
        builder: (context, child) {
          List<UserModel> userList = context.watch<List<UserModel>>();

          return Scaffold(
              backgroundColor: MyAppColors.whitecolor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "List of All Users",
                      style: TextStyle(
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(),
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userList.length,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            child: Container(
                              height: 110,
                              width: double.infinity,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                elevation: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  userList[i].userImage == null
                                                      ? CircleAvatar(
                                                          radius: 40,
                                                          backgroundImage:
                                                              AssetImage(Res
                                                                  .personicon),
                                                        )
                                                      : CachedNetworkImage(
                                                          height: 50,
                                                          width: 80,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                                width: 50.0,
                                                                height: 80.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              7),
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                          imageUrl: userList[i]
                                                              .userImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          progressIndicatorBuilder: (context,
                                                                  url,
                                                                  downloadProgress) =>
                                                              SpinKitWave(
                                                                  color: MyAppColors
                                                                      .appColor,
                                                                  size: 30,
                                                                  type: SpinKitWaveType
                                                                      .start),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error))
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  userList[i]
                                                      .fullName
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: MyAppColors
                                                          .blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(MessagesView(
                                                  receiverID: userList[i]
                                                      .userID
                                                      .toString(),
                                                  myID: getUserID(),
                                                  name: user
                                                      .getUserDetails()!
                                                      .fullName
                                                      .toString()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: MyAppColors.appColor),
                                              child: Center(
                                                child: Text(
                                                  "Message",
                                                  style: TextStyle(
                                                    color:
                                                        MyAppColors.whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ));
        });
  }
}
