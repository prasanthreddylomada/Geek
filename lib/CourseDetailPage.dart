import 'package:flutter/material.dart';
import 'package:geek/CourseCard.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseName;
  final String courseDuration;
  final String courseImage;
  final String courseDetail;
  final String courseKey;

  // Use const constructor for named parameters
  const CourseDetailPage({
    Key? key,
    required this.courseName,
    required this.courseDuration,
    required this.courseImage,
    required this.courseDetail,
    required this.courseKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Color.fromRGBO(156, 191, 96, 1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseCard(courseName: courseName, courseDuration: courseDuration, courseImage: courseImage, courseKey: courseKey, courseDetail: courseDetail),
          Text('Detail:$courseDetail'),
        ],
      ),
    );
  }
}
