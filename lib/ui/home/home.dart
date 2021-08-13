import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/ui/add_customer/add_customer.dart';
import 'package:taylor_swift/ui/widgets/loading.dart';
import 'package:timeago/timeago.dart' as timeAgo;

String? id = FirebaseAuth.instance.currentUser!.uid;

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedItem;
  TextEditingController _searchController = TextEditingController();
  int month = DateTime.now().month;
  List? dressList;

  @override
  void initState() {
    // dressList = Provider.of<List<Dress>>(context, listen: false);
    getMonth();
    super.initState();
  }

  getMonth() {
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
    print('?? ${dressList.length}  id $id');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopCard(),
          buildSearchUser(),
          Expanded(child: buildCustomerList(dressList))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context)
            .pushNamed(AddCustomer.routeName, arguments: _selectedItem),
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
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: twentyFourDp, vertical: tenDp),
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
                      child: Text("Total Collections",
                          style: TextStyle(
                              fontSize: twelveDp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),

                    //todo replace value in string with total budget from database
                    Text("$kGhanaCedi 453.25",
                        style:
                        TextStyle(fontSize: twelveDp, color: Colors.white)),
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
          setState(() {
            _selectedItem = value;
          });
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
  }

  Widget buildItems(Dress dress) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: tenDp, vertical: tenDp),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(eightDp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${dress.name}"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildItem(serviceCharge, '$kGhanaCedi 12', Colors.indigo),
                buildItem(initialPayment, '$kGhanaCedi 10', Colors.green),
                buildItem(balance, '$kGhanaCedi 2', Colors.red),
              ],
            ),
            SizedBox(
              height: tenDp,
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
                  "Part payment",
                  style: TextStyle(
                    fontSize: twelveDp,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                splashColor: Colors.indigo,
                mini: true,
                onPressed: () {},
                child: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLadiesTop(Dress dress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildItem(length, '${dress.shoulder}', Colors.indigo),
            buildItem(back, '${dress.bust} ', Colors.green),
            buildItem(sleeveLength, '${dress.nippleToNipple} ', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget buildMensTop(Dress dress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildItem(length, '${dress.topLength}', Colors.indigo),
            buildItem(back, '${dress.back} ', Colors.green),
            buildItem(sleeveLength, '${dress.sleeveLength} ', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget buildMensTrouser(Dress dress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildItem(length, '${dress.trouserLength}', Colors.indigo),
            buildItem(back, '${dress.waist} ', Colors.green),
            buildItem(sleeveLength, '${dress.thigh} ', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget buildItem(String item1, String item2, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item1,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: twelveDp, color: color),
        ),
        Text(
          item2,
          style: TextStyle(fontSize: fourteenDp),
        ),
      ],
    );
  }
}
