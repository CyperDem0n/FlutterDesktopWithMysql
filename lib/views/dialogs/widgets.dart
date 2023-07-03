import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField(
        {required String hint, required TextEditingController controller}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 56.w),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffD9D9D9),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            hintText: hint),
      ),
    );
