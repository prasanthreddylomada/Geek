// HomePage.dart

import 'package:flutter/material.dart';
import 'package:geek/CourseCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> allCourses = [
    {
      'name': 'Course 1',
      'duration': '2 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Course 2',
      'duration': '3 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Course 3',
      'duration': '1.5 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Course 4',
      'duration': '4 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Information',
      'duration': '2.5 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Couhse 1',
      'duration': '2 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Couhse 2',
      'duration': '3 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
    {
      'name': 'Couhsr 3',
      'duration': '1.5 hours',
      'image': 'lib/Assets/image-removebg-preview.png'
    },
  ];

  List<Map<String, String>> filteredCourses = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'lib/Assets/image-removebg-preview.png',
                width: 100,
                height: 100,
              ),
              Column(
                children: [
                  Text(
                    'Welcome to GeekLearn',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Get ready to level up our knowledge',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search for courses',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: onSearchTextChanged,
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the heading only if the filteredCourses is not empty
                if (filteredCourses.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 0, bottom: 5.0),
                    child: Text(
                      'Your Searches',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                // Use a for loop to generate CourseCard widgets
                for (int index = 0; index < filteredCourses.length; index++)
                  CourseCard(
                    courseName: filteredCourses[index]['name']!,
                    courseDuration: filteredCourses[index]['duration']!,
                    courseImage: filteredCourses[index]['image']!,
                  ),
              ],
            )
          ),
          if (filteredCourses.isEmpty)
            Container(
              margin: EdgeInsets.zero,
              height: 0,
              width: 0,
            ),
          Container(
            margin: EdgeInsets.only(left: 15.0, top: 10, bottom: 5.0),
            child: Text(
              'Complete List of Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (int i = 0; i < allCourses.length; i++)
                  CourseCard(
                      courseName: allCourses[i]['name']!,
                      courseDuration: allCourses[i]['duration']!,
                      courseImage: allCourses[i]['image']!)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredCourses.clear();
      } else {
        filteredCourses = allCourses
            .where((course) => course['name']!
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }
}
