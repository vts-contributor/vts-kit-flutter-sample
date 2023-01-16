import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class DoughnutChartWidget extends StatefulWidget {
  DoughnutChartWidget(
      {super.key,
      required this.chartData,
      required this.aspectRatio,
      required this.overflowMode,
      required this.orientation,
      required this.height,
      required this.position,
      required this.radius});
  final List<DoughnutChartData> chartData;
  double aspectRatio;
  LegendItemOverflowMode overflowMode;
  LegendItemOrientation orientation;
  LegendPosition position;
  String height;
  String radius;

  @override
  State<DoughnutChartWidget> createState() => _DoughnutChartWidgetState();
}

class _DoughnutChartWidgetState extends State<DoughnutChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: SfCircularChart(
            backgroundColor: Colors.white,
            legend: Legend(
              isVisible: true,
              toggleSeriesVisibility: true,
              isResponsive: false,
              itemPadding: 15,
              padding: 10,
              overflowMode: LegendItemOverflowMode.scroll,
              iconHeight: 20,
              iconWidth: 20,
              shouldAlwaysShowScrollbar: true,
              textStyle: const TextStyle(fontSize: 16),
              orientation: widget.orientation,
              alignment: ChartAlignment.center,
              position: widget.position,
              height: '40%',
            ),
            series: [
              DoughnutSeries<DoughnutChartData, String>(
                dataSource: widget.chartData,
                pointColorMapper: (DoughnutChartData data, _) => data.color,
                xValueMapper: (DoughnutChartData data, _) => data.x,
                yValueMapper: (DoughnutChartData data, _) => data.y.toInt(),
                radius: widget.radius,
                legendIconType: LegendIconType.rectangle,
                animationDuration: 1000,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                explode: true,
                explodeAll: true,
                explodeOffset: '1.5%',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoughnutChartData {
  DoughnutChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
