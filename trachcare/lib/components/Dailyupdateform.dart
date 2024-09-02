import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sizer/sizer.dart';
import 'package:trachcare/components/custom_button.dart';
import 'package:trachcare/style/Tropography.dart';
import 'package:trachcare/style/colors.dart';

class Dailyupdateform extends StatefulWidget {
  Dailyupdateform({super.key});

  @override
  State<Dailyupdateform> createState() => _DailyupdateformState();
}

class _DailyupdateformState extends State<Dailyupdateform> {
  @override
  bool yes_selected = false;
  bool no_selected = false;
  TextEditingController dropmenu = new TextEditingController(text: "Select the option");
  TextEditingController dropmenu1 = new TextEditingController(text: "Select the option"); 
  TextEditingController dropmenu2 = new TextEditingController(text: "Select the option");
  TextEditingController dropmenu3 = new TextEditingController(text: "Select the option");
  TextEditingController dropmenu4 = new TextEditingController(text: "Select the option");


   TextEditingController input1 = new TextEditingController();
   TextEditingController input2 = new TextEditingController();
   TextEditingController input3 = new TextEditingController();
   TextEditingController input4 = new TextEditingController();
   TextEditingController input5 = new TextEditingController();

  Widget build(BuildContext context) {
    return CupertinoFormSection(
      
      header: Text("Daily Update"), children: [
      CupertinoFormRow(
        child: SizedBox(
            width: 70.w,
            height: 6.h,
            child: CupertinoTextField(
              controller: input1,
              placeholder: "Enter the values",
            )),
        prefix: Text(
          
          "Vitals",
          style: Normal,
          softWrap: true,
        ),
      ),
      CupertinoFormRow(
        child: SizedBox(
            width: 70.w,
            height: 6.h,
            child: CupertinoTextField(
              controller: input2,
              placeholder: "Enter the values",
            )),
        prefix: Text(
          "Respiratory\nRate",
          style: Normal,
          softWrap: true,
        ),
      ),
      CupertinoFormRow(
        child: SizedBox(
            width: 70.w,
            height: 6.h,
            child: CupertinoTextField(
              controller: input3,
              placeholder: "Enter the values",
            )),
        prefix: Text(
          "Heart Rate",
          style: Normal,
        ),
      ),
      CupertinoFormRow(
        child: SizedBox(
            width: 70.w,
            height: 6.h,
            child: CupertinoTextField(
              controller: input4,
              placeholder: "Enter the values",
            )),
        prefix: Text(
          "SPO2\n@Room Air",
          style: Normal,
        ),
      ),
      CupertinoFormRow(
        child: SizedBox(
            width: 70.w,
            height: 6.h,
            child: CupertinoTextField(
              controller: input5,
              placeholder: "Enter the values",
            )),
        prefix: Text(
          "Decrease in\nurine output",
          style: Normal,
        ),
      ),
      CupertinoFormRow(
          prefix: Text("Daily dressing done ?"),
          child: SizedBox(
            width: 50.w,
            height: 5.5.h,
            child: CupertinoTextField(
              readOnly: true,
              placeholder: " ",
              controller: dropmenu,
              suffix: PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = true;
                        no_selected = false;
                        dropmenu.text = "yes";
                      });
                    },
                    selected: yes_selected,
                    title: 'Yes',
                  ),
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = false;
                        no_selected = true;
                        dropmenu.text = "No";
                      });
                    },
                    selected: no_selected,
                    title: 'No',
                    isDestructive: true,
                  ),
                ],
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  child: const Icon(
                    CupertinoIcons.chevron_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )),
      CupertinoFormRow(
          prefix: Text("Trachestomy tie\nchanged ?"),
          child: SizedBox(
            width: 50.w,
            height: 5.5.h,
            child: CupertinoTextField(
              readOnly: true,
              placeholder: " ",
              controller: dropmenu1,
              suffix: PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = true;
                        no_selected = false;
                        dropmenu1.text = "yes";
                      });
                    },
                    selected: yes_selected,
                    title: 'Yes',
                  ),
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = false;
                        no_selected = true;
                        dropmenu1.text = "No";
                      });
                    },
                    selected: no_selected,
                    title: 'No',
                    isDestructive: true,
                  ),
                ],
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  child: const Icon(
                    CupertinoIcons.chevron_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )),
      CupertinoFormRow(
          prefix: Text("Suctioning done ?"),
          child: SizedBox(
            width: 50.w,
            height: 5.5.h,
            child: CupertinoTextField(
              readOnly: true,
              placeholder: " ",
              controller: dropmenu2,
              suffix: PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = true;
                        no_selected = false;
                        dropmenu2.text = "yes";
                      });
                    },
                    selected: yes_selected,
                    title: 'Yes',
                  ),
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = false;
                        no_selected = true;
                        dropmenu2.text = "No";
                      });
                    },
                    selected: no_selected,
                    title: 'No',
                    isDestructive: true,
                  ),
                ],
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  child: const Icon(
                    CupertinoIcons.chevron_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )),
      CupertinoFormRow(
          prefix: Text("Has the patient\nstarted on oral feeds ?"),
          child: SizedBox(
            width: 50.w,
            height: 5.5.h,
            child: CupertinoTextField(
               readOnly: true,
              placeholder: " ",
              controller: dropmenu3,
              suffix: PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = true;
                        no_selected = false;
                        dropmenu3.text = "yes";
                      });
                    },
                    selected: yes_selected,
                    title: 'Yes',
                  ),
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = false;
                        no_selected = true;
                        dropmenu3.text = "No";
                      });
                    },
                    selected: no_selected,
                    title: 'No',
                    isDestructive: true,
                  ),
                ],
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  child: const Icon(
                    CupertinoIcons.chevron_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )),
      CupertinoFormRow(
          prefix: Text("Has the patient been\nchanged to green tube?"),
          child: SizedBox(
            width: 50.w,
            height: 5.5.h,
            child: CupertinoTextField(
               readOnly: true,
              placeholder: " ",
              controller: dropmenu4,
              suffix: PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = true;
                        no_selected = false;
                        dropmenu4.text = "yes";
                      });
                    },
                    selected: yes_selected,
                    title: 'Yes',
                  ),
                  PullDownMenuItem.selectable(
                    onTap: () {
                      setState(() {
                        yes_selected = false;
                        no_selected = true;
                        dropmenu4.text = "No";
                      });
                    },
                    selected: no_selected,
                    title: 'No',
                    isDestructive: true,
                  ),
                ],
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  child: const Icon(
                    CupertinoIcons.chevron_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )),
      CupertinoFormSection(
        header: Text("Spigotting status"),
        children: [
          CupertinoFormRow(
              child: Text(
                  "Is the patient able berath through noise, while blocking the tube with hands ?")),
          CupertinoFormRow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              custom_Button(
                  text: "Yes",
                  width: 40,
                  height: 6,
                  backgroundColor: Colors.green,
                  textcolor: whiteColor,
                  button_funcation: (){},
                  textSize: 10.5),



                  custom_Button(
                  text: "No",
                  width: 40,
                  height: 6,
                  button_funcation: (){},
                  backgroundColor: Colors.red,
                  textcolor: whiteColor,
                  textSize: 10.5)
            ],
          ))
        ],
      ),

      Gap(3.h),
      
       

    ]);
  }
}
