import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/enum/enums.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/service/dress_service.dart';
import 'package:taylor_swift/ui/home/home.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:uuid/uuid.dart';

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
  String? _dueDate;
  int? _initialPayment;
  int? _serviceCharge;
  String? _phoneNumber;
  String? _name;
  String? _back;
  String? _month;
  String? _type;
  String? _id;
  var _uuid = Uuid();

  get getName => _name;

  get getNumber => _phoneNumber;

  get getWaist => _waist;

  get getHip => _hip;

  get getKnee => _knee;

  get getType => _type;

  get getSkirtLength => _skirtLength;

  get getInitialPayment => _initialPayment;

//  get getPaymentStatus => _paymentStatus;

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

  get getAnkle => _ankle;

  get getCrotch => _crotch;

  get getShoulder => _shoulder;

  get getBust => _bust;

  get getNipToNip => _nippleToNipple;

  get getShoToNip => _shoulderToNipple;

  get getShoToWaist => _shoulderToWaist;

  get getTopLength => _topLength;

  //ladies dress
  setLadiesDressData(
    String name,
    String phoneNumber,
    shoulder,
    bust,
    nipToNip,
    shoToNip,
    hip,
    waist,
    shoToWaist,
    knee,
    dreesLength,
    sleeveLength,
    aroundArm,
    month,
    serviceCharge,
    initialPayment,
    dueDate,
    trouserLength,
  ) {
    _name = name;
    _phoneNumber = phoneNumber;
    _shoulder = shoulder;
    _bust = bust;
    _nippleToNipple = nipToNip;
    _shoulderToNipple = shoToNip;
    _hip = hip;
    _waist = waist;
    _shoulderToWaist = shoToWaist;
    _knee = knee;
    _dressLength = dreesLength;
    _sleeveLength = sleeveLength;
    _aroundArm = aroundArm;
    _month = month;
    _serviceCharge = serviceCharge;
    _initialPayment = initialPayment;
    _dueDate = dueDate;
    _trouserLength = trouserLength;

    notifyListeners();
  }

  //ladies skirt
  setLsData(String name, String phoneNumber, waist, hip, knee, skirtLength,
      month, serviceCharge, initialPayment, dueDate) {
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
    // _paymentStatus = status;

    notifyListeners();
  }

  //ladies top
  setLadiesTopData(
    String name,
    String phoneNumber,
    shoulder,
    bust,
    nipToNip,
    shoToNip,
    waist,
    hip,
    shoToWaist,
    aroundArm,
    topLength,
    month,
    serviceCharge,
    initialPayment,
    dueDate,
    // status,
  ) {
    _name = name;
    _phoneNumber = phoneNumber;
    _shoulder = shoulder;
    _bust = bust;
    _nippleToNipple = nipToNip;
    _shoulderToNipple = shoToNip;
    _waist = waist;
    _hip = hip;
    _shoulderToWaist = shoToWaist;
    _aroundArm = aroundArm;
    _month = month;
    _serviceCharge = serviceCharge;
    _initialPayment = initialPayment;
    _dueDate = dueDate;
    //  _paymentStatus = status;

    notifyListeners();
  }

  //ladies trouser
  setLtrData(String name, String phoneNumber, trouserLength, waist, hip, knee,
      ankle, crotch, month, serviceCharge, initialPayment, dueDate) {
    _name = name;
    _phoneNumber = phoneNumber;
    _trouserLength = trouserLength;
    _waist = waist;
    _hip = hip;
    _knee = knee;
    _ankle = ankle;
    _crotch = crotch;
    _month = month;
    _serviceCharge = serviceCharge;
    _initialPayment = initialPayment;
    _dueDate = dueDate;
    //_paymentStatus = status;

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
      //  status,
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
    //_paymentStatus = status;

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
      // status,
    type,
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
    // _paymentStatus = status;
    _type = type;

    notifyListeners();
  }

  //men's dress
  setMensDressData(
    String name,
    String phoneNumber,
    topLength,
    back,
    sleeve,
    collar,
    chest,
    aroundArm,
    cuff,
    waist,
    thigh,
    bar,
    seat,
    knee,
    flap,
    trouserLength,
    month,
    serviceCharge,
    initialPayment,
    dueDate,
      //   status,
  ) {
    _name = name;
    _phoneNumber = phoneNumber;
    _topLength = topLength;
    _back = back;
    _sleeveLength = sleeve;
    _collar = collar;
    _chest = chest;
    _aroundArm = aroundArm;
    _cuff = cuff;
    _waist = waist;
    _thigh = thigh;
    _bar = bar;
    _seat = seat;
    _knee = knee;
    _flap = flap;
    _trouserLength = trouserLength;
    _month = month;
    _serviceCharge = serviceCharge;
    _initialPayment = initialPayment;
    _dueDate = dueDate;
    // _paymentStatus = status;

    notifyListeners();
  }

  createNewDress(BuildContext context, DressType dressType) {
    _id = _uuid.v4();
    switch (dressType) {
      case DressType.LADIES_SKIRT:
        dress = Dress(
            id: _id,
            name: getName,
            phoneNumber: getNumber,
            waist: getWaist,
            hip: getHip,
            knee: getKnee,
            skirtLength: getSkirtLength,
            initialPayment: getInitialPayment,
            // paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: skirt,
            month: getMonth);

        break;
      case DressType.LADIES_DRESS:
        dress = Dress(
            id: _id,
            name: getName,
            phoneNumber: getNumber,
            shoulder: getShoulder,
            bust: getBust,
            nippleToNipple: getNipToNip,
            shoulderToNipple: getShoToNip,
            waist: getWaist,
            hip: getHip,
            shoulderToWaist: getShoToWaist,
            aroundArm: getAroundArm,
            dressLength: getDressLength,
            sleeveLength: getSleeveLength,
            trouserLength: getTrouserLength,
            knee: getKnee,
            initialPayment: getInitialPayment,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: ld,
            month: getMonth);
        break;
      case DressType.LADIES_TOP:
        dress = Dress(
            id: _id,
            name: getName,
            phoneNumber: getNumber,
            shoulder: getShoulder,
            bust: getBust,
            nippleToNipple: getNipToNip,
            shoulderToNipple: getShoToNip,
            waist: getWaist,
            hip: getHip,
            shoulderToWaist: getShoToWaist,
            aroundArm: getAroundArm,
            topLength: getTopLength,
            initialPayment: getInitialPayment,
            //  paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: shirtLadies,
            month: getMonth);
        break;
      case DressType.LADIES_TROUSER:
        dress = Dress(
            id: _id,
            name: getName,
            phoneNumber: getNumber,
            trouserLength: getTrouserLength,
            waist: getWaist,
            hip: getHip,
            ankle: getAnkle,
            knee: getKnee,
            crotch: getCrotch,
            initialPayment: getInitialPayment,
            //  paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: trouserLadies,
            month: getMonth);
        break;
      case DressType.MENS_DRESS:
        dress = Dress(
            id: _id,
            name: getName,
            phoneNumber: getNumber,
            topLength: getTopLength,
            back: getBack,
            sleeveLength: getSleeveLength,
            collar: getCollar,
            cuff: getCuff,
            chest: getChest,
            waist: getWaist,
            aroundArm: getAroundArm,
            trouserLength: getTrouserLength,
            thigh: getThigh,
            bar: getBar,
            seat: getSeat,
            knee: getKnee,
            flap: getFlap,
            initialPayment: getInitialPayment,
            //paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: topAndDown,
            month: getMonth);
        break;
      case DressType.MENS_TOP:
        dress = Dress(
            id: _id,
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
            // paymentStatus: getPaymentStatus,
            serviceCharge: getServiceCharge,
            dueDate: getDueDate,
            timestamp: timestamp,
            type: shirtMen,
            month: getMonth);
        break;
      case DressType.MENS_TROUSER:
        dress = Dress(
          id: _id,
          name: getName,
          phoneNumber: getNumber,
          trouserLength: getTrouserLength,
          waist: getWaist,
          thigh: getThigh,
          bar: getBar,
          seat: getSeat,
          knee: getKnee,
          flap: getFlap,
          initialPayment: getInitialPayment,
          // paymentStatus: getPaymentStatus,
          serviceCharge: getServiceCharge,
          dueDate: getDueDate,
          timestamp: timestamp,
          type: getType,
          month: getMonth,
        );
        break;
    }

    //not a good practice but dialog shows up here to avoid boiler plate codes in classes
    ShowAction.showAlertDialog(
        alert,
        alertMsg,
        context,
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            _dressService.createNewDress(dress!, context);

            // Future.delayed(Duration(seconds: 5));
            ShowAction()
                .showToast(successful, Colors.black); //show complete msg
            // Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: Text(yes, style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: Text(no, style: TextStyle(color: Colors.white)),
        ));
  }

  updateWorkComplete(String id, BuildContext ctx) {
    _dressService.updateWorkComplete(id);
    ShowAction().showToast(successful, Colors.black); //show complete msg
  }

  forceUpdateWorkComplete(
      String id, String time, int serviceCharge, BuildContext ctx) {
    _dressService.forceUpdateWorkComplete(id, time, serviceCharge);
    ShowAction().showToast(successful, Colors.black);
    Navigator.of(ctx).pop();
  }

  deleteMeasurement(String id, BuildContext ctx) {
    _dressService.deleteMeasurement(id);
    ShowAction().showToast(successful, Colors.black); //show complete msg
    Navigator.of(ctx).pop();
  }
}
