import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import '../../../../model/coin_data.dart';
import '../../components/asset_chart.dart';

class AssetChartArea extends StatefulWidget {
  const AssetChartArea({super.key, required this.coinData});
  final CoinData coinData;

  @override
  State<AssetChartArea> createState() => _AssetChartAreaState();
}

class _AssetChartAreaState extends State<AssetChartArea> {
  int selectedTimeFrame = 1;
  Future<List<num>> getData(int timeframe) async {
    if (selectedTimeFrame == 0) {
      return widget.coinData.loadM1Data();
    } else if (selectedTimeFrame == 1) {
      return widget.coinData.loadH1Data();
    }
    return widget.coinData.loadD1Data();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
    
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (index) {
                List<String> timeFrames = ["Minute", "Hour", "Day"];
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedTimeFrame == index
                              ? kAccentColor
                              : Colors.transparent),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedTimeFrame = index;
                        });
                      },
                      child: Text(
                        timeFrames[index],
                        style: GoogleFonts.poppins(
                            color: kAccentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                );
              }),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            child: FutureBuilder(
                initialData: const <num>[],
                future: getData(selectedTimeFrame),
                builder: (context, AsyncSnapshot<List<num>> snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<FlSpot> spotData = [];
                    double x = 0;
                    for (num y in snapshot.data!) {
                      spotData.add(FlSpot(x, y.toDouble()));
                      x++;
                    }
                    return AssetChart(data: spotData);
                  }
                  return const Expanded(
                    child: Center(
                      child: Icon(
                        Icons.bar_chart_rounded,
                        color: kAccentColor,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
