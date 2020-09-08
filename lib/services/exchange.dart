import 'networking.dart';

class Convertor {
  String currency;
  String crypto;

  void getCurrencyandCrypto(String curr, String cry) {
    currency = curr;
    crypto = cry;
  }

  Future<dynamic> getConvertedData() async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=';
    Networking requestSender = Networking(url: url);

    var convertedData = await requestSender.getData();
    return convertedData;
  }
}
