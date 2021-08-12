import 'package:flutter/material.dart';
import 'package:taylor_swift/enum/enums.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/service/dress_service.dart';

class DressProvider with ChangeNotifier {
  DressService _dressService = DressService();
  final DateTime timestamp = DateTime.now();
  Dress? dress;
  String? _bust;
  String? _waist;
  String? _hip;
  String? _shoulder;
  String? _shoulderToWaist;
  String? _nippleToNipple;
  String? _shoulderToNipple;
  String? _sleeveLength;
  String? _aroundArm;
  String? _topLength;
  String? _knee;
  String? _skirtLength;
  String? _dressLength;
  String? _ankle;
  String? _trouserLength;
  String? _crotch;
  String? _collar;
  String? _chest;
  String? _cuff;
  String? _thigh;
  String? _bar;
  String? _seat;
  String? _flap;
  String? _paymentStatus;
  String? _dueDate;
  int? _initialPayment;
  int? _serviceCharge;
  String? _phoneNumber;
  String? _name;
  String? _type;
  String? _month;

  get getName => _name;

  get getNumber => _phoneNumber;

  get getWaist => _waist;

  get getHip => _hip;

  get getKnee => _knee;

  get getSkirtLength => _skirtLength;

  get getInitialPayment => _initialPayment;

  get getPaymentStatus => _paymentStatus;

  get getDueDate => _dueDate;

  get getServiceCharge => _serviceCharge;

  get getMonth => _month;

  //ladies skirt
  setLsData(String name, String phoneNumber, waist, hip, knee, skirtLength,
      month, serviceCharge, initialPayment, dueDate, status) {
    _name = name;
    _phoneNumber = phoneNumber;
    _waist = waist;
    _hip = hip;
    _knee = knee;
    _skirtLength = skirtLength;
    _month = month;
    _serviceCharge = serviceCharge;
    _initialPayment = initialPayment;
    _dueDate = dueDate;
    _paymentStatus = status;

    notifyListeners();
  }

  setDueDate(String? dueDate) {
    _dueDate = dueDate;
    notifyListeners();
  }

  setPayment(int? payment) {
    _initialPayment = payment;

    notifyListeners();
  }

  setPaymentStatus(paymentStatus) {
    _paymentStatus = paymentStatus;
    notifyListeners();
  }

  createNewDress(BuildContext context, DressType dressType) {
    switch (dressType) {
      case DressType.LADIES_SKIRT:
        dress = Dress(
            name: getName,
            phoneNumber: getNumber,
            waist: getWaist,
            hip: getHip,
            knee: getKnee,
            skirtLength: getSkirtLength,
            initialPayment: getInitialPayment,
            paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: 'ls',
            month: getMonth);

        break;
      case DressType.LADIES_DRESS:
        // TODO: Handle this case.
        break;
      case DressType.LADIES_TOP:
        // TODO: Handle this case.
        break;
      case DressType.LADIES_TROUSER:
        // TODO: Handle this case.
        break;
      case DressType.MENS_DRESS:
        // TODO: Handle this case.
        break;
      case DressType.MENS_TOP:
        // TODO: Handle this case.
        break;
      case DressType.MENS_TROUSER:
        // TODO: Handle this case.
        break;
    }

    print(
        "values ?? -- $getName '-' $getDueDate '-' $getInitialPayment $getPaymentStatus ? $getKnee ");

    _dressService.createNewDress(dress!, context);
  }
}
