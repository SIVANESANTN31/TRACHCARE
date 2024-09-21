import 'package:flutter/material.dart';
import 'package:trachcare/components/Appbar_copy.dart';

import '../../../../style/utils/Dimention.dart';


class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    Dimentions dn = Dimentions(context);
    return Scaffold(
      //  appBar: Duplicate_Appbar(Title: "Patient Details", height: dn.height(10)),
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
                  SizedBox(height: dn.height(10),),
                  const Text(
                    'INFORMATION',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                    
                  ),
                  Image.asset('assets/images/0.png'),
                  const Text(
                    'Trachcare',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
                  ),
                   SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
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
                ],)
            ),
          ],
        ),
      ),
    );
  }
}