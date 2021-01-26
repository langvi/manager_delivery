import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/statistic/bloc/statistic_bloc.dart';
import 'package:manage_delivery/features/statistic/circle_chart.dart';
import 'package:manage_delivery/features/statistic/model/chart_response.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/dropdown_widget.dart';
import 'package:date_range_picker/date_range_picker.dart' as dateRagePicker;

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState
    extends BaseStatefulWidgetState<StatisticPage, StatisticBloc> {
  int touchedIndex;
  String currentValue = 'Tất cả';
  String currentDate = '';
  int currentPage = 0;
  DataChart dataChart;
  @override
  void initBloc() {
    bloc = StatisticBloc();
    bloc.add(GetInforByTime());
    dataChart = DataChart();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<StatisticBloc>(
      create: (context) => bloc,
      child: BlocConsumer<StatisticBloc, StatisticState>(
        listener: (context, state) {
          if (state is Loading) {
            isShowLoading = true;
          } else if (state is GetInforSuccess) {
            isShowLoading = false;
            dataChart = state.data;
          } else if (state is Error) {
            isShowLoading = false;
          }
        },
        builder: (context, state) {
          return baseShowLoading(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.mainColor,
                elevation: 0,
                title: Text('Thống kê'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Hàng hóa giao nhận',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: buildDropDown(
                              values: [
                                'Tất cả',
                                'Hôm nay',
                                'Tuần này',
                                'Tháng này',
                                'Tùy chọn'
                              ],
                              hintText: 'Chọn thời gian',
                              currentValue: currentValue,
                              // isColorWhite: true,
                              onChange: (value) async {
                                setState(() {
                                  currentValue = value;
                                  getDataByTime(currentValue);
                                  // bloc.add(GetInforByTime());
                                });
                                if (currentValue == 'Tùy chọn') {
                                  var picker =
                                      await dateRagePicker.showDatePicker(
                                    context: context,
                                    initialFirstDate: DateTime.now(),
                                    initialLastDate: DateTime.now(),
                                    locale: Locale('vi'),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picker != null) {
                                    if (picker.length < 2) {
                                      setState(() {
                                        currentDate =
                                            convertDateTimeToDay(picker.first);
                                      });
                                    } else {
                                      setState(() {
                                        currentDate = convertDateTimeToDay(
                                                picker.first) +
                                            '-' +
                                            convertDateTimeToDay(picker.last);
                                      });
                                    }
                                    getTimeChoice(currentDate, picker.length);
                                  }
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: currentValue == 'Tùy chọn',
                      child: Text(currentDate)),
                  hasData()
                      ? PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                setState(() {
                                  if (pieTouchResponse.touchInput
                                          is FlLongPressEnd ||
                                      pieTouchResponse.touchInput is FlPanEnd) {
                                    touchedIndex = -1;
                                  } else {
                                    print(pieTouchResponse.touchedSectionIndex);
                                    // touchedIndex = pieTouchResponse.touchedSectionIndex;
                                  }
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 20,
                              sections: showingSections()),
                        )
                      : Container(
                          height: 200,
                          child: Center(child: Text('Không có dữ liệu')),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: hasData(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Indicator(
                          color: Colors.blue,
                          text: 'Đã giao',
                          isSquare: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Indicator(
                            color: Colors.green,
                            text: 'Đang giao',
                            isSquare: false,
                          ),
                        ),
                        Indicator(
                          color: Colors.orange,
                          text: 'Đang lấy',
                          isSquare: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final double fontSize = 16;
      final double radius = 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: dataChart.percentShipping,
            title: dataChart.percentShipping == 0
                ? ''
                : '${getValue(dataChart.percentShipping)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: dataChart.percentShiped,
            title: dataChart.percentShiped == 0
                ? ''
                : '${getValue(dataChart.percentShiped)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.orange,
            value: dataChart.percentGetting,
            title: dataChart.percentGetting == 0
                ? ''
                : '${getValue(dataChart.percentGetting)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  void getDataByTime(String time, {int type = 1}) {
    switch (time) {
      case 'Tất cả':
        bloc.add(GetInforByTime());
        break;
      case 'Hôm nay':
        getToday();
        break;
      case 'Tuần này':
        getThisWeek();
        break;
      case 'Tháng này':
        getThisMonth();
        break;
      default:
      // getTimeChoice(time, type);
    }
  }

  void getToday() {
    // String today = getDateFromDropDown('Hôm nay').first;
    DateTime currentTime = DateTime.now();
    DateTime fromDate =
        DateTime(currentTime.year, currentTime.month, currentTime.day);
    DateTime toDate =
        DateTime(currentTime.year, currentTime.month, currentTime.day + 1);
    bloc.add(GetInforByTime(fromDate: fromDate, toDate: toDate));
  }

  void getThisWeek() {
    var thisWeek = getDateFromDropDown('Tuần này');
    // DateTime fromDate = DateTime.parse(thisWeek.first);
    DateTime fromDate = DateFormat(PATTERN_1).parse(thisWeek.first);
    DateTime toDate = DateFormat(PATTERN_1).parse(thisWeek.last);
    bloc.add(GetInforByTime(fromDate: fromDate, toDate: toDate));
  }

  void getThisMonth() {
    var thisMonth = getDateFromDropDown('Tháng này');
    DateTime fromDate = DateFormat(PATTERN_1).parse(thisMonth.first);
    DateTime toDate = DateFormat(PATTERN_1).parse(thisMonth.last);
    bloc.add(GetInforByTime(fromDate: fromDate, toDate: toDate));
  }

  void getTimeChoice(String date, int oneChoice) {
    if (oneChoice == 1) {
      DateTime startTime = DateFormat(PATTERN_1).parse(date);
      DateTime endTime =
          DateTime(startTime.year, startTime.month, startTime.day + 1);
      bloc.add(GetInforByTime(fromDate: startTime, toDate: endTime));
    } else {
      var time = date.split('-');
      DateTime fromDate = DateFormat(PATTERN_1).parse(time.first);
      DateTime toDate = DateFormat(PATTERN_1).parse(time.last);
      bloc.add(GetInforByTime(fromDate: fromDate, toDate: toDate));
    }
  }

  bool hasData() {
    return !(dataChart.percentGetting == 0 &&
        dataChart.percentShipping == 0 &&
        dataChart.percentShiped == 0);
  }

  String getValue(double value) {
    return value.toStringAsFixed(2);
    // return '';
  }
}
