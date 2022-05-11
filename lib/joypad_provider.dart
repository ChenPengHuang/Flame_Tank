import 'package:flutter/foundation.dart';
import 'package:tank/helpers/direction.dart';

class JoypadProvider extends ChangeNotifier {

  ValueChanged<Direction>? _onDirectionChangeListener;


  void setDirectionChangeListener(ValueChanged<Direction> listener){
    _onDirectionChangeListener = listener;
  }


  void onDirectionChange(Direction direction){
    _onDirectionChangeListener?.call(direction);
  }

}
