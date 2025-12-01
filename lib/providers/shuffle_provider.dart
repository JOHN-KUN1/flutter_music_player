import 'package:flutter_riverpod/flutter_riverpod.dart';

final shuffleProvider = NotifierProvider<ShuffleActiveNotifier, bool>((){
  return ShuffleActiveNotifier();
});

class ShuffleActiveNotifier extends Notifier<bool>{
  ShuffleActiveNotifier();

  @override
  bool build() {
    return state = false;
  }

  void shuffleActive(bool value){
    state = value;
  }
}