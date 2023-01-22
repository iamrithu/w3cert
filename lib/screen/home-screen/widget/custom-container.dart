import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  final height;
  final widht;
  final String? content;
  final Function click;
  const CustomContainer(
      {Key? key, this.height, this.widht, this.content, required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        click();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Container(
          width: widht,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Color.fromARGB(255, 27, 24, 73), width: 2)),
          child: Center(
            child: Text(
              content!,
              style: GoogleFonts.ptSans(
                  color: Color.fromARGB(255, 27, 24, 73),
                  fontSize: widht < 700 ? widht / 24 : widht / 45,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0),
            ),
          ),
        ),
      ),
    );
  }
}
