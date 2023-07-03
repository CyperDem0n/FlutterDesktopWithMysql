import 'dart:developer';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:basic_crud_stuff/data/database/database_connection.dart';
import 'package:basic_crud_stuff/data/models/user.dart';
import 'package:basic_crud_stuff/views/dialogs/user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildUserListTile(
    BuildContext context, User user, VoidCallback onReturn) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 36.w),
    margin: EdgeInsets.symmetric(vertical: 24.h),
    width: 1354.w,
    height: 100.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      gradient: LinearGradient(
        colors: [
          Color(0xFFF54C64),
          Color(0xFFF88161),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.userCircle,
              color: Colors.black,
              size: 42.sp,
            ),
            36.w.horizontalSpace,
            Text(
              "${user.email}",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                showPageAsDialog(
                  context: context,
                  child: UserDialog(user: user),
                  onDone: onReturn,
                );
              },
              child: Container(
                width: 54.sp,
                height: 54.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 35.sp,
                ),
              ),
            ),
            26.w.horizontalSpace,
            InkWell(
              onTap: () async {
                try {
                  await DatabaseConn.getConnection().then(
                    (conn) async {
                      var result = await conn
                          .query(
                              "DELETE FROM `users` WHERE user_id=${user.user_id}")
                          .then(
                        (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text("user has been deleted"),
                              ),
                            ),
                          );

                          onReturn();
                        },
                      ).onError(
                        (error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                    "An Error occured while adding this user"),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } catch (e) {
                  rethrow;
                }
              },
              child: Container(
                width: 54.sp,
                height: 54.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC5C8CD),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 35.sp,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

AppBar buildAppbar() {
  return AppBar(
    leadingWidth: 1440.w / 2,
    leading: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ),
          15.w.horizontalSpace,
          const FittedBox(
            child: Text(
              "Current User : ryu",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

void showPageAsDialog({
  required BuildContext context,
  required Widget child,
  required VoidCallback onDone,
  // required Future<void> fetch,
}) async {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrollable: true,
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    content: Builder(builder: (context) {
      return child;
    }),
  );
  await showDialog(
    barrierColor: Color(0x6A000000),
    useSafeArea: true,
    barrierDismissible: false,
    context: context,
    builder: (context) => alertDialog,
  ).then((_) {
    onDone();
    log("closed");
  });
  // .then((value) async {
  // await fetch;
  // });
}
