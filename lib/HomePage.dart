import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geek/CourseCard.dart';
import 'package:geek/LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> allCourses = [
    {
      'key': '1',
      'name': 'Course 1',
      'duration': '2 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': '''
        In the heart of bustling cities and tranquil villages alike, technology weaves its intricate web, connecting people across vast distances. The digital age has ushered in unprecedented advancements, revolutionizing the way we live, work, and communicate. From smartphones that fit in the palm of our hands to artificial intelligence shaping industries, the landscape of our world is continually evolving. Amidst the relentless march of progress, the importance of preserving the natural environment becomes increasingly apparent. Conservation efforts and sustainable practices are integral to ensuring a harmonious coexistence between humanity and the planet. As climate change looms large, individuals and nations grapple with the imperative to mitigate its effects and protect the delicate balance of ecosystems.

        In the realm of science and discovery, the cosmos continues to captivate the human imagination. Astronomers peer into the vastness of space, unraveling the mysteries of distant galaxies and celestial bodies. Meanwhile, breakthroughs in medical research offer hope for the treatment of diseases that have plagued humanity for centuries.

        Literature, a timeless companion, provides solace and inspiration. From the poetic verses of ancient civilizations to the contemporary novels that grace bestseller lists, words have the power to transcend time and transport readers to different worlds. The written word, a testament to human creativity, bridges cultures and fosters understanding among diverse communities.

        Education stands as the cornerstone of progress, empowering individuals to navigate the complexities of the modern world. In classrooms and lecture halls, knowledge is imparted, shaping the minds of the next generation. The pursuit of learning extends beyond formal institutions, with online platforms democratizing access to information and skills.

        As we navigate the intricacies of life, the importance of human connection remains paramount. Relationships, both familial and platonic, enrich our experiences and contribute to our sense of belonging. In an era where virtual interactions abound, the essence of genuine connections endures, reminding us of the enduring value of compassion and empathy.

        In the grand tapestry of human existence, each thread represents a unique story. From the smallest moments of joy to the weightiest challenges, the human experience is a mosaic of emotions and endeavors. It is through shared stories and collective aspirations that we weave a narrative that transcends borders and resonates across generations.
      '''
    },
    {
      'key' : '2',
      'name': 'Course 2',
      'duration': '3 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
    {
      'key' : '3',
      'name': 'Course 3',
      'duration': '1.5 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
    {
      'key' : '4',
      'name': 'Course 4',
      'duration': '4 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
    {
      'key' : '5',
      'name': 'Information',
      'duration': '2.5 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
    {
      'key' : '6',
      'name': 'Couhse 1',
      'duration': '2 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
    {
      'key' : '7',
      'name': 'Couhse 2',
      'duration': '3 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
    {
      'key' : '8',
      'name': 'Couhsr 3',
      'duration': '1.5 hours',
      'image': 'lib/Assets/image-removebg-preview.png',
      'detail': 'details'
    },
  ];

  List<Map<String, String>> filteredCourses = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for changes in the authentication state.
    FirebaseAuth.instance.authStateChanges().listen((user) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          print(snapshot.hasData);
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(snapshot.hasData);
          if(snapshot.hasData){
            return ListView(
              children: <Widget>[
                SizedBox(height: 0),
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
                          courseKey: filteredCourses[index]['key']!,
                          courseDetail: filteredCourses[index]['detail']!,
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
                            courseImage: allCourses[i]['image']!,
                            courseKey: allCourses[i]['key']!,
                            courseDetail: allCourses[i]['detail']!,
                          )
                    ],
                  ),
                ),
              ],
            );
            }
            else{
              Future.microtask(() => _navigateToLogin(context));
              return Container();
            }
        }
        )
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

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
