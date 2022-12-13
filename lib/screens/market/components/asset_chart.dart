import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AssetChart extends StatelessWidget {
  const AssetChart({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<FlSpot> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
             topLeft: Radius.circular(16),
             topRight: Radius.circular(16),
            ),
            color: kPrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 4, top: 16, bottom: 0),
            child: LineChart(
              generateChartData(data),
            ),
          ),
        ),
      ),
    );
  }
}
