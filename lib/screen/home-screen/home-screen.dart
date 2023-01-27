import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: SafeArea(
      child: Container(
        width: width,
        height: height,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(children: [
            Card(
              elevation: 10,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.08,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Dashboard",
                    style: GoogleFonts.ptSans(
                        color: Color.fromARGB(255, 27, 24, 73),
                        fontSize: width < 700 ? width / 25 : width / 45,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0),
                  ),
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.9,
              child: GridView.count(
                crossAxisCount: width < 500 ? 3 : 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: [
                  CustomContainer(
                    icon: Icons.notifications,
                    click: () {
                      context.pushNamed(RouterConstants.notification,
                          queryParams: {"token": ref.watch(tokenProvider)});
                    },
                    content: "Notification",
                    height: height * 0.1,
                    widht: width * 0.9,
                  ),
                  CustomContainer(
                    icon: Icons.calendar_month,
                    click: () {
                      context.pushNamed(RouterConstants.attendence,
                          queryParams: {"token": ref.watch(tokenProvider)});
                    },
                    content: "Attendence",
                    height: height * 0.1,
                    widht: width * 0.9,
                  ),
                  CustomContainer(
                    icon: Icons.task,
                    click: () {
                      context.pushNamed(RouterConstants.task,
                          queryParams: {"token": ref.watch(tokenProvider)});
                    },
                    content: "Task",
                    height: height * 0.1,
                    widht: width * 0.9,
                  )
                ],
              ),
            )
          ]);
        }),
      ),
    ));
    // return Scaffold(
    //     body: Container(
    //   width: width,
    //   height: height,
    //   color: Color.fromARGB(90, 25, 21, 80),
    //   alignment: Alignment.center,
    //   child: Container(
    //     width: width,
    //     height: height * 0.5,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         CustomContainer(
    //           click: () {
    //             context.pushNamed(RouterConstants.notification,
    //                 queryParams: {"token": ref.watch(tokenProvider)});
    //           },
    //           content: "Notification",
    //           height: height * 0.1,
    //           widht: width * 0.9,
    //         ),
    //         CustomContainer(
    //           click: () {
    //             context.pushNamed(RouterConstants.notification,
    //                 queryParams: {"token": ref.watch(tokenProvider)});
    //           },
    //           content: "Notification",
    //           height: height * 0.1,
    //           widht: width * 0.9,
    //         ),
    //         CustomContainer(
    //           click: () {
    //             context.pushNamed(RouterConstants.task,
    //                 queryParams: {"token": ref.watch(tokenProvider)});
    //           },
    //           content: "Task",
    //           height: height * 0.1,
    //           widht: width * 0.9,
    //         )
    //       ],
    //     ),
    //   ),
    // ));
  }
}
