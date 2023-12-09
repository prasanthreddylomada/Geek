import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geek/CourseCard.dart';
import 'package:geek/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  List<Map<String, dynamic>> allCourses = [];
  List<Map<String, dynamic>> filteredCourses = [];
  bool isLoading = true;
  String loginMethod = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCourses();
    checkLoginMethod();
  }

  void checkLoginMethod() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in
      if (user.providerData.isNotEmpty) {
        loginMethod = user.providerData.first.providerId;
        Future.microtask(() => _showLoginAlert(loginMethod));
      }
    }
  }

  void _showLoginAlert(String loginMethod) {
    String message = 'Logged in using $loginMethod';
    _showAlert(message);
  }

// void _pushAllCoursesToFirebase() async {
//   try {
//     for (int i = 0; i < coursesData.length; i++) {
//       await FirebaseFirestore.instance.collection('courses').add({
//         'key': coursesData[i]['key'],
//         'name': coursesData[i]['name'],
//         'duration': coursesData[i]['duration'],
//         'image': coursesData[i]['image'],
//         'Introduction': coursesData[i]['Introduction'],
//         'Keypoints': coursesData[i]['Keypoints'],
//         'Explanation': coursesData[i]['Explanation'],
//         'Applications': coursesData[i]['Applications'],
//         'Challenges and Future': coursesData[i]['Challenges and Future'],
//       });
//     }
//     print('All courses pushed to Firebase successfully!');
//   } catch (err) {
//     _showAlert('Error pushing courses to Firebase: $err');
//   }
// }


void fetchCourses() async {
  try {
    QuerySnapshot<Map<String, dynamic>> coursesSnapshot =
        await FirebaseFirestore.instance.collection('courses').get();

    // Process the data from the snapshot
    List<Map<String, dynamic>> courses = coursesSnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) {
      return {
        'key': doc.id,
        'name': doc['name'] as String,
        'duration': doc['duration'] as String,
        'image': doc['image'] as String,
        'Introduction': doc['Introduction'] as String,
        'Keypoints': List<String>.from(doc['Keypoints'] as List<dynamic>),
        'Explanation': doc['Explanation'] as String,
        'Applications': List<String>.from(doc['Applications'] as List<dynamic>),
        'Challenges and Future': doc['Challenges and Future'] as String,
      };
    }).toList();
    print('All courses fetched from Firebase successfully!');
    setState(() {
      allCourses = courses;
      isLoading = false;
    });
  } catch (err) {
    _showAlert(err.toString());
  }
}



  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(snapshot.hasData);
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    SizedBox(height: 0),
                    Container(
                      width: double.infinity, // Set the width to take available space
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'lib/Assets/image-removebg-preview.png',
                            width: 100,
                            height: 100,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome to GeekLearn',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Get ready to level up your knowledge',
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // _pushAllCoursesToFirebase();
                              FirebaseAuth.instance.signOut();
                            },
                            icon: Icon(Icons.logout))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search for courses',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 12.0),
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
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 0, bottom: 5.0),
                                child: Text(
                                  'Your Searches',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            // Use a for loop to generate CourseCard widgets
                            for (int index = 0;
                                index < filteredCourses.length;
                                index++)
                              CourseCard(
                                  courseName: filteredCourses[index]['name']!,
                                  courseDuration: filteredCourses[index]['duration']!,
                                  courseImage: filteredCourses[index]['image']!,
                                  courseKey: filteredCourses[index]['key']!,
                                  introduction: filteredCourses[index]['Introduction']!,
                                  keypoints: filteredCourses[index]['Keypoints']!,
                                  explanation: filteredCourses[index]['Explanation']!,
                                  applications: filteredCourses[index]['Applications']!,
                                  challengesAndFuture: filteredCourses[index]['Challenges and Future']!,
                                )
                          ],
                        )),
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
                              courseImage: allCourses[i]['image']!,
                              courseKey: allCourses[i]['key']!,
                              introduction: allCourses[i]['Introduction']!,
                              keypoints: allCourses[i]['Keypoints']!,
                              explanation: allCourses[i]['Explanation']!,
                              applications: allCourses[i]['Applications']!,
                              challengesAndFuture: allCourses[i]['Challenges and Future']!,
                            )

                        ],
                      ),
                    ),
                  ],
                );
              } else {
                Future.microtask(() => _navigateToLogin(context));
                return Container();
              }
            }));
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

void _navigateToLogin(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
