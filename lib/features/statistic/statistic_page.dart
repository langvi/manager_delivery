import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_widget.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentPage = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Text('Thống kê'),
        // bottom: TabBar(
        //   unselectedLabelColor: Colors.grey,
        //   labelColor: Colors.black,
        //   onTap: (value) {
        //     setState(() {
        //       currentPage = value;
        //     });
        //   },
        //   controller: _tabController,
        //   indicatorColor: Colors.black,
        //   indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        //   indicatorSize: TabBarIndicatorSize.tab,
        //   indicatorWeight: 1.5,
        //   tabs: [
        //     Tab(
        //       child: Text(
        //         '',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //     Tab(
        //       child: Text(friendRequest.toUpperCase(),
        //           style: TextStyle(fontWeight: FontWeight.bold)),
        //     )
        //   ],
        // ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        // _buildChart()
      ],
    );
  }

  Widget _buildChart() {
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.red, strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.blue, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Mot';
                case 2:
                  return 'Hai';
                case 3:
                  return 'Ba';
              }
              return '';
            }),
        leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return '10k';
                case 2:
                  return '20k';
                case 3:
                  return '30k';

                default:
                  return '';
              }
            }),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(3, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: AppColors.gradientAll,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData:
              BarAreaData(show: true, colors: AppColors.gradientShipped),
        ),
      ],
    ));
  }
}
