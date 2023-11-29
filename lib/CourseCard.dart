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
        borderRadius: BorderRadius.circular(35),
        child: Card(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          color: Color.fromRGBO(156, 191, 96, 1),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Image.network(courseImage),
                height: 40,
                width: 40,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Course: ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Text(
                            '$courseName',
                            style: TextStyle(fontSize: 20),
                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
