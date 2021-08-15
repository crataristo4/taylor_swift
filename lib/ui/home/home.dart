import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/helper/notification_info.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/provider/dress_provider.dart';
import 'package:taylor_swift/ui/add_customer/add_customer.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/loading.dart';
import 'package:timeago/timeago.dart' as timeAgo;

String? id = FirebaseAuth.instance.currentUser!.uid;
final GlobalKey<State> loadingKey = new GlobalKey<State>();

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  static String? nameControllerString;
  static DateTime notificationTime = DateTime.now();

  //function to save and schedule notification
  static void saveNotification() {
    DateTime scheduleAlarmDateTime;
    if (HomePage.notificationTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = HomePage.notificationTime;
    else
      scheduleAlarmDateTime = HomePage.notificationTime.add(Duration(days: 1));

    var notificationInfo = NotificationInfo(
      notifDateTime: scheduleAlarmDateTime,
      title: 'Time to submit ${HomePage.nameControllerString}\'s cloth',
    );
    ShowAction.scheduleNotification(scheduleAlarmDateTime, notificationInfo);
    print("saved to $scheduleAlarmDateTime  ${HomePage.nameControllerString}");
  }

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedItem;
  TextEditingController _searchController = TextEditingController();
  CountdownTimerController? countDownController;
  dynamic endTime;
  DressProvider _dressProvider = DressProvider();
  int total = 0;
  Dress? dress;
  List<Dress>? users;

  // List<Dress>? _dressList;
  String searchInput = '';
  bool isSearch = false;

  @override
  void initState() {
    getMonth();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final dressList = Provider.of<List<Dress>>(context, listen: false);

    for (int i = 0; i < dressList.length; i++) {
      dress = dressList[i];
      total += dress!.initialPayment!;
    }
    print("$total ??");
    super.didChangeDependencies();
  } //get month method

  getMonth() {
    int month = DateTime.now().month;
    switch (month) {
      case 1:
        _selectedItem = JAN;
        break;
      case 2:
        _selectedItem = FEB;
        break;
      case 3:
        _selectedItem = MAR;
        break;
      case 4:
        _selectedItem = APR;
        break;
      case 5:
        _selectedItem = MAY;
        break;
      case 6:
        _selectedItem = JUN;
        break;
      case 7:
        _selectedItem = JULY;
        break;
      case 8:
        _selectedItem = AUG;
        break;
      case 9:
        _selectedItem = SEP;
        break;
      case 10:
        _selectedItem = OCT;
        break;
      case 11:
        _selectedItem = NOV;
        break;
      case 12:
        _selectedItem = DEC;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dressList = Provider.of<List<Dress>>(context);

    /* for (int i = 0; i < dressList.length; i++) {
      dress = dressList[i];
      total += dress!.initialPayment!;
      print("$total ??");
    }*/
    if (searchInput.isEmpty) {
      isSearch = false;
      // _dressList = dressList;
    } else if (searchInput.trim().isNotEmpty && dressList.isNotEmpty) {
      final userList = dressList.where((Dress dress) {
        return dress.name!.toLowerCase().contains(searchInput.toLowerCase());
      }).toList();
      users = userList;
      isSearch = true;
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopCard(),
          buildSearchUser(),
          isSearch
              ? Expanded(child: buildCustomerList(users!))
              : Expanded(child: buildCustomerList(dressList))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            AddCustomer.routeName, (route) => false,
            arguments: _selectedItem),
        label: Text(add),
        icon: Icon(Icons.person),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  //shows the topmost card
  Widget buildTopCard() {
    return Container(
      margin: EdgeInsets.all(eightDp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(eightDp)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Theme.of(context).primaryColor, Colors.green])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Top Section of Card
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(sixteenDp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Targets Achieved",
                              style: TextStyle(
                                  fontSize: fourteenDp,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold)),

                          SizedBox(
                            height: eightDp,
                          ),
                          //Date range of budget
                          Text("20",
                              style: TextStyle(
                                  fontSize: fourteenDp, color: Colors.white)),
                        ],
                      ),
                    ),
                    buildSelectedMonth(),
                  ],
                ),
                Divider(
                  thickness: 2,
                  endIndent: eightDp,
                  indent: eightDp,
                  color: Colors.white.withOpacity(0.2),
                ),
              ],
            ),
          ),
          Center(
            child: Text("PROGRESS",
                style: TextStyle(fontSize: twelveDp, color: Colors.white)),
          ),

          Container(
            margin: EdgeInsets.symmetric(
                horizontal: twentyFourDp, vertical: eightDp),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 1.2,
              backgroundColor: Colors.grey[200],
              animation: true,
              animationDuration: 3000,
              lineHeight: 20.0,
              percent: 0.5,
              progressColor: Colors.green,
            ),
          ),

          //Bottom Section of Card
          total == 0
              ? Container()
              : Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: twentyFourDp, vertical: tenDp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(eightDp),
                          bottomRight: Radius.circular(eightDp)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue, Colors.green])),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(eightDp),
                          bottomRight: Radius.circular(eightDp)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(sixteenDp),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: eightDp),
                            child: Text(totalCollections,
                                style: TextStyle(
                                    fontSize: twelveDp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Text("$kGhanaCedi $total",
                              style: TextStyle(
                                  fontSize: twelveDp, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildSelectedMonth() {
    return Container(
      width: 70,
      height: 55,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(eightDp),
          border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
      child: DropdownButtonFormField<String>(
        value: _selectedItem,
        elevation: 1,
        isExpanded: true,
        style: TextStyle(color: Color(0xFF424242)),
        // underline: Container(),
        items: [
          JAN,
          FEB,
          MAR,
          APR,
          MAY,
          JUN,
          JULY,
          AUG,
          SEP,
          OCT,
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          _selectedItem = value;
          /*  setState(() {
            _selectedItem = value;
          });*/
        },
      ),
    );
  }

  Widget buildSearchUser() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: eightDp,
      ),
      child: TextFormField(
          //search for a service text field
          keyboardType: TextInputType.text,
          controller: _searchController,
          textAlign: TextAlign.center,
          onChanged: (value) {
            setState(() {
              searchInput = value.toLowerCase();
            });
          },
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: sixteenDp),
              suffix: Container(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                width: thirtySixDp,
                height: thirtySixDp,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(eightDp),
                  border: Border.all(width: 0.5, color: Colors.white54),
                ),
              ),
              hintText: searchCustomer,
              fillColor: Colors.white70,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: tenDp, horizontal: tenDp),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF5F5F5)),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF5F5F5))))),
    );
  }

  Widget buildCustomerList(List dressList) {
    return Builder(
      builder: (BuildContext context) {
        return ListView.builder(
          itemBuilder: (context, index) {
            // Dress dress =  Dress.fromSnapshot(dressList[index]);
            return dressList.length == 0
                ? LoadingShimmer(
                    name: "Dress",
                  )
                : buildItems(dressList[index]);
          },
          itemCount: dressList.length,
          shrinkWrap: true,
          primary: true,
          physics: ClampingScrollPhysics(),
        );
      },
    );
  }

  Widget buildItems(Dress dress) {
    //get time from db
    var dueDate = DateTime.parse(dress.dueDate!);
    //convert time
    endTime = dueDate.millisecondsSinceEpoch;
    //assign time to controller
    countDownController = CountdownTimerController(endTime: endTime);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(eightDp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${dress.name}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: sixteenDp),
                ),

                //delete measurement
                IconButton(
                  onPressed: () {
                    ShowAction.showAlertDialog(
                        deleteMeasurement,
                        "$delete ${dress.name}'\s $measurement",
                        context,
                        //yes button
                        ElevatedButton(
                          onPressed: () {
                            //delete measurement
                            _dressProvider.deleteMeasurement(dress.id, context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          child:
                              Text(yes, style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child:
                              Text(no, style: TextStyle(color: Colors.white)),
                        ));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  splashColor: Colors.black,
                  hoverColor: Colors.indigo,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${dress.type}"),
                Text("${timeAgo.format(dress.timestamp.toDate())}"),
              ],
            ),
            Center(
                child: Text(
              measurement,
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
            Divider(
              color: Colors.blue,
              endIndent: oneFiftyDp,
              indent: oneFiftyDp,
            ),
            itemsList(dress),
            SizedBox(
              height: tenDp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildItem(serviceCharge, '$kGhanaCedi ${dress.serviceCharge}',
                    Colors.indigo),
                buildItem(initialPayment, '$kGhanaCedi ${dress.initialPayment}',
                    Colors.green),
                buildItem(
                    balance,
                    '$kGhanaCedi ${Dress.getBalance(dress.serviceCharge, dress.initialPayment)}',
                    Colors.red),
              ],
            ),
            SizedBox(
              height: tenDp,
            ),
            Divider(
              //   color: Colors.black45,
                ),
            Text(
              status,
              style:
                  TextStyle(fontSize: fourteenDp, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${Dress.checkPaymentStatus(dress.serviceCharge, dress.initialPayment)}",
                  style: TextStyle(
                    fontSize: twelveDp,
                  ),
                ),
              ],
            ),

            //display count down timer
            CountdownTimer(
              endTime: endTime,
              controller: countDownController,
              widgetBuilder: (_, CurrentRemainingTime? time) {
                if (time == null) {
                  //  end(id);
                  return Center(
                    child: Text(
                      'Due date elapsed',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: twentyFourDp),
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Finish By',
                      style: TextStyle(
                          fontSize: tenDp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red),
                    ),
                    time.days == null
                        ? Container()
                        : buildCustomTimer(time.days!, Colors.black,
                            time.days! > 1 ? 'days' : 'day'),
                    time.hours == null
                        ? Container()
                        : buildCustomTimer(time.hours!, Colors.blue,
                            time.hours! > 1 ? 'hrs' : 'hr'),
                    time.min == null
                        ? Container()
                        : buildCustomTimer(time.min!, Colors.brown,
                            time.min! > 1 ? 'mins' : 'min'),
                    time.sec == null
                        ? Container()
                        : buildCustomTimer(time.sec!, Colors.red, "sec"),
                  ],
                );
              },
            ),

            //display call button
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                splashColor: Colors.indigo,
                mini: true,
                onPressed: () {
                  SnackBar snackBar = SnackBar(
                      padding: EdgeInsets.all(tenDp),
                      duration: Duration(seconds: 5),
                      action: SnackBarAction(
                        label: yes,
                        onPressed: () {
                          ShowAction.makePhoneCall('tel:${dress.phoneNumber}');
                        },
                        textColor: Colors.white,
                      ),
                      backgroundColor: Colors.indigo,
                      content: Text(
                        'Do you want to Call ${dress.name} now ?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //groups all types of category
  Widget itemsList(Dress dress) {
    if (dress.type == skirt)
      //display ladies skirt
      return buildLadiesSkirt(dress);
    else if (dress.type == shirtLadies)
      //display ladies shirt
      return buildLadiesTop(dress);
    else if (dress.type == trouserLadies) {
      //display ladies trouser
      return buildLadiesTrouser(dress);
    } else if (dress.type == ld) {
      //display ladies dress
      return buildLadiesDress(dress);
    } else if (dress.type == shirtMen) {
      //display mens shirt
      return buildMensTop(dress);
    } else if (dress.type == trouser || dress.type == shorts) {
      //display mens trouser or shorts
      return buildMensTrouser(dress);
    } else if (dress.type == topAndDown) {
      //display mens top and down
      return buildMensTopAndDown(dress);
    }

    return Container();
  }

  //returns a widget of data for only ladies top
  Widget buildLadiesDress(Dress dress) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(shoulder, '${dress.shoulder}', Colors.indigo),
              buildItem(bust, '${dress.bust}', Colors.purple),
              buildItem(
                  nippleToNipple, '${dress.nippleToNipple} ', Colors.green),
              buildItem(
                  shoulderToNipple, '${dress.shoulderToNipple} ', Colors.pink),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(waist, '${dress.waist}', Colors.indigo),
              buildItem(hip, '${dress.hip}', Colors.red),
              buildItem(
                  shoulderToWaist, '${dress.shoulderToWaist}', Colors.green),
              buildItem(aroundArm, '${dress.aroundArm}', Colors.red),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(dressLength, '${dress.dressLength}', Colors.indigo),
              buildItem(sleeveLength, '${dress.sleeveLength} ', Colors.black),
              buildItem(knee, '${dress.knee}', Colors.blue),
              buildItem(trouserLength, '${dress.trouserLength}', Colors.red),
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  //returns a widget of data for only ladies top
  Widget buildLadiesTop(Dress dress) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(shoulder, '${dress.shoulder}', Colors.indigo),
              buildItem(bust, '${dress.bust}', Colors.indigo),
              buildItem(
                  nippleToNipple, '${dress.nippleToNipple} ', Colors.green),
              buildItem(waist, '${dress.waist} ', Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  //returns a widget of data for only ladies skirt
  Widget buildLadiesSkirt(Dress dress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildItem(waist, '${dress.waist}', Colors.indigo),
            buildItem(hip, '${dress.hip}', Colors.indigo),
            buildItem(skirtLength, '${dress.skirtLength} ', Colors.green),
            buildItem(knee, '${dress.knee} ', Colors.red),
          ],
        ),
      ],
    );
  }

  //returns a widget of data for only ladies trouser
  Widget buildLadiesTrouser(Dress dress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildItem(trouserLength, '${dress.trouserLength} ', Colors.amber),
            buildItem(waist, '${dress.waist}', Colors.indigo),
            buildItem(hip, '${dress.hip}', Colors.blue),
            buildItem(crotch, '${dress.crotch} ', Colors.green),
            buildItem(knee, '${dress.knee}', Colors.black),
            buildItem(ankle, '${dress.ankle}', Colors.indigo),
          ],
        ),
/*
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildItem(knee, '${dress.knee}', Colors.indigo),
            buildItem(ankle, '${dress.ankle}', Colors.indigo),
            buildItem(trouserLength, '${dress.trouserLength} ', Colors.green),
          ],
        ),*/
      ],
    );
  }

  Widget buildMensTop(Dress dress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildItem(length, '${dress.topLength}', Colors.indigo),
            buildItem(back, '${dress.back} ', Colors.green),
            buildItem(sleeveLength, '${dress.sleeveLength} ', Colors.red),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildItem(collar, '${dress.collar}', Colors.indigo),
            buildItem(back, '${dress.chest} ', Colors.green),
            buildItem(aroundArm, '${dress.aroundArm} ', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget buildMensTopAndDown(Dress dress) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(topLength, '${dress.topLength}', Colors.indigo),
              buildItem(back, '${dress.back} ', Colors.green),
              buildItem(sleeveLength, '${dress.sleeveLength} ', Colors.red),
              buildItem(collar, '${dress.collar} ', Colors.amber),
              buildItem(chest, '${dress.chest} ', Colors.red),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(aroundArm, '${dress.aroundArm} ', Colors.indigo),
              buildItem(cuff, '${dress.cuff} ', Colors.red),
              buildItem(trouserLength, '${dress.trouserLength}', Colors.indigo),
              buildItem(waist, '${dress.waist} ', Colors.green),
              buildItem(thighs, '${dress.thigh} ', Colors.red),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildItem(seat, '${dress.seat} ', Colors.red),
            buildItem(bar, '${dress.bar} ', Colors.purple),
            buildItem(knee, '${dress.knee} ', Colors.blue),
            buildItem(flap, '${dress.flap} ', Colors.red),
          ],
        ),
        Divider(),
      ],
    );
  }

  //widget to display data for mens trouser or shorts
  Widget buildMensTrouser(Dress dress) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItem(length, '${dress.trouserLength}', Colors.indigo),
              buildItem(waist, '${dress.waist} ', Colors.green),
              buildItem(thighs, '${dress.thigh} ', Colors.red),
              /*    buildItem(seat, '${dress.seat} ', Colors.blue),
              buildItem(knee, '${dress.knee}', Colors.indigo),
              buildItem(flap, '${dress.flap} ', Colors.purple),
              buildItem(bar, '${dress.bar} ', Colors.orange),*/
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: eightDp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*    buildItem(length, '${dress.trouserLength}', Colors.indigo),
              buildItem(waist, '${dress.waist} ', Colors.green),
              buildItem(thighs, '${dress.thigh} ', Colors.red),*/
              buildItem(seat, '${dress.seat} ', Colors.blue),
              buildItem(knee, '${dress.knee}', Colors.indigo),
              buildItem(flap, '${dress.flap} ', Colors.purple),
              //  buildItem(bar, '${dress.bar} ', Colors.orange),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*  buildItem(length, '${dress.trouserLength}', Colors.indigo),
            buildItem(waist, '${dress.waist} ', Colors.green),
            buildItem(thighs, '${dress.thigh} ', Colors.red),
            buildItem(seat, '${dress.seat} ', Colors.blue),
            buildItem(knee, '${dress.knee}', Colors.indigo),
            buildItem(flap, '${dress.flap} ', Colors.purple),*/
            buildItem(bar, '${dress.bar} ', Colors.orange),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget buildItem(String item1, String item2, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item1,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: twelveDp, color: color),
        ),
        Text(
          item2,
          style: TextStyle(fontSize: fourteenDp, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  //custom timer widget
  buildCustomTimer(int time, Color bgColor, String timeType) {
    return Container(
      margin: EdgeInsets.only(bottom: eightDp),
      width: sixtyDp,
      height: fiftyDp,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(eightDp),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        direction: ShimmerDirection.ltr,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$time ",
              style: TextStyle(color: Colors.white, fontSize: twelveDp),
            ),
            Text(
              timeType,
              style: TextStyle(color: Colors.white, fontSize: twelveDp),
            ),
          ],
        ),
      ),
    );
  }

  end(String promoId) {
    print('Ended');
  }
}
