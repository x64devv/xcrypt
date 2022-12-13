import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

import 'model/database_services.dart';
import 'model/web3_services.dart';

const Color kPrimaryColor = Color(0xFF3F825D);
const Color kPrimaryGradientColor1 = Color(0xFF3F825D);
const Color kPrimaryGradientColor2 = Color.fromARGB(255, 3, 18, 10);
const List<Color> kGradientColors = [
  kPrimaryGradientColor1,
  kPrimaryGradientColor1
];
const Color kPrimaryDarkColor = Color(0xFF120E0B);
const Color kAccentColor = Color.fromARGB(255, 255, 255, 255);
List<Color> gradientColors = [
  // const Color(0xff23b6e6),
  // const Color(0xff02d39a),
  kAccentColor,
  kAccentColor,
  // kAccentColor,
];

LineChartData generateChartData(List<FlSpot> spotData) {
  double minX = 1000000000, maxX = 0, minY = 1000000000, maxY = 0;
  for (FlSpot spot in spotData) {
    if (spot.x < minX) {
      minX = spot.x;
    }
    if (spot.y < minY) {
      minY = spot.y;
    }

    if (spot.x > maxX) {
      maxX = spot.x;
    }
    if (spot.y > maxY) {
      maxY = spot.y;
    }
  }
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 2,
      verticalInterval: 1000,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 0,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 0,
        );
      },
    ),
    titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
          getTitlesWidget: (value, meta) {
            if (value < 4) {
              return Text("\$1k");
            }
            return Container();
          },
        )),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
    borderData: FlBorderData(
      show: false,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: minX,
    maxX: maxX,
    minY: minY - (minY * 0.01),
    maxY: maxY,
    lineBarsData: [
      LineChartBarData(
        spots: spotData,
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ),
    ],
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text('MAR', style: style);
      break;
    case 5:
      text = const Text('JUN', style: style);
      break;
    case 8:
      text = const Text('SEP', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '10K';
      break;
    case 3:
      text = '30k';
      break;
    case 5:
      text = '50k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Future<bool> writeFile(String text, String folder, String filename) async {
  final Directory directory = Directory(folder);
  final File file = File('${directory.path}/$filename');
  await file.writeAsString(text);
  return true;
}

requestStoragePermissions() async {
  final result = await Permission.storage.status;
  if (result.isGranted) {
    return true;
  } else {
    return Permission.storage.request().then((value) {
      return value.isGranted;
    });
  }
}

Future<List<Map<String, dynamic>>> fetchWallets() async {
  bool hasPermissions = await requestStoragePermissions();
  if (!hasPermissions) {
    final result = {'failed': true};
    return [result];
  }
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> wallets = [];
  List<Map<String, dynamic>> walletsMap = await DBService().getWallets();
  for (var walletMap in walletsMap) {
    Wallet wallet = Web3Services().loadWalletFromJSON(
        File(walletMap['filename']), prefs.getString(walletMap['walletName']));
    wallets.add(
        {'failed': false, 'wallet': wallet, 'name': walletMap['walletName']});
  }
  return wallets;
}

Future<Wallet?> getWalletCreds(String name) async {
  bool hasPermissions = await requestStoragePermissions();
  if (!hasPermissions) {
    return null;
  }
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> walletsMap = await DBService().getWallets();
  return Web3Services().loadWalletFromJSON(
      File(walletsMap[0]['filename']), prefs.getString(walletsMap[0]['walletName']));

}
