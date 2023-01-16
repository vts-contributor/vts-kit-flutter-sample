import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class ColumnChartWidget extends StatefulWidget {
  ColumnChartWidget(
      {super.key,
      required this.chartData,
      required this.aspectRatio,
      required this.orientation,
      required this.position,
      required this.height});
  List<ColumnChartData> chartData;
  double aspectRatio;
  LegendItemOrientation orientation;
  LegendPosition position;
  String height;
  @override
  State<ColumnChartWidget> createState() => _ColumnChartWidgetState();
}

class _ColumnChartWidgetState extends State<ColumnChartWidget> {
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
          aspectRatio: 3 / 4,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            backgroundColor: Colors.white,
            legend: Legend(
              isVisible: true,
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
              height: widget.height,
            ),
            series: <CartesianSeries>[
              ColumnSeries<ColumnChartData, String>(
                dataSource: widget.chartData,
                xValueMapper: (ColumnChartData data, _) => data.x,
                yValueMapper: (ColumnChartData data, _) => data.y,
                // Map color for each data points from the data source
                pointColorMapper: (ColumnChartData data, _) => data.color,
                isVisible: true,

                isVisibleInLegend: true,
                legendIconType: LegendIconType.rectangle,
                animationDuration: 1000,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnChartData {
  ColumnChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}
