import 'package:flutter/material.dart';
import 'package:geek/CourseCard.dart';
import 'dart:io';

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
        title: Text(
          courseName,
          style: TextStyle(
            fontSize: 25,
          ),
          ),
        backgroundColor: Color.fromRGBO(156, 191, 96, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            CourseCard(courseName: courseName, courseDuration: courseDuration, courseImage: courseImage, courseKey: courseKey, courseDetail: courseDetail),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
              child: Text(
              courseDetail,
              style: TextStyle(fontSize: 20),
            ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
              padding: EdgeInsets.all(10), // Add padding for better aesthetics
              decoration: BoxDecoration(
                // color: Color.fromRGBO(156, 191, 96, 1), // Set the background color
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Congratulations on completing',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    '$courseName',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            )            
          ],
        ),
      ),
    );
  }
}
