import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/dropdown_widget.dart';
import 'package:date_range_picker/date_range_picker.dart' as dateRagePicker;

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;
  List<double> values = [30.5, 69.5];
  String currentValue = 'Tất cả';
  String currentDate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: Text('Thống kê'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Card(
          //   color: AppColors.mainColor,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(20),
          //           bottomRight: Radius.circular(20))),
          //   margin: EdgeInsets.all(0),

          // ),
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
                        });
                        if (currentValue == 'Tùy chọn') {
                          var picker = await dateRagePicker.showDatePicker(
                            context: context,
                            initialFirstDate: DateTime.now(),
                            initialLastDate: DateTime.now(),
                            locale: Locale('vi'),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          print(picker);
                          if (picker != null) {
                            if (picker.length < 2) {
                              setState(() {
                                currentDate =
                                    convertDateTimeToDay(picker.first);
                              });
                            } else {
                              setState(() {
                                currentDate =
                                    convertDateTimeToDay(picker.first) +
                                        ' - ' +
                                        convertDateTimeToDay(picker.last);
                              });
                            }
                          }
                        }
                      }),
                )
              ],
            ),
          ),
          Visibility(
              visible: currentValue == 'Tùy chọn', child: Text(currentDate)),
          PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
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
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Indicator(
                color: Colors.blue,
                text: 'Thành công',
                isSquare: false,
              ),
              SizedBox(
                width: 10,
              ),
              Indicator(
                color: Colors.red,
                text: 'Thất bại',
                isSquare: false,
              ),
            ],
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final double fontSize = 16;
      final double radius = 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: values[0],
            title: '${values[0]}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: values[1],
            title: '${values[1]}%',
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
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
