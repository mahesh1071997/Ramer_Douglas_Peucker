import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'line_chart_controller.dart';

class LineChartPage extends StatelessWidget {
  const LineChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the LineChartController instance
    final LineChartController controller = Get.put(LineChartController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Line Chart'),
        actions: [
          Obx((){
            return Slider(
              value: controller.selectedValue.value,
              min: 0,
              max: 2,
              divisions: 1000, // Optional: makes the slider snap to whole numbers
              label: controller.selectedValue.value.toStringAsFixed(1),
              onChanged: (newValue) {
                controller.selectedValue.value = newValue; // Update the selected value
              },
            );
          }),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return LineChart(

            LineChartData(
              lineBarsData: [

                LineChartBarData(
                  spots: controller.rdp(controller.dataPoints,controller.selectedValue.value), // Data points from the controller
                  isCurved: true, // Straight lines between points
                  // color: Colors.blue,
                  gradient:  LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.blue,
                    ],
                  ),// Line color
                  barWidth: 2, // Thickness of the line
                )
              ],
              gridData: FlGridData(show: true), // Optional gridlines
              titlesData: FlTitlesData(show: true), // Optional titles
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black, width: 1), // Chart borders
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          controller.generateRandomData(100); // Regenerate data
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}