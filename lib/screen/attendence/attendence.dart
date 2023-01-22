import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/route-const.dart';
import '../home-screen/widget/custom-container.dart';

class AttendenceScreen extends StatelessWidget {
  const AttendenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight * 0.05,
                      width: constraints.maxHeight * 0.4,
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      child: Text("Attendence"),
                    )
                  ],
                ),
              ),
              Container(
                width: width,
                height: constraints.maxHeight * 0.9,
                child: Column(
                  children: [Text("Attendence")],
                ),
              ),
              Container(
                width: width,
                height: constraints.maxHeight * 0.05,
                color: Colors.blue,
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
