import 'package:flashlight/flashlight.dart';

class FlashLightService {
  //check is the device has flashlight or not
  Future<bool> isHasFlashlight() async {
    bool result = await Flashlight.hasFlashlight ?? false;
    print('(TRACE) FlashLightService:isHasFlashlight. result: $result');
    return result;
  }

  //turn on
  Future<bool> turnOn() async {
    bool result = true;
    await Flashlight.lightOn().catchError((e) => result = false);
    print('(TRACE) FlashLightService:turnOn. result: $result');
    return result;
  }
  //turn off

  Future<bool> turnOff() async {
    bool result = true;
    await Flashlight.lightOff().catchError((e) => result = false);
    print('(TRACE) FlashLightService:turnOff. result: $result');
    return result;
  }
}
