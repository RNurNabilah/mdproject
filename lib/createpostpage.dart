import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdproject/blocandcubit/websocketcubit.dart';
//import 'package:mdproject/postspage.dart';
import 'package:mdproject/websocketstate.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _urlController = TextEditingController();
  bool _checkInput = false;
  void initState() {
    _titleController.addListener((checkInput));
    _descController.addListener((checkInput));
    _urlController.addListener((checkInput));
    // super.initState();
  }

  void checkInput() {
    setState(() {
      if (_titleController.text.isNotEmpty &&
          _descController.text.isNotEmpty &&
          _urlController.text.isNotEmpty) {
        print('Its not empty');
        _checkInput = true;
      } else {
        _checkInput = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Project'),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<GetApiData, ApiRequest>(
        listener: (context, state) {
          if (state is AddPost) {}
        },
        builder: (context, state) {
          return Padding(
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
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
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
                  child: TextField(
                    controller: _descController,
                    decoration: const InputDecoration(
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
                  child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
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
                        onPressed: !_checkInput ? null : () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class CreatePost extends StatelessWidget {
//   const CreatePost({Key? key}) : super(key: key);

//   final _createController = TextEditingController();
//   bool _checkInput = false;

//   void initState() {
//     _createController.addListener((checkInput));
//     // super.initState();
//   }

//   void checkInput() {
//     setState(() {
//       if (_createController.text.isNotEmpty) {
//         print('Its not empty');
//         _checkInput = true;
//       } else {
//         _checkInput = false;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Final Project'),
//           backgroundColor: Colors.white,
//         ),
//         body: BlocConsumer<GetApiData, ApiRequest>(
//           listener: (context, state) {
//             if (state is AddPost) {}
//             // TODO: implement listener
//           },
//           builder: (context, state) {
//             return Padding(
//               padding: const EdgeInsets.all(5),
//               child: ListView(
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.all(5),
//                     child: const Text(
//                       'Title',
//                       style: TextStyle(color: Colors.black, fontSize: 20),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const TextField(
//                       controller: _createController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.all(5),
//                     child: const Text(
//                       'Description',
//                       style: TextStyle(color: Colors.black, fontSize: 20),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.all(5),
//                     child: const Text(
//                       'Image URL',
//                       style: TextStyle(color: Colors.black, fontSize: 20),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: <Widget>[
//                       Expanded(
//                         child: MaterialButton(
//                           shape: const StadiumBorder(
//                               side:
//                                   BorderSide(color: Colors.black12, width: 2)),
//                           textColor: Colors.black,
//                           color: Colors.cyanAccent,
//                           child: const Text('Create Post',
//                               style: TextStyle(fontSize: 20)),
//                           onPressed: !_checkInput ? null : () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }

// void setState(Null Function() param0) {}
