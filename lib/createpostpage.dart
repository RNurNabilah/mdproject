import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Final Project'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Title',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Description',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Image URL',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.black12, width: 2)),
                      textColor: Colors.black,
                      color: Colors.cyanAccent,
                      child: const Text('Create Post',
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.black12, width: 2)),
                      textColor: Colors.black,
                      color: Colors.cyanAccent,
                      child:
                          const Text('Cancel', style: TextStyle(fontSize: 20)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
