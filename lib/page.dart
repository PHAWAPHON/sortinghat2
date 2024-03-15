import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();
  double _volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/start.png',
            height: 35,
          ),
          backgroundColor: Color.fromARGB(255, 101, 6, 4),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _textController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter number of students",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _textController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(20),
                    onPressed: () {
                      String inputText = _textController.text;
                      int? numberOfStudents = int.tryParse(inputText);
                      if (numberOfStudents == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 15, 143, 143),
                              title: Text(
                                'Invalid Input',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                'Please enter a valid number of students.',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InsertPage(numberOfStudents: numberOfStudents),
                          ),
                        );
                      }
                    },
                    color: Colors.blue,
                    child: Text(
                      'Enter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Slider(
                value: _volume,
                min: 0.0,
                max: 0.5,
                onChanged: (value) {
                  setState(() {
                    _volume = value;
                    audioPlayer.setVolume(_volume);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                  await audioPlayer.play('assets/sounds/4KINGS.mp3');
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  audioPlayer.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  audioPlayer.stop();
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  audioPlayer.resume();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InsertPage extends StatefulWidget {
  final int numberOfStudents;

  const InsertPage({Key? key, required this.numberOfStudents})
      : super(key: key);

  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final _textController1 = TextEditingController();

  List<String> schools = ['ประชาชื่น', 'อินทรา', 'กนกอาชีวะ', 'บูรณพล'];
  List<String> Prachachuen = [];
  List<String> Indra = [];
  List<String> Kanok = [];
  List<String> Booranapol = [];
  List<int> schoolPop = [0, 0, 0, 0];
  List<int> schoolLeftOver = [0, 1, 2, 3];
  int schoolCap = 0;
  int sorted = 0;
  int select = 0;

  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  void setStudentNumber(int students) {
    if (widget.numberOfStudents <= 0) {
      return;
    }
    schoolCap = (widget.numberOfStudents / 4).ceil();
    Prachachuen = List.filled(schoolCap, '');
    Indra = List.filled(schoolCap, '');
    Kanok = List.filled(schoolCap, '');
    Booranapol = List.filled(schoolCap, '');
  }

  void sortToSchool(String name) {
    if (name.isEmpty || sorted >= widget.numberOfStudents) {
      return;
    }

    List<int> shuffledIndices = List.generate(schools.length, (index) => index);
    shuffledIndices.shuffle();

    int minIndex = shuffledIndices[0];
    for (int i = 1; i < shuffledIndices.length; i++) {
      if (schoolPop[shuffledIndices[i]] < schoolPop[minIndex]) {
        minIndex = shuffledIndices[i];
      }
    }

    schoolPop[minIndex]++;
    select = minIndex;
    switch (minIndex) {
      case 0:
        Prachachuen.add(name);
        break;
      case 1:
        Indra.add(name);
        break;
      case 2:
        Kanok.add(name);
        break;
      case 3:
        Booranapol.add(name);
        break;
      default:
        break;
    }

    sorted++;
    setState(() {
      startAnimation = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return buildItem(name: name, number: select);
      },
    );
  }

  void resetSchool() {
    setState(() {
      schoolPop = [0, 0, 0, 0];
      Prachachuen.clear();
      Indra.clear();
      Kanok.clear();
      Booranapol.clear();
      sorted = 0;
      schoolLeftOver = [0, 1, 2, 3];
      startAnimation = false;
    });
  }

  Widget buildItem({
    required String name,
    required int number,
  }) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "🥳 ยินดีด้วยคุณได้อยู่" + schools[number] + "🥳",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            getImageForNumber(number),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 101, 6, 4)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageForNumber(int number) {
    switch (number) {
      case 0:
        return Image.asset(
          'assets/prachachon.jpeg',
          width: 500,
          height: 500,
        );
      case 1:
        return Image.asset(
          'assets/indra.jpeg',
          width: 500,
          height: 500,
        );
      case 2:
        return Image.asset(
          'assets/kanok.jpg',
          width: 500,
          height: 500,
        );
      case 3:
        return Image.asset(
          'assets/boorana.jpg',
          width: 500,
          height: 500,
        );
      default:
        return Container();
    }
  }

  Widget item(int index, List<String> texts) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300 + (index * 100)),
      opacity: startAnimation ? 1.0 : 0.0,
      child: Container(
        height: 55,
        width: screenWidth,
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                " ${index + 1}. ${texts[index]}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context, int house, bool animate) {
    List<String> students;
    startAnimation = animate;
    switch (house) {
      case 0:
        students = Prachachuen;
        break;
      case 1:
        students = Indra;
        break;
      case 2:
        students = Kanok;
        break;
      default:
        students = Booranapol;
        break;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (animate) {
        setState(() {
          startAnimation = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 101, 6, 4),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 101, 6, 4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
          child: Column(
            children: [
              const SizedBox(height: 35),
              Text(
                'รายชื่อนักเรียน ${schools[house]}' +
                    "มีทั้งหมด " +
                    students.length.toString() +
                    " คน",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              students.isEmpty
                  ? const Center(
                      child: Text(
                        '❌ ยังไม่มีนักเรียน ❌',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : AnimatedOpacity(
                      opacity: startAnimation ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: students.length,
                          itemBuilder: (context, i) {
                            return item(i, students);
                          },
                        ),
                      ),
                    ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/start.png',
            height: 30,
          ),
          backgroundColor: Color.fromARGB(255, 101, 6, 4),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: sorted < widget.numberOfStudents
                  ? Text(
                      "😎 จำนวนนักเรียนทั้งหมด : $sorted / ${widget.numberOfStudents}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      '❌ จำนวนนักเรียนครบแล้วไม่สามารถใส่นักเรียนเพิ่มได้ ❌',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        sorted < widget.numberOfStudents
                            ? TextField(
                                controller: _textController1,
                                decoration: InputDecoration(
                                  hintText: "Enter student name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _textController1.clear();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                child: Text(
                                  "Can't add more students",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                        SizedBox(
                          height: 17,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                sortToSchool(_textController1.text);
                              },
                              color: Colors.blue,
                              child: Text(
                                'Enter',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              minWidth: 0,
                              height: 40,
                              onPressed: () {
                                resetSchool();
                              },
                              color: Colors.white,
                              child: Icon(
                                Icons.restart_alt,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        buildList(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _current = 0;
  dynamic _selectedIndex = {};
  void currentIndex(int index) {
    setState(() {
      _current = index;
    });
  }

  CarouselController _carouselController = CarouselController();

  List<dynamic> _products = [
    {
      'title': 'ประชาชื่น',
      'image': 'assets/prachachon.jpeg',
      'description': ''
    },
    {'title': 'อินทร', 'image': 'assets/indra.jpeg', 'description': ''},
    {'title': 'กนกอาชีวะ', 'image': 'assets/kanok.jpg', 'description': ''},
    {'title': 'บูรณพล', 'image': 'assets/boorana.jpg', 'description': ''}
  ];

  Widget buildList(BuildContext context) {
    return Expanded(
      child: Scaffold(
        floatingActionButton: _selectedIndex.length > 0
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    startAnimation = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => buildPage(context, _current, true),
                    ),
                  ).then((_) {
                    setState(() {
                      startAnimation = false;
                    });
                  });
                },
                child: const Icon(Icons.arrow_forward_ios),
              )
            : null,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            ' ',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 350.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.70,
              enlargeCenterPage: true,
              pageSnapping: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: _products.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndex == movie) {
                          _selectedIndex = {};
                        } else {
                          _selectedIndex = movie;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      transform: Matrix4.identity()
                        ..scale(startAnimation && _selectedIndex == movie
                            ? 1.1
                            : 1.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: _selectedIndex == movie
                            ? Border.all(
                                color: Color.fromARGB(255, 118, 22, 9),
                                width: 3)
                            : null,
                        boxShadow: _selectedIndex == movie
                            ? [
                                BoxShadow(
                                  color: Colors.blue.shade100,
                                  blurRadius: 30,
                                  offset: const Offset(0, 10),
                                )
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                )
                              ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                height: 320,
                                margin: const EdgeInsets.only(top: 10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(movie['image'],
                                    fit: BoxFit.contain,
                                    width: MediaQuery.of(context).size.width)),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              movie['title'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              movie['description'],
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
