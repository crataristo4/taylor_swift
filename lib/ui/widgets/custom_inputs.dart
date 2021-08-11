import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taylor_swift/constants/constants.dart';

class CustomerInputs extends StatelessWidget {
  final TextEditingController valueController;
  final imageSource;
  final name;
  final textColor;

  const CustomerInputs(
      {Key? key,
      required this.valueController,
      required this.imageSource,
      required this.name,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "$imageSource",
                scale: 1.0,
              ),
              SizedBox(
                width: eightDp,
              ),
              Container(
                width: sixtyDp,
                child: TextFormField(
                    maxLength: 5,
                    maxLines: 1,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                    ),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: valueController,
                    validator: (value) {
                      return value!.trim().isEmpty ? "*" : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Size',
                      labelStyle: TextStyle(color: Colors.black),
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
              ),
              /* Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(cm),
                ],
              )*/
            ],
          ),
          Text(
            name,
            style: TextStyle(
                color: textColor,
                fontSize: twelveDp,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
