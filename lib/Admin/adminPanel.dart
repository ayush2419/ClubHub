import 'package:club_hub/Admin/adminCheckBookings.dart';
import 'package:club_hub/Screens/bookingpage2.dart';
import 'package:club_hub/Screens/pagechange.dart';
import 'package:club_hub/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController dateConroller = new TextEditingController();
  TextEditingController controller_10_11 = new TextEditingController();
  TextEditingController controller_11_12 = new TextEditingController();
  TextEditingController controller_12_1 = new TextEditingController();
  TextEditingController controller_1_2 = new TextEditingController();
  TextEditingController controller_2_3 = new TextEditingController();
  TextEditingController controller_3_4 = new TextEditingController();
  String? selectedSport;
  bool showSpinner = false;
  final sportsList = [
    'Football',
    'Lawn Tennis',
    'Swimming',
    'Volleyball',
    'Basketball',
    'Archery',
    'Golf',
    'E-Games'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text('Admin Panel'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AdminCheckBooking()),
              );
            },
            icon: Icon(Icons.sports),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PageChange(
                          isAdmin: true,
                        )),
              );
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Sport',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    dropDownWidget(sportsList),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Date',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Material(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        shadowColor: darkPurple,
                        // elevation: 4,
                        child: TextFormField(
                          controller: dateConroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Enter Date (Eg. 03 Jan)',
                            prefixIcon: Icon(Icons.calendar_today_rounded),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: purple,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: tileColor,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Enter no of Seats in Each Slot',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 5.0),
                      physics: ClampingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 2,
                      crossAxisSpacing: 30.0,
                      children: [
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shadowColor: darkPurple,
                          // elevation: 4,
                          child: TextFormField(
                            controller: controller_10_11,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '10-11',
                              prefixIcon: Icon(Icons.people),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: purple,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: tileColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shadowColor: darkPurple,
                          // elevation: 4,
                          child: TextFormField(
                            controller: controller_11_12,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '11-12',
                              prefixIcon: Icon(Icons.people),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: purple,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: tileColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shadowColor: darkPurple,
                          // elevation: 4,
                          child: TextFormField(
                            controller: controller_12_1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '12-1',
                              prefixIcon: Icon(Icons.people),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: purple,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: tileColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shadowColor: darkPurple,
                          // elevation: 4,
                          child: TextFormField(
                            controller: controller_1_2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '1-2',
                              prefixIcon: Icon(Icons.people),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: purple,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: tileColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shadowColor: darkPurple,
                          // elevation: 4,
                          child: TextFormField(
                            controller: controller_2_3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '2-3',
                              prefixIcon: Icon(Icons.people),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: purple,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: tileColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shadowColor: darkPurple,
                          // elevation: 4,
                          child: TextFormField(
                            controller: controller_3_4,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '3-4',
                              prefixIcon: Icon(Icons.people),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: purple,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: tileColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  onPressed: () async {
                    if (selectedSport == null ||
                        dateConroller.text.isEmpty ||
                        controller_10_11.text.isEmpty ||
                        controller_11_12.text.isEmpty ||
                        controller_12_1.text.isEmpty ||
                        controller_1_2.text.isEmpty ||
                        controller_2_3.text.isEmpty ||
                        controller_3_4.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please Enter all fields'),
                      ));
                    } else {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        Map<String, dynamic> data = <String, dynamic>{
                          'date': dateConroller.text,
                          '10-11': int.parse(controller_10_11.text),
                          '11-12': int.parse(controller_11_12.text),
                          '12-1': int.parse(controller_12_1.text),
                          '1-2': int.parse(controller_1_2.text),
                          '2-3': int.parse(controller_2_3.text),
                          '3-4': int.parse(controller_3_4.text),
                        };

                        await firebaseFirestore
                            .collection(this.selectedSport!)
                            .add(data)
                            .whenComplete(() => print('Added'))
                            .catchError((e) => print(e));

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  color: purple,
                  height: 40.0,
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container dropDownWidget(List<String> list) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Please Select'),
          value: selectedSport,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down_rounded, color: darkPurple),
          iconSize: 35.0,
          items: list.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            this.selectedSport = value;
            print(selectedSport);
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
