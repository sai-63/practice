import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/chatpage.dart';

class AnimatedDialog extends StatefulWidget {
  final double height;
  final double width;

  const AnimatedDialog({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  final firestore = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();
  StreamSubscription<QuerySnapshot>? usersSubscription;
  List<DocumentSnapshot> users = [];

  @override
  void initState() {
    super.initState();
    if (widget.height != 0) {
      Timer(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() {
            usersSubscription = firestore
                .collection('Users')
                .orderBy('name') // Order the users by name
                .snapshots()
                .listen((QuerySnapshot snapshot) {
              setState(() {
                users = snapshot.docs;
              });
            });
          });
        }
      });
    }
  }

  @override
  void dispose() {
    usersSubscription?.cancel();
    super.dispose();
  }

  void _filterUsers(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        users = [];
      });
      return;
    }

    firestore
        .collection('Users')
        .orderBy('name')
        .where('name', isGreaterThanOrEqualTo: searchText)
        .where('name', isLessThan: searchText + 'z')
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        users = snapshot.docs;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.width == 0
                ? Colors.indigo.withOpacity(0)
                : Colors.indigo.shade400,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.width == 0 ? 100 : 0),
              bottomRight: Radius.circular(widget.width == 0 ? 100 : 0),
              bottomLeft: Radius.circular(widget.width == 0 ? 100 : 0),
            ),
          ),
          child: widget.width == 0
              ? null
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: _filterUsers,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search users',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              searchController.clear();
                              _filterUsers('');
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, i) {
                          Timestamp time = users[i]['date_time'] as Timestamp;
                          DateTime dateTime = time.toDate();
                          return ListTile(
                            title: Text(
                              users[i]['name'] as String,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              DateFormat('EEE hh:mm').format(dateTime),
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatPage(
                                      id: users[i].id.toString(),
                                      name: users[i]['name'] as String,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
