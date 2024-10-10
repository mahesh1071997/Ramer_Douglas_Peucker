import 'dart:math';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartController extends GetxController {

  var dataPoints = <FlSpot>[].obs;
  var selectedValue = 0.0.obs;

  void generateRandomData(int numberOfPoints) {
    Random random = Random();
    List<FlSpot> points = [];
    List<FlSpot> coords = [
      FlSpot(0.0, 0.0),
      FlSpot(1.0, 1.0),
      FlSpot(2.0, 2.0),
      FlSpot(3.0, 3.0),
      FlSpot(4.0, 4.0),
      FlSpot(5.0, 5.0),
      FlSpot(6.0, 5.5),
      FlSpot(6.5, 5.7),
      FlSpot(7.0, 6.0),
      FlSpot(7.5, 6.5),
      FlSpot(8.0, 6.8),
      FlSpot(8.5, 6.9),
      FlSpot(9.0, 7.0),
      FlSpot(10.0, 8.0),
      FlSpot(11.0, 9.0),
      FlSpot(12.0, 10.0),
      FlSpot(13.0, 10.5),
      FlSpot(14.0, 10.8),
      FlSpot(15.0, 11.0),
      FlSpot(16.0, 11.5),
      FlSpot(17.0, 11.7),
      FlSpot(18.0, 12.0),
      FlSpot(19.0, 12.5),
      FlSpot(20.0, 13.0),
      FlSpot(21.0, 13.5),
      FlSpot(22.0, 14.0),
      FlSpot(23.0, 14.5),
      FlSpot(24.0, 14.7),
      FlSpot(25.0, 15.0),
      FlSpot(26.0, 15.5),
      FlSpot(27.0, 15.7),
      FlSpot(28.0, 16.0),
      FlSpot(29.0, 16.5),
      FlSpot(30.0, 17.0),
      FlSpot(31.0, 17.5),
      FlSpot(32.0, 18.0),
      FlSpot(33.0, 18.5),
      FlSpot(34.0, 19.0),
      FlSpot(35.0, 19.5),
      FlSpot(36.0, 20.0),
      FlSpot(37.0, 20.5),
      FlSpot(38.0, 20.8),
      FlSpot(39.0, 21.0),
      FlSpot(40.0, 22.0),
      FlSpot(41.0, 23.0),
      FlSpot(42.0, 24.0),
      FlSpot(43.0, 25.0),
      FlSpot(44.0, 26.0),
      FlSpot(45.0, 27.0),
      FlSpot(46.0, 27.5),
      FlSpot(47.0, 28.0),
      FlSpot(48.0, 28.5),
      FlSpot(49.0, 29.0),
      FlSpot(50.0, 30.0),
      FlSpot(51.0, 30.5),
      FlSpot(52.0, 31.0),
      FlSpot(53.0, 31.5),
      FlSpot(54.0, 32.0),
      FlSpot(55.0, 32.5),
      FlSpot(56.0, 33.0),
      FlSpot(57.0, 33.5),
      FlSpot(58.0, 34.0),
      FlSpot(59.0, 34.5),
      FlSpot(60.0, 35.0),
      FlSpot(61.0, 35.5),
      FlSpot(62.0, 36.0),
      FlSpot(63.0, 36.5),
      FlSpot(64.0, 37.0),
      FlSpot(65.0, 37.5),
      FlSpot(66.0, 38.0),
      FlSpot(67.0, 38.5),
      FlSpot(68.0, 39.0),
      FlSpot(69.0, 39.5),
      FlSpot(70.0, 40.0),
      FlSpot(71.0, 40.5),
      FlSpot(72.0, 41.0),
      FlSpot(73.0, 41.5),
      FlSpot(74.0, 42.0),
      FlSpot(75.0, 42.5),
      FlSpot(76.0, 43.0),
      FlSpot(77.0, 43.5),
      FlSpot(78.0, 44.0),
      FlSpot(79.0, 44.5),
      FlSpot(80.0, 45.0),
      FlSpot(81.0, 45.5),
      FlSpot(82.0, 46.0),
      FlSpot(83.0, 46.5),
      FlSpot(84.0, 47.0),
      FlSpot(85.0, 47.5),
      FlSpot(86.0, 48.0),
      FlSpot(87.0, 48.5),
      FlSpot(88.0, 49.0),
      FlSpot(89.0, 49.5),
      FlSpot(90.0, 50.0),
      FlSpot(91.0, 50.5),
      FlSpot(92.0, 51.0),
      FlSpot(93.0, 51.5),
      FlSpot(94.0, 52.0),
      FlSpot(95.0, 52.5),
      FlSpot(96.0, 53.0),
      FlSpot(97.0, 53.5),
      FlSpot(98.0, 54.0),
      FlSpot(99.0, 54.5),
      FlSpot(100.0, 55.0),
    ];

    for (int i = 0; i < numberOfPoints; i++) {
      double x = i.toDouble();
      double y = random.nextDouble() * 50; // Random y value between 0-100
      points.add(FlSpot(x, y));
    }

    // if you want  rendom value then use points List
    dataPoints.assignAll(coords);
  }
  // double perpendicularDistance(FlSpot p, FlSpot start, FlSpot end) {
  //   double area = (end.y - start.y) * p.x - (end.x - start.x) * p.y + end.x * start.y - end.y * start.x;
  //   double bottom = sqrt(pow(end.y - start.y, 2) + pow(end.x - start.x, 2));
  //   return (area.abs() / bottom);
  // }
  //
  // List<FlSpot> rdp(List<FlSpot> points, double epsilon) {
  //   int start = 0;
  //   int end = points.length - 1;
  //
  //   // If the line is too short, return the endpoints
  //   if (end <= start + 1) {
  //     return [points[start], points[end]];
  //   }
  //
  //   // Find the point with the maximum distance from the line segment
  //   double maxDistance = 0.0;
  //   int index = 0;
  //
  //   for (int i = start + 1; i < end; i++) {
  //     double distance = perpendicularDistance(points[i], points[start], points[end]);
  //     if (distance > maxDistance) {
  //       maxDistance = distance;
  //       index = i;
  //     }
  //   }
  //
  //   // If the max distance is greater than epsilon, recursively simplify
  //   List<FlSpot> result;
  //   if (maxDistance > epsilon) {
  //     result = rdp(points.sublist(start, index + 1), epsilon);
  //     result.removeLast();
  //     result.addAll(rdp(points.sublist(index, end + 1), epsilon));
  //   } else {
  //     result = [points[start], points[end]];
  //   }
  //
  //   return result;
  // }


  // Called when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    generateRandomData(40); // Generate 1000 points at start
  }



// Haversine distance for geographic FlSpots (if needed, replace with Euclidean for Cartesian)
  double haversineDistance(FlSpot coord1, FlSpot coord2) {
    return sqrt(pow(coord2.x - coord1.x, 2) + pow(coord2.y - coord1.y, 2));
  }

// Check if two points are close enough to be considered redundant
  bool isCloseEnough(FlSpot p1, FlSpot p2, double threshold) {
    return haversineDistance(p1, p2) < threshold;
  }

// Function to filter close points
  List<FlSpot> filterClosePoints(List<FlSpot> coords, double threshold) {
    List<FlSpot> filtered = [];
    filtered.add(coords[0]); // Add the first point

    for (int i = 1; i < coords.length; i++) {
      if (!isCloseEnough(filtered.last, coords[i], threshold)) {
        filtered.add(coords[i]); // Only add if it's not too close
      }
    }

    return filtered;
  }

// Implement the RDP algorithm
  List<FlSpot> rdp(List<FlSpot> coords, double epsilon) {
    if (coords.length < 3) return coords;

    FlSpot start = coords.first;
    FlSpot end = coords.last;
    double maxDist = 0;
    int index = 0;

    for (int i = 1; i < coords.length - 1; i++) {
      double dist = perpendicularDistance(coords[i], start, end);
      if (dist > maxDist) {
        maxDist = dist;
        index = i;
      }
    }

    if (maxDist > epsilon) {
      List<FlSpot> left = rdp(coords.sublist(0, index + 1), epsilon);
      List<FlSpot> right = rdp(coords.sublist(index), epsilon);
      return left.sublist(0, left.length - 1) + right;
    } else {
      return [start, end];
    }
  }

// Calculate the perpendicular distance from a point to a line segment
  double perpendicularDistance(FlSpot point, FlSpot start, FlSpot end) {
    if (start.x == end.x && start.y == end.y) {
      return haversineDistance(point, start);
    }

    double num = ((end.y - start.y) * (point.x - start.x)) - ((end.x - start.x) * (point.y - start.y));
    double den = haversineDistance(start, end);

    return (num.abs() / den); // Use num.abs() to get the absolute value
  }

// Main function to simplify FlSpots
  List<FlSpot> simplifyFlSpots(List<FlSpot> coords, double epsilon, double proximityThreshold) {
    // Step 1: Filter close points
    List<FlSpot> filteredCoords = filterClosePoints(coords, proximityThreshold);

    // Step 2: Apply RDP algorithm
    List<FlSpot> simplifiedCoords = rdp(filteredCoords, epsilon);

    // Step 3: Limit to maximum 80 to 90 points
    if (simplifiedCoords.length > 90) {
      return simplifiedCoords.sublist(0, 90); // Limit to 90 points
    }

    return simplifiedCoords;
  }




}



