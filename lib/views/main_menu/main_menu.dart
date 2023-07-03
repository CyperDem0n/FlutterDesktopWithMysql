import 'dart:developer';

import 'package:basic_crud_stuff/data/database/database_connection.dart';
import 'package:basic_crud_stuff/data/models/user.dart';
import 'package:basic_crud_stuff/views/dialogs/user_dialog.dart';
import 'package:basic_crud_stuff/views/main_menu/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Future<List<User>> fetchAllUsers() async {
    try {
      List<User> fetchedUsers = [];
      await DatabaseConn.getConnection().then((conn) async {
        String sql = 'select * from test.users;';
        await conn.query(sql).then((results) {
          if (results.isEmpty) throw "There are no users!";
          for (var row in results) {
            log("fetched : ${row.fields.toString()}");
            fetchedUsers.add(User.fromMap(row.fields));
          }
        }).catchError((e) {
          throw "An Error Occured while getting data from db";
        });
        conn.close();
      });
      return fetchedUsers;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: FutureBuilder<List<User>>(
        future: fetchAllUsers(),
        builder: (context, snapshot) {
          log('Building with snapshot = $snapshot');

          if (snapshot.connectionState == ConnectionState.done) {
            // future complete
            // if error or data is false return error widget
            log(snapshot.data!.length.toString());
            for (var user in snapshot.data!) {
              log(user.toMap().toString());
            }
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!
                        .map(
                          (user) => buildUserListTile(context, user, () {
                            setState(() {});
                          }),
                        )
                        .toList(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.white),
              ));
              // return data widget
            } else {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              );
            }

            // return loading widget while connection state is active
          } else
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          showPageAsDialog(
              context: context,
              child: const UserDialog(),
              onDone: () {
                setState(() {});
              });
        },
        backgroundColor: Colors.white.withOpacity(.8),
        label: Text(
          "Add new user",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
