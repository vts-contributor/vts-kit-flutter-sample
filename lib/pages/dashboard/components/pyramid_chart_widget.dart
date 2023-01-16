import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PyramidChartWidget extends StatefulWidget {
  PyramidChartWidget(
      {super.key,
      required this.chartData,
      required this.aspectRatio,
      required this.orientation,
      required this.position,
      required this.height,
      required this.chartHeight});
  List<PyramidChartData> chartData;
  double aspectRatio;
  LegendItemOrientation orientation;
  LegendPosition position;
  String height;
  String chartHeight;
  @override
  State<PyramidChartWidget> createState() => _PyramidChartWidgetState();
}

class _PyramidChartWidgetState extends State<PyramidChartWidget> {
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
          child: SfPyramidChart(
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
              textStyle: TextStyle(fontSize: 16),
              orientation: widget.orientation,
              alignment: ChartAlignment.center,
              position: widget.position,
              height: widget.height,
            ),
            series: PyramidSeries<PyramidChartData, String>(
              dataSource: widget.chartData,
              xValueMapper: (PyramidChartData data, _) => data.x,
              yValueMapper: (PyramidChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              height: widget.chartHeight,
            ),
          ),
        ),
      ),
    );
  }
}

class PyramidChartData {
  PyramidChartData(this.x, this.y);
  final String x;
  final double y;
}
