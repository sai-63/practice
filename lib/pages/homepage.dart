import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/Logics/functions.dart';
import 'package:practice/pages/App_Style.dart';
import 'package:practice/pages/chatpage.dart';
import 'package:intl/intl.dart';
import 'package:practice/comps/styles.dart';
import 'package:practice/comps/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Functions.updateAvailability();
    super.initState();
  }

  final firestore = FirebaseFirestore.instance;
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        title: const Text('My Chat'),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  open == true ? open = false : open = true;
                });
              },
              icon: Icon(
                open == true ? Icons.close_rounded : Icons.search_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      drawer: ChatWidgets.drawer(context),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(8),
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                          child: Text(
                            'Recent Chats',
                            style: Styles.h1(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          child: StreamBuilder(
                            stream: firestore.collection('Rooms').snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }

                              final roomData = snapshot.data!.docs;
                              List<QueryDocumentSnapshot> data = roomData
                                  .where((element) =>
                                  element['users']
                                      .toString()
                                      .contains(FirebaseAuth.instance.currentUser!.uid))
                                  .toList();

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, i) {
                                  List users = data[i]['users'];
                                  var friend = users.where((element) => element !=
                                      FirebaseAuth.instance.currentUser!.uid);
                                  var user = friend.isNotEmpty
                                      ? friend.first
                                      : users.where((element) =>
                                  element ==
                                      FirebaseAuth.instance.currentUser!.uid).first;

                                  return FutureBuilder(
                                    future: firestore.collection('Users').doc(user).get(),
                                    builder: (context, AsyncSnapshot snap) {
                                      if (!snap.hasData || !snap.data.exists) {
                                        return Container();
                                      }

                                      final userData = snap.data.data();

                                      if (userData == null) {
                                        return Container();
                                      }

                                      final userName = userData.containsKey('name')
                                          ? userData['name']
                                          : '';

                                      return ChatWidgets.circleProfile(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ChatPage(
                                                  id: user,
                                                  name: userName,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        name: userName,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Friends',
                            style: Styles.h1().copyWith(color: Colors.indigo),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: StreamBuilder(
                              stream: firestore.collection('Rooms').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                List data = !snapshot.hasData
                                    ? []
                                    : snapshot.data!.docs.where((element) =>
                                    element['users']
                                        .toString()
                                        .contains(FirebaseAuth.instance.currentUser!.uid))
                                    .toList();
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, i) {
                                    List users = data[i]['users'];
                                    var friend = users.where((element) =>
                                    element != FirebaseAuth.instance.currentUser!.uid);
                                    var user = friend.isNotEmpty
                                        ? friend.first
                                        : users.where((element) =>
                                    element == FirebaseAuth.instance.currentUser!.uid).first;

                                    return FutureBuilder(
                                      future: firestore.collection('Users').doc(user).get(),
                                      builder: (context, AsyncSnapshot snap) {
                                        if (!snap.hasData || !snap.data.exists) {
                                          return Container();
                                        }

                                        final userData = snap.data.data();

                                        if (userData == null) {
                                          return Container();
                                        }

                                        final userName = userData['name'];

                                        final lastMessage = data[i].data().containsKey('last_message')
                                            ? data[i]['last_message']
                                            : '';
                                        final lastMessageTime = data[i].data().containsKey('last_message_time')
                                            ? DateFormat('hh:mm a').format(data[i]['last_message_time'].toDate())
                                            : '';

                                        return ChatWidgets.card(
                                          title: userName,
                                          subtitle: lastMessage,
                                          time: lastMessageTime,
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ChatPage(
                                                    id: user,
                                                    name: userName,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ChatWidgets.searchBar(open),
          ],
        ),
      ),
    );
  }
}
