import 'package:flutter/material.dart';
import 'package:lab_final/weather/weather.dart';
import 'scientific_calculator/calculator_screen.dart';
import 'quiz/quiz_screen.dart';
import 'profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const UserDetailsScreen(),
        '/scientific_calculator': (context) => const CalculatorScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/weather': (context) => WeatherScreen(),
      },
    );
  }
}

var userInput = '';
var answer = '';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          'images/bg.jpg', // Replace with your background image asset
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .08,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'User Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'images/user.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),

              //! Scientific Calculator Button
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/scientific_calculator');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .08,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'Scientific Calculator',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'images/s_cal.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),

              //! Quiz Button
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/quiz');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .08,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'Quiz',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'images/quiz.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),

              //!Weather Button
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/weather');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .08,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'Weather',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'images/splash_screen.png', // Replace with your image asset
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
