import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class FlSpot {
  final double x;
  final double y;

  FlSpot(this.x, this.y);
}

// Haversine distance for geographic coordinates (if needed, replace with Euclidean for Cartesian)
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

// Main function to simplify coordinates
List<FlSpot> simplifyCoordinates(List<FlSpot> coords, double epsilon, double proximityThreshold) {
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

// Example usage
void main() {
  List<FlSpot> coords = [
    FlSpot(1.0, 1.0),
    FlSpot(1.1, 1.1),
    FlSpot(1.2, 1.2),
    FlSpot(2.0, 2.0),
    // Add more coordinates as needed
  ];

  double epsilon = 0.5; // Tolerance for RDP
  double proximityThreshold = 0.2; // Distance threshold to consider points close enough

  List<FlSpot> simplifiedCoords = simplifyCoordinates(coords, epsilon, proximityThreshold);

  // Print simplified coordinates
  for (var coord in simplifiedCoords) {
    print("(${coord.x}, ${coord.y})");
  }
}