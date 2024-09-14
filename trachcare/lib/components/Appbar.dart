import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/Navbardrawer.dart';
import 'package:trachcare/style/colors.dart';
// import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String Name;
  final double height;
  final PreferredSizeWidget? bottom;

  Appbar({super.key, required this.Name, this.bottom, required this.height});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: TitleColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10),
      )),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      }),
      centerTitle: true,
      title: Text(
        "Hi,${Name}",
        style: GoogleFonts.ibmPlexSans(
            textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
      ),
      actions: [
        IconButton(
            onPressed: () {
              // FlutterOpenWhatsapp.sendSingleMessage(
              //     "9500077434", "Hello, this is a test message.");
            },
            icon: Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.green,
            ))
      ],
      bottom: bottom,
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
