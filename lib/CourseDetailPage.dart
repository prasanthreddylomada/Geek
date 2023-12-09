import 'package:flutter/material.dart';
import 'package:geek/CourseCard.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseName;
  final String courseDuration;
  final String courseImage;
  final String introduction;
  final List<String> keypoints;
  final String explanation;
  final List<String> applications;
  final String challengesAndFuture;
  final String courseKey;

  // Use const constructor for named parameters
  const CourseDetailPage({
    Key? key,
    required this.courseName,
    required this.courseDuration,
    required this.courseImage,
    required this.introduction,
    required this.keypoints,
    required this.explanation,
    required this.applications,
    required this.challengesAndFuture,
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
            SizedBox(
              height: 10,
            ),
            CourseCard(
              courseName: courseName,
              courseDuration: courseDuration,
              courseImage: courseImage,
              courseKey: courseKey,
              introduction: introduction,
              keypoints: keypoints,
              explanation: explanation,
              applications: applications,
              challengesAndFuture: challengesAndFuture,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (dynamic entry in {
                          'Introduction': introduction ,
                          'Keypoints': keypoints ,
                          'Explanation': explanation ,
                          'Applications': applications ,
                          'Challenges and Future': challengesAndFuture ,
                        }.entries)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Render the key as bold and in a subsection style
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              // Check if the value is an array
                              if (entry.value is Iterable)
                                // If it's an array, iterate through its elements and display them as sub-subsections

                                for (var item in entry.value)
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "• $item",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                              else
                                // If it's not an array, display the value as a regular text
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    entry.value.toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              SizedBox(height: 10),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
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
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                        textAlign: TextAlign.center,
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
