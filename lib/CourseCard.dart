// CourseCard.dart

import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String courseName;
  final String courseDuration;

  CourseCard({required this.courseName, required this.courseDuration});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(courseName),
        subtitle: Text('Duration: $courseDuration'),
      ),
    );
  }
}
