import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/provider/dress_provider.dart';
import 'package:taylor_swift/ui/pages/ladies/ladies_skirt.dart';

class CustomDtPmt extends StatefulWidget {
  final dateTimeController;
  final paymentController;
  final Function? onTap;

//  static String? selectedPayment;
  const CustomDtPmt(
      {Key? key,
      required this.dateTimeController,
      required this.paymentController,
      required this.onTap})
      : super(key: key);

  @override
  _CustomDtPmtState createState() => _CustomDtPmtState();
}

class _CustomDtPmtState extends State<CustomDtPmt> {
  String? selectedPayment;
  DressProvider _dressProvider = DressProvider();

  //date format
  DateFormat _dateFormat = DateFormat.yMMMMd('en_US').add_jm();
  DateTime _dateTime = DateTime.now();

  //get date
  Future<DateTime?> _selectDate(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));

  //get time
  Future<TimeOfDay?> _selectedTime(BuildContext context) {
    final timeNow = DateTime.now();
    return showTimePicker(
        context: context,
        cancelText: "",
        initialTime: TimeOfDay(hour: timeNow.hour, minute: timeNow.minute));
  }

  @override
  void initState() {
    setState(() {
      selectedPayment = notPaid;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dressProvider.setPaymentStatus(selectedPayment);
    return Container(
      margin: EdgeInsets.symmetric(vertical: eightDp, horizontal: eightDp),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(fourDp),
            margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
            child: TextFormField(
                maxLength: 10,
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: widget.paymentController,
                onChanged: (value) {
                  /* setState(() {
                    _dressProvider.setPayment(int.parse(value));

                  });*/
                },
                validator: (value) {
                  return value!.trim().isEmpty ? "required" : null;
                },
                decoration: InputDecoration(
                  labelText: serviceCharge,
                  labelStyle: TextStyle(color: Colors.black),
                  helperText: serviceChargeDes,
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
          SizedBox(
            height: twentyDp,
          ),
          Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
            child: TextFormField(
                maxLength: 10,
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: widget.paymentController,
                onChanged: (value) {
                  /* setState(() {
                    _dressProvider.setPayment(int.parse(value));

                  });*/
                },
                validator: (value) {
                  return value!.trim().isEmpty ? "required" : null;
                },
                decoration: InputDecoration(
                  labelText: payment,
                  labelStyle: TextStyle(color: Colors.black),
                  helperText: enterZero,
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
          SizedBox(
            height: twentyDp,
          ),
          buildPaymentMode(),
          SizedBox(
            height: eightDp,
          ),
          Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
            child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                controller: widget.dateTimeController,
                onTap: () async => widget.onTap,
                validator: (value) {
                  return value!.trim().length < 3 ? dueDateRequired : null;
                },
                decoration: InputDecoration(
                  labelText: dueDate,
                  labelStyle: TextStyle(color: Colors.black),
                  helperText: timeToComplete,
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
        ],
      ),
    );
  }

  Widget buildPaymentMode() {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(eightDp),
          border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
      child: DropdownButtonFormField<String>(
        value: selectedPayment,
        elevation: 1,
        isExpanded: true,
        style: TextStyle(color: Color(0xFF424242)),
        // underline: Container(),
        items: [
          notPaid,
          partPayment,
          fullPayment,
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedPayment = value;
            LadiesSkirt.paymentStatus = selectedPayment!;
          });
          _dressProvider.setPaymentStatus(selectedPayment);
        },
      ),
    );
  }
}
