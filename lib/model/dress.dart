import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';

class Dress with ChangeNotifier {
  String? bust;
  String? waist;
  String? hip;
  String? shoulder;
  String? shoulderToWaist;
  String? nippleToNipple;
  String? shoulderToNipple;
  String? sleeveLength;
  String? aroundArm;
  String? topLength;
  String? knee;
  String? skirtLength;
  String? dressLength;
  String? ankle;
  String? trouserLength;
  String? crotch;

  String? collar;
  String? chest;
  String? cuff;
  String? thigh;
  String? bar;
  String? seat;
  String? flap;
  String? paymentStatus;
  String? dueDate;
  int? serviceCharge;
  int? initialPayment;
  String? phoneNumber;
  String? name;
  String? back;

  String? type;
  String? month;
  dynamic timestamp;

  Dress(
      {this.bust,
      this.waist,
      this.hip,
      this.shoulder,
      this.shoulderToWaist,
      this.nippleToNipple,
      this.shoulderToNipple,
      this.sleeveLength,
      this.aroundArm,
      this.topLength,
      this.knee,
      this.skirtLength,
      this.dressLength,
      this.ankle,
      this.trouserLength,
      this.crotch,
      this.collar,
      this.chest,
      this.cuff,
      this.thigh,
      this.bar,
      this.seat,
      this.flap,
      this.paymentStatus,
      this.dueDate,
      this.initialPayment,
      this.serviceCharge,
      this.phoneNumber,
      this.name,
      this.back,
      this.type,
      this.month,
      this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'bust': bust ?? '',
      'waist': waist ?? '',
      'hip': hip ?? '',
      'back': back ?? '',
      'shoulder': shoulder ?? '',
      'shoulderToWaist': shoulderToWaist ?? '',
      'nippleToNipple': nippleToNipple ?? '',
      'shoulderToNipple': shoulderToNipple ?? '',
      'sleeveLength': sleeveLength ?? '',
      'aroundArm': aroundArm ?? '',
      'topLength': topLength ?? '',
      'knee': knee ?? '',
      'skirtLength': skirtLength ?? '',
      'dressLength': dressLength ?? '',
      'ankle': ankle ?? '',
      'trouserLength': trouserLength ?? '',
      'crotch': crotch ?? '',
      'collar': collar ?? '',
      'chest': chest ?? '',
      'cuff': cuff ?? '',
      'thigh': thigh ?? '',
      'bar': bar ?? '',
      'seat': seat ?? '',
      'flap': flap ?? '',
      'paymentStatus': paymentStatus ?? notPaid,
      'dueDate': dueDate,
      'initialPayment': initialPayment,
      'serviceCharge': serviceCharge,
      'phoneNumber': phoneNumber,
      'name': name,
      'type': type,
      'month': month,
      'timestamp': timestamp
    };
  }

  factory Dress.fromSnapshot(DocumentSnapshot ds) {
    return Dress(
        bust: ds['bust'],
        waist: ds['waist'],
        hip: ds['hip'],
        back: ds['back'],
        shoulder: ds['shoulder'],
        shoulderToWaist: ds['shoulderToWaist'],
        nippleToNipple: ds['nippleToNipple'],
        shoulderToNipple: ds['shoulderToNipple'],
        sleeveLength: ds['sleeveLength'],
        aroundArm: ds['aroundArm'],
        topLength: ds['topLength'],
        knee: ds['knee'],
        skirtLength: ds['skirtLength'],
        dressLength: ds['dressLength'],
        ankle: ds['ankle'],
        trouserLength: ds['trouserLength'],
        crotch: ds['crotch'],
        collar: ds['collar'],
        chest: ds['chest'],
        cuff: ds['cuff'],
        thigh: ds['thigh'],
        bar: ds['bar'],
        seat: ds['seat'],
        flap: ds['flap'],
        paymentStatus: ds['paymentStatus'],
        dueDate: ds['dueDate'],
        initialPayment: ds['initialPayment'],
        serviceCharge: ds['serviceCharge'],
        phoneNumber: ds['phoneNumber'],
        name: ds['name'],
        type: ds['type'],
        month: ds['month'],
        timestamp: ds['timestamp']);
  }

  factory Dress.fromMap(Map<String, dynamic> ds) {
    return Dress(
        bust: ds['bust'],
        waist: ds['waist'],
        hip: ds['hip'],
        back: ds['back'],
        shoulder: ds['shoulder'],
        shoulderToWaist: ds['shoulderToWaist'],
        nippleToNipple: ds['nippleToNipple'],
        shoulderToNipple: ds['shoulderToNipple'],
        sleeveLength: ds['sleeveLength'],
        aroundArm: ds['aroundArm'],
        topLength: ds['topLength'],
        knee: ds['knee'],
        skirtLength: ds['skirtLength'],
        dressLength: ds['dressLength'],
        ankle: ds['ankle'],
        trouserLength: ds['trouserLength'],
        crotch: ds['crotch'],
        collar: ds['collar'],
        chest: ds['chest'],
        cuff: ds['cuff'],
        thigh: ds['thigh'],
        bar: ds['bar'],
        seat: ds['seat'],
        flap: ds['flap'],
        paymentStatus: ds['paymentStatus'],
        dueDate: ds['dueDate'],
        initialPayment: ds['initialPayment'],
        serviceCharge: ds['serviceCharge'],
        phoneNumber: ds['phoneNumber'],
        name: ds['name'],
        type: ds['type'],
        month: ds['month'],
        timestamp: ds['timestamp']);
  }

  int getBalance() {
    return (serviceCharge! - initialPayment!);
  }

  String checkPaymentStatus(int serviceCharge, int initialPayment) {
    String? status;
    if (initialPayment == 0)
      status = notPaid;
    else if (initialPayment < serviceCharge)
      status = partPayment;
    else if (serviceCharge == initialPayment)
      status = fullPayment;
    else if (initialPayment > serviceCharge) status = error;
    return status!;
  }
}
