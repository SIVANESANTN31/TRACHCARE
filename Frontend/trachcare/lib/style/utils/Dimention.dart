// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';


class Dimentions {
   final BuildContext context;
   var size_w;
   var size_h;

  Dimentions(this.context){
    size_w = MediaQuery.sizeOf(context).width;
    size_h =MediaQuery.sizeOf(context).height;

  }

  double  width(double width){
    return width/100*size_w ;

  }
  double height(double height){
    return height/100*size_h;

  }
  
  
  


}