import 'package:flutter/foundation.dart';
import 'package:tank/helpers/direction.dart';

class JoypadProvider extends ChangeNotifier {

  final List<ValueChanged<Direction>> _onDirectionChangeListeners = [];
  final List<VoidCallback> _onFireListeners = [];


  void addDirectionChangeListener(ValueChanged<Direction> listener){
    _onDirectionChangeListeners.add(listener);
  }

  void removeDirectionChangeListener(ValueChanged<Direction> listener){
    _onDirectionChangeListeners.remove(listener);
  }

  void onDirectionChange(Direction direction){
    for (var element in _onDirectionChangeListeners) {
      element.call(direction);
    }
  }


  void addOnFireListener(VoidCallback listener){
    _onFireListeners.add(listener);
  }

  void removeOnFireListener(VoidCallback listener){
    _onFireListeners.remove(listener);
  }
  void onFire() {
    for (var element in _onFireListeners) {
      element.call();
    }
  }
}
