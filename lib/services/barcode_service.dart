import 'package:qrscan/qrscan.dart' as scanner;

class BarcodeService {
  Future scanBarcode() async {
    return await scanner.scan();
  }
}
