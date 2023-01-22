import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w3cert/router/route-const.dart';
import 'package:w3cert/router/routing.dart';
import 'package:w3cert/screen/home-screen/widget/custom-container.dart';
import 'package:go_router/go_router.dart';

import '../../provider/provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      color: Color.fromARGB(90, 25, 21, 80),
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(
              click: () {
                context.pushNamed(RouterConstants.notification);
              },
              content: "Activity",
              height: height * 0.1,
              widht: width * 0.9,
            ),
            CustomContainer(
              click: () {
                context.pushNamed(RouterConstants.attendence);
              },
              content: "Attendence",
              height: height * 0.1,
              widht: width * 0.9,
            ),
            CustomContainer(
              click: () {
                context.pushNamed(RouterConstants.task);
              },
              content: "Task",
              height: height * 0.1,
              widht: width * 0.9,
            )
          ],
        ),
      ),
    ));
  }
}
