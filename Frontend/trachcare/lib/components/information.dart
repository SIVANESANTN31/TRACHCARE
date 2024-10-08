import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/Appbar_copy.dart';

import '../Screens/Views/Admin/Bottomnavigator/Admindb.dart';
import '../style/colors.dart';
import '../style/utils/Dimention.dart';
import 'Appbar.dart';


class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
        appBar: AppBar(
      backgroundColor: TitleColor,
    shape:  const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(


    )),

    leading: InkWell(
      onTap: (){
        Navigator.pop(context);},

    child: Icon(CupertinoIcons.chevron_left,color: BlackColor,size: 28.0,),),
    title: Text("INFORMATION",style: GoogleFonts.ibmPlexSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 10, 26, 7),
                            fontSize: 15.sp)),),
        centerTitle: true,


    ),
      body: SingleChildScrollView(
        child: Stack(
          
          children: [
             
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA7DBAF), Color(0xFFFFD9A0)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  ),
              ),
             
              child: 
              Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: dn.height(5),),
                  const Text(
                    'TRACHCARE',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                    
                  ),
                  Image.asset('assets/images/0.png'),
                  SizedBox(height: dn.height(5),),
                   const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          ' Information: Lorem ipsum dolor sit amet consectetur adipisicing elit. Hic quis reprehenderit et laborum, rem,'
                          ' dolore eum quod voluptate exercitationem nobis, nihil es impedit fugadolore eum quod voluptate exercitationem nobis,'
                          ' nihil es impedit fugadolore eum quod voluptate exercitationem nobis, nihil es impedit fugadolore eum quod voluptate exercitationem nobis,'
                          ' nihil es impedit fugadolore eum quod voluptate exercitationem nobis, nihil es impedit fugadolore eum quod voluptate exercitationem nobis,'
                          ' nihil es impedit fuga!'' Information: Lorem ipsum dolor sit amet consectetur adipisicing elit. Hic quis reprehenderit et laborum, rem,'
                          ' dolore eum quod voluptate exercitationem nobis, nihil es impedit fugadolore eum quod voluptate exercitationem nobis,'
                          ' nihil es impedit fugadolore eum quod voluptate exercitationem nobis, nihil es impedit fugadolore eum quod voluptate exercitationem nobis,'
                          ' nihil es impedit fugadolore eum quod voluptate exercitationem nobis, nihil es impedit fugadolore eum quod voluptate exercitationem nobis,'
                          ' nihil es impedit fuga!',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],)
            ),
          ],
        ),
      ),
    );
  }
}