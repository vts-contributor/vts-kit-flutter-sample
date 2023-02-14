import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/pages/dashboard/components/column_chart_widget.dart';
import 'package:sample/pages/dashboard/components/doughnut_chart_widget.dart';
import 'package:sample/pages/dashboard/components/pyramid_chart_widget.dart';
import 'package:flutter_core/difference_screens/mixin_adaptive_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AdaptivePage {
  final List<DoughnutChartData> chartData1 = [
    DoughnutChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
    DoughnutChartData('Steve', 38, const Color.fromRGBO(147, 0, 119, 1)),
    DoughnutChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
    DoughnutChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
  ];
  final List<DoughnutChartData> chartData2 = [
    DoughnutChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
    DoughnutChartData('Steve', 38, const Color.fromRGBO(147, 0, 119, 1)),
    DoughnutChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
  ];
  final List<ColumnChartData> chartData3 = [
    ColumnChartData('Germany', 22, Colors.greenAccent),
    ColumnChartData('Russia', 28, Colors.orange),
    ColumnChartData('Norway', 50, Colors.blue),
  ];
  final List<PyramidChartData> chartData4 = [
    PyramidChartData('David', 25),
    PyramidChartData('Steve', 38),
    PyramidChartData('Jack', 34),
    PyramidChartData('Others', 52)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: adaptiveBody(context),
      ),
    );
  }

  Widget titleChart(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Opacity(
          opacity: 0.7,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  phoneScreenPortrait(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData1,
              aspectRatio: 3 / 4,
              overflowMode: LegendItemOverflowMode.scroll,
              orientation: LegendItemOrientation.vertical,
              position: LegendPosition.bottom,
              height: '40%',
              radius: '85%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData2,
              aspectRatio: 3 / 4,
              overflowMode: LegendItemOverflowMode.scroll,
              orientation: LegendItemOrientation.vertical,
              position: LegendPosition.bottom,
              height: '40%',
              radius: '85%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Column Chart"),
            ColumnChartWidget(
                chartData: chartData3,
                aspectRatio: 3 / 4,
                orientation: LegendItemOrientation.vertical,
                position: LegendPosition.bottom,
                height: '80%'),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Pyramid Chart"),
            PyramidChartWidget(
                chartData: chartData4,
                aspectRatio: 3 / 4,
                orientation: LegendItemOrientation.vertical,
                position: LegendPosition.bottom,
                height: '40%',
                chartHeight: '100%'),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  phoneScreenLandscape(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData1,
              aspectRatio: 5 / 3,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.vertical,
              position: LegendPosition.right,
              height: '20%',
              radius: '70%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData2,
              aspectRatio: 5 / 3,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.vertical,
              position: LegendPosition.right,
              height: '20%',
              radius: '70%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Column Chart"),
            ColumnChartWidget(
                chartData: chartData3,
                aspectRatio: 5 / 3,
                orientation: LegendItemOrientation.vertical,
                position: LegendPosition.right,
                height: '20%'),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Pyramid Chart"),
            PyramidChartWidget(
                chartData: chartData4,
                aspectRatio: 5 / 3,
                orientation: LegendItemOrientation.vertical,
                position: LegendPosition.right,
                height: '40%',
                chartHeight: '70%'),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  tabletScreenLandscape(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData1,
              aspectRatio: 7 / 3,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.vertical,
              position: LegendPosition.right,
              height: '80%',
              radius: '90%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData2,
              aspectRatio: 7 / 3,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.vertical,
              position: LegendPosition.right,
              height: '80%',
              radius: '90%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Column Chart"),
            ColumnChartWidget(
                chartData: chartData3,
                aspectRatio: 15 / 2,
                orientation: LegendItemOrientation.vertical,
                position: LegendPosition.right,
                height: '20%'),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Pyramid Chart"),
            PyramidChartWidget(
                chartData: chartData4,
                aspectRatio: 6 / 3,
                orientation: LegendItemOrientation.vertical,
                position: LegendPosition.right,
                height: '40%',
                chartHeight: '80%'),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  tabletScreenPortrait(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData1,
              aspectRatio: 7 / 3,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.horizontal,
              position: LegendPosition.bottom,
              height: '80%',
              radius: '90%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Doughnut Chart"),
            DoughnutChartWidget(
              chartData: chartData2,
              aspectRatio: 7 / 3,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.horizontal,
              position: LegendPosition.bottom,
              height: '80%',
              radius: '90%',
            ),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Column Chart"),
            ColumnChartWidget(
                chartData: chartData3,
                aspectRatio: 15 / 2,
                orientation: LegendItemOrientation.horizontal,
                position: LegendPosition.bottom,
                height: '50%'),
            SizedBox(
              height: 20.h,
            ),
            titleChart("Pyramid Chart"),
            PyramidChartWidget(
                chartData: chartData4,
                aspectRatio: 3 / 2,
                orientation: LegendItemOrientation.horizontal,
                position: LegendPosition.bottom,
                height: '40%',
                chartHeight: '80%'),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget tabletLandscapeBody(BuildContext context, Size size) {
    return tabletScreenLandscape(context);
  }

  @override
  Widget tabletPortraitBody(BuildContext context, Size size) {
    return tabletScreenPortrait(context);
  }

  @override
  Widget landscapeBody(BuildContext context, Size size) {
    return phoneScreenLandscape(context);
  }

  @override
  Widget portraitBody(BuildContext context, Size size) {
    return phoneScreenPortrait(context);
  }
}
