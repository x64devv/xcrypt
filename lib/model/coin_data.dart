

import 'package:xcrypt/model/web_service.dart';

class CoinData {
  final int id;
  final String slug;
  final String name;
  final String image;
  num price;
  num changeDay;
  num changeHour;
  bool favorite;
  final webService = WebService();

  CoinData({
    required this.id,
    required this.slug,
    required this.name,
    required this.image,
    this.favorite = false,
    this.price = 0,
    this.changeDay = 0,
    this.changeHour = 0,
  });

  Future<List<num>> loadM1Data() async {
    return await webService.getCoinM1Data(slug);
  }

  Future<List<num>> loadH1Data() async {
    return await webService.getCoinH1Data(slug);
  }

  Future<List<num>> loadD1Data() async {
    final webService = WebService();
    return await webService.getCoinD1Data(slug);
  }

  Future<bool> getQuoute() async {
    Map<String, dynamic> quote = await webService.getCoinQuote(slug);
    price = quote['price'];
    changeHour = quote['changeHour'];
    changeDay = quote['changeDay'];
    return quote.isNotEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "slug": slug,
      "name": name,
      "image": image,
    };
  }
}
