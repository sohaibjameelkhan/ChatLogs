import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../Infrastructure/Models/message.dart';
import '../../Infrastructure/Models/user.dart';
import '../../Infrastructure/Models/user_model.dart';
import '../../Infrastructure/Providers/user_provider.dart';
import '../Widgets/app_bar.dart';
import '../../Infrastructure/Services/chat.dart';
import '../Widgets/chat_tile.dart';
import '../../Infrastructure/Services/farmer.dart';
import '../../Infrastructure/Models/message_details.dart';
import 'messages.dart';

class RecentChatList extends StatefulWidget {
  const RecentChatList(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  _RecentChatListState createState() => _RecentChatListState();
}

class _RecentChatListState extends State<RecentChatList> {
  ChatServices _chatServices = ChatServices();
  bool initialized = false;
  UserModel userModel = UserModel();
  ExpertServices _userServices = ExpertServices();
  FarmerServices _farmerServices = FarmerServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: _buildUI(context, user.getUserDetails()!),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance
        .setCurrentScreen(screenName: "recentchatlistscreen");
  }

  Widget _buildUI(BuildContext context, UserModel _userModel) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: customAppBar(text: 'Recent Chats', showSearch: true),
      body: _getUI(context, _userModel),
    );
  }

  Widget _getUI(BuildContext context, UserModel _model) {
    var user = Provider.of<UserProvider>(context);

    return Column(
      children: [
        Divider(),
        Expanded(
          child: StreamProvider.value(
            value: _chatServices.streamChatList(myID: _model.docId.toString()),
            initialData: [ChatDetailsModel()],
            builder: (context, child) {
              List<ChatDetailsModel> chatDetailsList =
                  context.watch<List<ChatDetailsModel>>();
              return chatDetailsList.isEmpty
                  ? Text("No Data Found")
                  : chatDetailsList[0].myID == null
                      ? Container(
                          height: MediaQuery.of(context).size.height - 150,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [CircularProgressIndicator()],
                          ),
                        )
                      : chatDetailsList.length != 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: chatDetailsList.length,
                              itemBuilder: (context, i) {
                                return StreamProvider.value(
                                  value: _chatServices.getUnreadMessageCounter(
                                      myID: user
                                          .getUserDetails()!
                                          .docId
                                          .toString(),
                                      receiverID: chatDetailsList[i]
                                          .otherID
                                          .toString()),
                                  initialData: [MessagesModel()],
                                  builder: (unReadContext, child) {
                                    List<MessagesModel> unReadMessagesList =
                                        unReadContext
                                            .watch<List<MessagesModel>>();
                                    return StreamProvider.value(
                                      value: _farmerServices.getUserDetails(
                                          chatDetailsList[i]
                                              .otherID
                                              .toString()),
                                      initialData: UserModel(),
                                      builder: (userContext, child) {
                                        UserModel chatUserModel =
                                            userContext.watch<UserModel>();
                                        return chatUserModel.userID == null
                                            ? CircularProgressIndicator()
                                            : InkWell(
                                                onTap: () {
                                                  ChatDetailsModel _model =
                                                      chatDetailsList[i];
                                                  setState(() {});
                                                  // return;
                                                  pushNewScreen(context,
                                                      screen: MessagesView(
                                                        receiverID: _model
                                                            .otherID
                                                            .toString(),
                                                        name: chatUserModel
                                                            .fullName
                                                            .toString(),
                                                        myID: user
                                                            .getUserDetails()!
                                                            .docId
                                                            .toString(),
                                                      ),
                                                      withNavBar: false);
                                                },
                                                child: ChatTile(
                                                  image: chatUserModel.userImage
                                                      .toString(),
                                                  title: chatUserModel.fullName
                                                      .toString(),
                                                  description:
                                                      chatDetailsList[i]
                                                              .recentMessage ??
                                                          "",
                                                  time: chatDetailsList[i]
                                                      .time
                                                      .toString(),
                                                  counter: unReadMessagesList
                                                              .length ==
                                                          1
                                                      ? unReadMessagesList[0]
                                                                  .docID ==
                                                              null
                                                          ? 0
                                                          : unReadMessagesList
                                                              .length
                                                      : unReadMessagesList
                                                          .length,
                                                ),
                                              );
                                      },
                                    );
                                  },
                                );
                              })
                          : Text("No Data Found");
            },
          ),
        )
      ],
    );
  }
}
