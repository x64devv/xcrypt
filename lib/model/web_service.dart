import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'coin_data.dart';
import 'database_services.dart';

class WebService {
  Future<List<num>> getCoinH1Data(String slug) {
    final url = Uri.https('min-api.cryptocompare.com', '/data/v2/histohour', {
      'api_key':
          'c0544d2bce8a8b1e6a4ad66e097e2aa17751ca9d941269737cbf202d6ba05d32',
      'fsym': slug,
      'tsym': 'USD',
      'limit': '12'
    });
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List quotes = json["Data"]["Data"];
        List<num> closeList = List.generate(quotes.length, (index) {
          return quotes[index]['close'];
        });

        return closeList;
      }

      return [];
    });
  }

  Future<List<num>> getCoinD1Data(String slug) {
    final url = Uri.https('min-api.cryptocompare.com', '/data/v2/histoday', {
      'api_key':
          'c0544d2bce8a8b1e6a4ad66e097e2aa17751ca9d941269737cbf202d6ba05d32',
      'fsym': slug,
      'tsym': 'USD',
      'limit': '12'
    });
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List quotes = json["Data"]["Data"];
        List<num> closeList = List.generate(quotes.length, (index) {
          return quotes[index]['close'];
        });

        return closeList;
      }

      return [];
    });
  }

  Future<List<num>> getCoinM1Data(String slug) {
    final url = Uri.https('min-api.cryptocompare.com', '/data/v2/histominute', {
      'api_key':
          'c0544d2bce8a8b1e6a4ad66e097e2aa17751ca9d941269737cbf202d6ba05d32',
      'fsym': slug,
      'tsym': 'USD',
      'limit': '12'
    });
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List quotes = json["Data"]["Data"];
        List<num> closeList = List.generate(quotes.length, (index) {
          return quotes[index]['close'];
        });

        return closeList;
      }

      return [];
    });
  }

  Future<List<CoinData>> getAllCoins() async {
    final url = Uri.https('min-api.cryptocompare.com', '/data/top/mktcapfull', {
      'api_key':
          'c0544d2bce8a8b1e6a4ad66e097e2aa17751ca9d941269737cbf202d6ba05d32',
      'tsym': 'USD',
      'limit': '12'
    });
    List<CoinData> favoriteAssets = await DBService().getFavoriteAssets();
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List coins = json['Data'];

        return List.generate(coins.length, (index) {
          var item = coins[index];
          int id = int.parse(item['CoinInfo']['Id']);
          return CoinData(
              id: id,
              slug: item['CoinInfo']['Name'],
              name: item['CoinInfo']['FullName'],
              image:
                  "https://cryptocompare.com/${item['CoinInfo']['ImageUrl']}",
              favorite: _searchCoin(favoriteAssets, id),
              price: item['RAW']['USD']['PRICE'],
              changeDay: item['RAW']['USD']['CHANGEPCT24HOUR'],
              changeHour: item['RAW']['USD']['CHANGEHOUR']);
        });
      }
      return [];
    });
  }

  Future<Map<String, dynamic>> getCoinQuote(String slug) {
    final url = Uri.https('min-api.cryptocompare.com', '/data/pricemultifull', {
      'api_key':
          'c0544d2bce8a8b1e6a4ad66e097e2aa17751ca9d941269737cbf202d6ba05d32',
      'tsyms': 'USD',
      'fsyms': slug,
    });
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        Map item = json['RAW'][slug]['USD'];
        return {
          'price': item['PRICE'],
          'changeDay': item['CHANGEPCT24HOUR'],
          'changeHour': item['CHANGEHOUR']
        };
      }
      return {};
    });
  }

  bool _searchCoin(List<CoinData> coins, int id) {
    for (CoinData data in coins) {
      if (data.id == id) {
        return true;
      }
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    try {
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user != null);
    } catch (e) {
      debugPrint("Oooops: ${e.toString()}");
      
    }
    return false;
  }

  Future<bool> signIn(String email, String password) {
    try {
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user != null);
    } catch (e) {
      debugPrint("Ooops: ${e.toString()}");
      return false as Future<bool>;
    }
  }
}
