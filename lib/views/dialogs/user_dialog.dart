import 'dart:developer';

import 'package:basic_crud_stuff/data/database/database_connection.dart';
import 'package:basic_crud_stuff/views/dialogs/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/user.dart';

class UserDialog extends StatefulWidget {
  final User? user;
  const UserDialog({super.key, this.user});

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  int? userId;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    if (widget.user != null) {
      userId = widget.user!.user_id!;
      usernameController.text = widget.user!.username!;
      emailController.text = widget.user!.email!;
      passwordController.text = widget.user!.password!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 852.w,
      height: 560.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xFF242A38),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.user == null ? "Add user" : "Edit user"),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            buildTextField(controller: usernameController, hint: "Username"),
            buildTextField(controller: emailController, hint: "Email"),
            buildTextField(controller: passwordController, hint: "Password"),
            20.h.verticalSpace,
            Builder(builder: (context) {
              return buildSaveButton(context);
            })
          ],
        ),
      ),
    );
  }

  Future<void> addUser() async {
    try {
      await DatabaseConn.getConnection().then((conn) async {
        var result = await conn
            .query(
                "INSERT INTO `users`(`email`, `username`, `password`) VALUES ('${emailController.text}','${usernameController.text}','${passwordController.text}')")
            .then((result) {
          Navigator.of(context).pop();
        }).onError((error, stackTrace) =>
                throw "An Error occured while adding this user");
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editUser() async {
    try {
      await DatabaseConn.getConnection().then((conn) async {
        await conn
            .query(
                "UPDATE `users` SET `email`='${emailController.text}',`username`='${usernameController.text}',`password`='${passwordController.text}' WHERE user_id=$userId")
            .then((result) {
          Navigator.of(context).pop();
        }).onError((error, stackTrace) =>
                throw "An Error occured while Editing this user");
      });
    } catch (e) {
      rethrow;
    }
  }

  Widget buildSaveButton(BuildContext ctx) {
    return InkWell(
      onTap: () async {
        if (widget.user != null) {
          await editUser().onError(
            (error, stackTrace) => ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(error.toString()),
                ),
              ),
            ),
          );
        } else {
          await addUser().onError(
            (error, stackTrace) => ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(error.toString()),
                ),
              ),
            ),
          );
        }
      },
      child: Container(
        color: Color(0xFF4E596F),
        width: 344.w,
        height: 64.h,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FittedBox(fit: BoxFit.fitHeight, child: Text("Save")),
      ),
    );
  }
}
