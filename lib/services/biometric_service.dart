import 'package:local_auth/local_auth.dart';

class BiometricService {
  static LocalAuthentication _localAuthentication = LocalAuthentication();

  //check is device available for biometric or not
  Future<bool> canCheckBiometric() async {
    try {
      //return true or false
      bool result = await _localAuthentication.canCheckBiometrics;
      print('[FINISH] BiometricService:canCheckBiometric. result = $result ');

      return result;
    } catch (e) {
      print('[ERROR] BiometricService:canCheckBiometric. result = $e ');
      return false;
    }
  }

  //get biometric available on user device
  Future<List<BiometricType>> getAvailableBiometric() async {
    try {
      List<BiometricType> biometricTypes =
          await _localAuthentication.getAvailableBiometrics();
      print(
          '[FINISH] BiometricService:getAvailableBiometric. result = $biometricTypes ');
      return biometricTypes;
    } catch (e) {
      print('[ERROR] BiometricService:getAvailableBiometric. result = $e ');
      return [];
    }
  }

  //authentication with biometric
  Future<bool> authenticationWithBiometric(
      List<BiometricType> biometricTypes) async {
    try {
      if (biometricTypes.contains(BiometricType.fingerprint) ||
          biometricTypes.contains(BiometricType.face)) {
        //return true or false
        bool result = await _localAuthentication.authenticateWithBiometrics(
            localizedReason: '', stickyAuth: true, useErrorDialogs: true);
        print(
            '[FINISH] BiometricService:authenticationWithBiometric. result = $result ');
        return result;
      }
      //default result
      return false;
    } catch (e) {
      print(
          '[ERROR] BiometricService:authenticationWithBiometric. result = $e ');
      return false;
    }
  }
}
