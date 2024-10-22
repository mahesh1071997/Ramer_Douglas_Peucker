import 'package:flutter/material.dart';

class BinarySearchScreen extends StatefulWidget {
  @override
  _BinarySearchScreenState createState() => _BinarySearchScreenState();
}

class _BinarySearchScreenState extends State<BinarySearchScreen> {
  final List<int> sortedList = [2, 4, 7, 10, 14, 19, 22, 27, 33, 35, 49, 50,55,59,61,63,64,67,68,70,88];
  List<String> steps = [];
  int? low, high, mid; // Track the current low, high, and mid
  bool isSearching = false;
  int? selectedTarget;
  void binarySearch(int target) async {
    setState(() {
      low = 0;
      high = sortedList.length - 1;
      steps.clear(); // Clear previous steps
      isSearching = true;
    });

    while (low! <= high!) {
      setState(() {
        mid = (low! + (high! - low!) ~/ 2);
        steps.add(
            'Low: $low, High: $high, Mid: $mid, List[Mid]: ${sortedList[mid!]}');
      });

      // Simulate the delay for step-by-step visualization
      await Future.delayed(Duration(seconds: 4));

      if (sortedList[mid!] == target) {
        setState(() {
          steps.add('Target found at index: $mid');
          isSearching = false;
        });
        return;
      } else if (sortedList[mid!] < target) {
        setState(() {
          low = mid! + 1;
        });
      } else {
        setState(() {
          high = mid! - 1;
        });
      }
    }

    setState(() {
      steps.add('Target not found');
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Binary Search Visualizer')),
      body: Column(
        children: [
          // Display the array and highlight low, mid, high positions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  sortedList.length,
                      (index) => Container(
                    padding: EdgeInsets.all(10),
                    color: index == low
                        ? Colors.green
                        : index == mid
                        ? Colors.blue
                        : index == high
                        ? Colors.red
                        : Colors.grey[200],
                    child: Hero(
                      tag: "data",
                      child: Text(
                        index == low
                            ? "${sortedList[index]}\nLow"
                            : index == mid
                            ? "${sortedList[index]}\nMid"
                            : index == high
                            ? "${sortedList[index]}\nhigh"
                            : sortedList[index].toString(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Dropdown Button for selecting the target
          DropdownButton<int>(
            value: selectedTarget,
            hint: Text('Select Target'),
            items: sortedList.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: isSearching
                ? null
                : (int? newValue) {
              setState(() {
                selectedTarget = newValue;
              });
              if (newValue != null) {
                binarySearch(newValue);
              }
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Hero(
                      tag: "data",
                      child: Text(steps[index])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
