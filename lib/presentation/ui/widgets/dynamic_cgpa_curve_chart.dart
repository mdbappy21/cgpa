import 'package:cgpa/presentation/ui/utils/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DynamicCGPACurveChart extends StatelessWidget {
  final List<Map<String, dynamic>> semesterResults;

  const DynamicCGPACurveChart({super.key, required this.semesterResults});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: semesterResults.length.toDouble() - 1 + 1,
          minY: 0,
          maxY: 4,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < semesterResults.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        semesterResults[value.toInt()]["semester"].toString().replaceAll(' ', '\n'),
                        style: const TextStyle(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                reservedSize: 50,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: semesterResults.asMap().entries.map((entry) {
                int index = entry.key;
                double cgpa = entry.value["cgpa"];
                return FlSpot(index.toDouble(), cgpa);
              }).toList(),
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColors.themeColor1,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.withOpacity(0.6),
                    Colors.cyan.withOpacity(0.5),
                    Colors.cyan.withOpacity(0.6),
                    Colors.teal.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
