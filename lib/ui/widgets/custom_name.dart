import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taylor_swift/constants/constants.dart';

class CustomerName extends StatelessWidget {
  final TextEditingController nameController;

  const CustomerName({Key? key, required this.nameController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: TextFormField(
          maxLength: 30,
          maxLines: 1,
          keyboardType: TextInputType.text,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: nameController,
          validator: (value) {
            return value!.trim().length < 3 ? "name required" : null;
          },
          decoration: InputDecoration(
            labelText: 'Customer\'s name',
            labelStyle: TextStyle(color: Colors.black),
            helperText: "name of customer",
            hintStyle: TextStyle(color: Colors.black),
            fillColor: Color(0xFFF5F5F5),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: tenDp),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF5F5F5))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF5F5F5))),
          )),
    );
  }
}
