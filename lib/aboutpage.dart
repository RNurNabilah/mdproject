import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Project'),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        //padding: const EdgeInsets.all(32),
        child: Text(
          '~ABOUT THE APP~ \n \n This app is my final project for the mobile development module',
          //softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
