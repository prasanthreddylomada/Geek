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

  final List<Map<String, dynamic>> coursesData = [
    {
      "key": "1",
      "name": "Business Analytics",
      "duration": "2 hours",
      "image": "",
      "detail": {
        "definition": "Business Analytics involves the use of data analysis tools and techniques to make informed business decisions...",
        "types": {
          "descriptiveAnalytics": "Focuses on summarizing and presenting historical data...",
          "predictiveAnalytics": "Uses statistical algorithms and machine learning to predict future outcomes...",
          "prescriptiveAnalytics": "Provides recommendations for actions to optimize business processes..."
        },
        "applications": "Applications include market analysis, performance optimization, and risk management...",
        "challengesAndFuture": "Challenges involve data quality, integration of analytics into business processes, and staying abreast of evolving technologies..."
      }
    },
    {
      "key": "2",
      "name": "Data Science Fundamentals",
      "duration": "3 hours",
      "image": "",
      "detail": {
        "definition": "Data Science is a multidisciplinary field that uses scientific methods, processes, algorithms, and systems to extract insights and knowledge from structured and unstructured data...",
        "skills": ["data analysis", "machine learning", "statistics", "programming"],
        "applications": "Applications include predictive modeling, data-driven decision-making, and pattern recognition...",
        "challengesAndFuture": "Challenges involve handling big data, ensuring data privacy, and advancing research in artificial intelligence..."
      }
    },
    {
      "key": "3",
      "name": "Python Programming for Data Science",
      "duration": "4 hours",
      "image": "",
      "detail": {
        "description": "This course focuses on teaching the fundamentals of Python programming for data science...",
        "topicsCovered": ["variables", "data types", "control structures", "functions", "libraries for data science"],
        "applications": "Applications include data manipulation, analysis, and visualization using Python...",
        "challengesAndFuture": "Challenges involve code efficiency, version control, and staying updated with Python libraries for data science..."
      }
    },
    {
      "key": "4",
      "name": "Machine Learning for Beginners",
      "duration": "2.5 hours",
      "image": "",
      "detail": {
        "definition": "Machine Learning is a subset of artificial intelligence that focuses on the development of algorithms and models that enable computers to learn from data...",
        "types": ["supervisedLearning", "unsupervisedLearning", "reinforcementLearning"],
        "applications": "Applications include image recognition, natural language processing, and recommendation systems...",
        "challengesAndFuture": "Challenges involve overfitting, model interpretability, and selecting appropriate algorithms for specific tasks..."
      }
    },
    {
      "key": "5",
      "name": "Introduction to Cybersecurity",
      "duration": "2.5 hours",
      "image": "",
      "detail": {
        "definition": "Cybersecurity involves the protection of computer systems, networks, and data from theft, damage, or unauthorized access...",
        "topicsCovered": ["network security", "encryption", "firewalls", "malware detection"],
        "applications": "Applications include securing personal information, preventing cyber attacks, and ensuring the integrity of digital communication...",
        "challengesAndFuture": "Challenges involve adapting to evolving cyber threats, addressing vulnerabilities, and enhancing cybersecurity education..."
      }
    },
    {
      "key": "6",
      "name": "Web Development Basics",
      "duration": "3 hours",
      "image": "",
      "detail": {
        "description": "This course introduces the fundamental concepts of web development, including HTML, CSS, and JavaScript...",
        "topicsCovered": ["HTML", "CSS", "JavaScript", "responsive design"],
        "applications": "Applications include creating and styling web pages, adding interactivity, and ensuring compatibility across devices...",
        "challengesAndFuture": "Challenges involve browser compatibility, responsive design, and staying updated with web development frameworks..."
      }
    },
    {
      "key": "7",
      "name": "Artificial Intelligence in Healthcare",
      "duration": "2.5 hours",
      "image": "",
      "detail": {
        "description": "This course explores the applications of artificial intelligence in healthcare, including diagnosis, treatment planning, and personalized medicine...",
        "applications": "Applications include medical image analysis, predictive analytics for patient outcomes, and drug discovery...",
        "challengesAndFuture": "Challenges involve data privacy, regulatory compliance, and ethical considerations in using AI for healthcare..."
      }
    },
    {
      "key": "8",
      "name": "Quantum Computing Fundamentals",
      "duration": "3 hours",
      "image": "",
      "detail": {
        "definition": "Quantum Computing leverages the principles of quantum mechanics to perform computations that would be infeasible for classical computers...",
        "topicsCovered": ["qubits", "quantum gates", "quantum entanglement"],
        "applications": "Potential applications include solving complex optimization problems, simulating quantum systems, and enhancing machine learning algorithms...",
        "challengesAndFuture": "Challenges involve error correction, scalability, and developing practical quantum algorithms for various tasks..."
      }
    },
    {
      "key": "9",
      "name": "Natural Language Processing in Action",
      "duration": "2.5 hours",
      "image": "",
      "detail": {
        "description": "This course focuses on practical applications of natural language processing, including language understanding, sentiment analysis, and text generation...",
        "applications": "Applications include chatbots, language translation, and information extraction from text...",
        "challengesAndFuture": "Challenges involve handling ambiguity in language, improving accuracy, and adapting to different languages and contexts..."
      }
    },
    {
      "key": "10",
      "name": "Blockchain Technology Explained",
      "duration": "3 hours",
      "image": "",
      "detail": {
        "definition": "Blockchain is a decentralized and distributed ledger technology that securely records transactions across a network of computers...",
        "topicsCovered": ["blocks", "cryptographic hashing", "smart contracts"],
        "applications": "Applications include secure financial transactions, supply chain transparency, and decentralized applications...",
        "challengesAndFuture": "Challenges involve scalability, regulatory frameworks, and addressing environmental concerns related to blockchain mining..."
      }
    }
  ];
  List<Map<String, dynamic>> allCourses = [];
  List<Map<String, dynamic>> filteredCourses = [];
  bool isLoading = true;
  String loginMethod = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _pushAllCoursesToFirebase();
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

  void _pushAllCoursesToFirebase() async {
  try {
    for (int i = 0; i < coursesData.length; i++) {
      await FirebaseFirestore.instance.collection('courses').add({
        'key': coursesData[i]['key'],
        'name': coursesData[i]['name'],
        'duration': coursesData[i]['duration'],
        'image': coursesData[i]['image'],
        'detail': coursesData[i]['detail'],
      });
    }
    print('All courses pushed to Firebase successfully!');
  } catch (err) {
    _showAlert('Error pushing courses to Firebase: $err');
  }
}


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
        'detail': doc['detail'] as Map<String, dynamic>,
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
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Get ready to level up your knowledge',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
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
                                courseDuration: filteredCourses[index]
                                    ['duration']!,
                                courseImage: filteredCourses[index]['image']!,
                                courseKey: filteredCourses[index]['key']!,
                                courseDetail: filteredCourses[index]['detail']!,
                              ),
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
                              courseDetail: allCourses[i]['detail']!,
                            )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(Icons.logout))
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
