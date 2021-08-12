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
  String? _back;
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

  get getBack => _back;

  get getDressLength => _dressLength;

  get getTrouserLength => _trouserLength;

  get getSleeveLength => _sleeveLength;

  get getThigh => _thigh;

  get getBar => _bar;

  get getCollar => _collar;

  get getChest => _chest;

  get getCuff => _cuff;

  get getAroundArm => _aroundArm;

  get getSeat => _seat;

  get getFlap => _flap;

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

  //men's top
  setMensTopData(
    String name,
    String phoneNumber,
    length,
    back,
    sleeve,
    collar,
    chest,
    aroundArm,
    cuff,
    month,
    serviceCharge,
    initialPayment,
    dueDate,
    status,
  ) {
    _name = name;
    _phoneNumber = phoneNumber;
    _dressLength = length;
    _back = back;
    _sleeveLength = sleeve;
    _collar = collar;
    _chest = chest;
    _aroundArm = aroundArm;
    _cuff = cuff;
    _month = month;
    _serviceCharge = serviceCharge;
    _initialPayment = initialPayment;
    _dueDate = dueDate;
    _paymentStatus = status;

    notifyListeners();
  }

  //men's trouser
  setMensTrouserData(
    String name,
    String phoneNumber,
    trouserLength,
    waist,
    thigh,
    bar,
    seat,
    knee,
    flap,
    month,
    serviceCharge,
    initialPayment,
    dueDate,
    status,
  ) {
    _name = name;
    _phoneNumber = phoneNumber;
    _trouserLength = trouserLength;
    _waist = waist;
    _thigh = thigh;
    _bar = bar;
    _seat = seat;
    _knee = knee;
    _flap = flap;
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
        dress = Dress(
            name: getName,
            phoneNumber: getNumber,
            dressLength: getDressLength,
            back: getBack,
            sleeveLength: getSleeveLength,
            collar: getCollar,
            cuff: getCuff,
            chest: getChest,
            waist: getWaist,
            aroundArm: getAroundArm,
            initialPayment: getInitialPayment,
            paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: 'mt',
            month: getMonth);
        break;
      case DressType.MENS_TROUSER:
        dress = Dress(
            name: getName,
            phoneNumber: getNumber,
            dressLength: getDressLength,
            trouserLength: getTrouserLength,
            waist: getWaist,
            thigh: getThigh,
            bar: getBar,
            seat: getSeat,
            knee: getKnee,
            flap: getFlap,
            initialPayment: getInitialPayment,
            paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: 'mtr',
            month: getMonth);
        break;
    }

    print(
        "values ?? -- $getWaist '-' $getSeat '-' $getInitialPayment $getPaymentStatus ? $getAroundArm ");

    // _dressService.createNewDress(dress!, context);
  }
}
