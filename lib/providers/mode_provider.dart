import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkmodeProvider = NotifierProvider<MyNotifier,bool>(() {
  return MyNotifier();
},);


class MyNotifier extends Notifier<bool>{
  @override
  bool build() {
    return state = false;
  }

  void changeMode(bool value){
    state = value;
  }
}