import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taylor_swift/constants/constants.dart';

class CustomNameAndNumber extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  static String? cc = '+233';

  const CustomNameAndNumber(
      {Key? key,
      required this.nameController,
      required this.phoneNumberController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   // String selectedCountryCode = '+233';
    void _onCountryChange(CountryCode countryCode) {
      //     selectedCountryCode = countryCode.toString();
      CustomNameAndNumber.cc = countryCode.toString();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        children: [
          //user name
          TextFormField(
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
          SizedBox(
            height: eightDp,
          ),
          //phone number
          TextFormField(
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.phone,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: phoneNumberController,
              validator: (value) {
                return value!.trim().length < 9
                    ? "phone number required"
                    : null;
              },
              decoration: InputDecoration(
                labelText: 'Customer\'s phone',
                labelStyle: TextStyle(color: Colors.black),
                helperText: "helps you to call customer",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Color(0xFFF5F5F5),
                filled: true,
                prefixIcon: CountryCodePicker(
                  onChanged: _onCountryChange,
                  showFlag: true,
                  initialSelection: CustomNameAndNumber.cc,
                  showOnlyCountryWhenClosed: false,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: tenDp),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF5F5F5))),
              ))
        ],
      ),
    );
  }
}
