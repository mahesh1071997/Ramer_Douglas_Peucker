import 'package:flutter/material.dart';
import 'package:rdp_algo/rdp_algoithem/line_chart_view.dart';

import 'binary_search/binary_search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      /// this line comment for the RDP algorithm
      // home: LineChartPage(),

      /// below line is for the binary search
      home: BinarySearchScreen(),
    );
  }
}
