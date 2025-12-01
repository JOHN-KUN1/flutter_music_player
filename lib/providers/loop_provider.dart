
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loopProvider = NotifierProvider<LoopActiveNotifier,bool>((){
  return LoopActiveNotifier();
});

class LoopActiveNotifier extends Notifier<bool>{
  LoopActiveNotifier();

  @override
  bool build() {
    return state = false;
  }

  void loopActive(bool value){
    state = value;
  }
}