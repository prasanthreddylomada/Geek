import 'package:flutter/material.dart';
import 'package:geek/CourseDetailPage.dart';
class CourseCard extends StatelessWidget {
  final String courseName;
  final String courseDuration;
  final String courseImage;
  final String courseKey;
  final String courseDetail;

  CourseCard({
    required this.courseName,
    required this.courseDuration,
    required this.courseImage,
    required this.courseKey,
    required this.courseDetail,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () {
        // Navigate to CourseDetailPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              key: ValueKey(courseKey),
              courseName: courseName,
              courseDuration: courseDuration,
              courseImage: courseImage,
              courseDetail: courseDetail,
              courseKey: courseKey,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35), // Adjust the value for the desired roundness
        child: Card(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          color: Color.fromRGBO(156, 191, 96, 1),
          child: Row(
            children: [
              Image.asset(
                courseImage,
                width: 100,
                height: 100,
              ),
              SizedBox(width: 10), // Add some spacing between image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Course: ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$courseName',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Duration: ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$courseDuration',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
