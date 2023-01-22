import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../api/api.dart';
import '../../router/route-const.dart';
import '../home-screen/widget/custom-container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notification = [];
  @override
  void initState() {
    API().notification().then((value) {
      if (value.statusCode != 200) {
        return print("error");
      }
      setState(() {
        notification = value.data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    String timeVatiation(value) {
      var currentDateTime = DateTime.now();
      var duration = (currentDateTime.difference(DateTime.parse(value)));
      int days = duration.inDays % 365.abs();
      int hours = duration.inHours % 24.abs();
      int mint = duration.inMinutes % 60.abs();

      String dateString;
      if (days == 0) {
        dateString = '$hours hrs $mint mins';
      } else {
        dateString = '$days days ${hours == 0 ? '' : '${hours}hrs'}  ago';
      }

      return dateString;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(children: [
              Container(
                width: width,
                height: constraints.maxHeight * 0.05,
                child: Row(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.05,
                      width: constraints.maxHeight * 0.05,
                      margin: EdgeInsets.only(left: 4),
                      alignment: Alignment.center,
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 27, 24, 73),
                            )),
                      ),
                    ),
                    Text(
                      "Notifications",
                      style: GoogleFonts.ptSans(
                          color: Color.fromARGB(255, 27, 24, 73),
                          fontSize: width < 700 ? width / 24 : width / 45,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: constraints.maxHeight * 0.95,
                child: notification.isEmpty
                    ? Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: Color.fromARGB(255, 27, 24, 73),
                            size: width * 0.1),
                      )
                    : ListView(
                        children: [
                          for (var i = 0; i < notification.length; i++)
                            Stack(
                              children: [
                                Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    color: Color.fromARGB(255, 27, 24, 73),
                                    child: Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight * 0.12,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                          width: constraints.maxWidth * 0.97,
                                          height: constraints.maxHeight * 0.12,
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Container(
                                                width:
                                                    constraints.maxWidth * 0.2,
                                                child: Center(
                                                    child: CircleAvatar(
                                                  maxRadius:
                                                      constraints.maxWidth *
                                                          0.07,
                                                  backgroundImage: NetworkImage(
                                                      notification[i]
                                                              ["image"] ??
                                                          ""),
                                                )),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    27,
                                                                    24,
                                                                    73)))),
                                                width:
                                                    constraints.maxWidth * 0.77,
                                                padding: EdgeInsets.only(
                                                    left: constraints.maxWidth *
                                                        0.05),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            notification[i][
                                                                    "subject"] ??
                                                                "not working",
                                                            style: GoogleFonts.ptSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 28
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              notification[i][
                                                                      "text"] ??
                                                                  "its null",
                                                              style: GoogleFonts.ptSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: width <
                                                                          700
                                                                      ? width /
                                                                          38
                                                                      : width /
                                                                          45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${DateFormat("d-MMM-yyyy").format(DateTime.parse(notification[i]["updated_at"]))}",
                                                              style: GoogleFonts.ptSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: width <
                                                                          700
                                                                      ? width /
                                                                          38
                                                                      : width /
                                                                          45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                            Card(
                                                              elevation: 10,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child: Text(
                                                                  timeVatiation(
                                                                      notification[
                                                                              i]
                                                                          [
                                                                          "updated_at"]),
                                                                  style: GoogleFonts.ptSans(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          27,
                                                                          24,
                                                                          73),
                                                                      fontSize: width < 700
                                                                          ? width /
                                                                              40
                                                                          : width /
                                                                              45,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      letterSpacing:
                                                                          0),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
