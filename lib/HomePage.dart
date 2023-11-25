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
    {'name': 'Course 1', 'duration': '2 hours'},
    {'name': 'Course 2', 'duration': '3 hours'},
    {'name': 'Course 3', 'duration': '1.5 hours'},
    {'name': 'Course 4', 'duration': '4 hours'},
    {'name': 'Information', 'duration': '2.5 hours'},
  ];

  List<Map<String, String>> filteredCourses = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold), // set the font size as per your requirement
                    ),
                    Text(
                      'Get ready to level up our knowledge',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )
                
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search for courses',
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                return CourseCard(
                  courseName: filteredCourses[index]['name']!,
                  courseDuration: filteredCourses[index]['duration']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredCourses = allCourses
          .where((course) =>
              course['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }
}
