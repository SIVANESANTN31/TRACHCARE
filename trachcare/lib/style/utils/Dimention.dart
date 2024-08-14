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
    return width *size_w /100;

  }
  double height(double height){
    return height *size_w /100;

  }
  
  
  


}