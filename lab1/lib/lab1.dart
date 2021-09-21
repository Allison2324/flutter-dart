import 'dart:math';

import 'package:lab1/lab1.dart';

void printInteger(int aNumber) {
  print('The number is $aNumber.');
}

class MyClassBase {
  int coord;

  MyClassBase.init(this.coord);
}

class MyClass extends MyClassBase {
  int x;
  int y;
  int _privatePoint = 0;

  MyClass({required this.x, required this.y}) : super.init(1);

  MyClass.init({required this.x, required this.y}) : super.init(x);

  factory MyClass.f(flag){
    return flag ? MyClass(x: 0, y: 0) : MyClass.init(x: -1, y: -1);
  }

  @override
  String toString() => "Point: ($x, $y)";

  get getPrivatePoint => _privatePoint;

  set setPrivatePoint(int x) => _privatePoint = x;
}

createPoint(dynamic x, dynamic y){
  x ??= 0;
  y ??= 0;
  dynamic point = x ?? y;
  return point;
}

Function distance(int x1, int y1){
  return (int x2, int y2) => sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2));
}

void myFunc(x, {y, point = const [0, 0]}){
  assert(y != null, "y not defined!");
  print("$x $y - $point");
}

mixin MyMixin{
  late int _number;
  void setNumber(int num){_number = num;}
  int get number => _number;
}

class Number with MyMixin{
  void showNumber(){
    print("Number is $number");
  }
}


