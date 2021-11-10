import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mdproject/blocandcubit/websocketcubit.dart';
import 'package:mdproject/postdetailspage.dart';
import 'package:mdproject/postsdata.dart';
import 'package:mdproject/postspage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdproject/websocketstate.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetApiData(),
      child: MaterialApp(
        title: 'Final Project',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const UserNameWidget(
          title: '',
        ),
      ),
    );
  }
}

class UserNameWidget extends StatefulWidget {
  const UserNameWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _UserNameWidget createState() => _UserNameWidget();
}

class _UserNameWidget extends State<UserNameWidget> {
  final finalProjectApi =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  final _userNameController = TextEditingController();
  bool _checkInput = false;
  late List<PostsData> storePostData = [];
  var userInputCubit;

  void initState() {
    apiStream();
    print(storePostData);

    _userNameController.addListener((checkInput));
    super.initState();
  }

  void checkInput() {
    setState(() {
      if (_userNameController.text.isNotEmpty) {
        print('Its not empty');
        _checkInput = true;
      } else {
        _checkInput = false;
      }
    });
  }

  @override
  void dispose() {
    finalProjectApi.sink.close();
    super.dispose();
  }

  void apiStream() {
    finalProjectApi.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      // final getData = decodedMessage["type"]["data"]["_posts"]["_id"];
      // print(getData);

      print(decodedMessage);
      if (decodedMessage["type"] == "all_posts" &&
          decodedMessage["data"]["posts"] != null) {
        decodedMessage["data"]["posts"].forEach((data) {
          setState(() {
            storePostData.add(PostsData(
              data["_id"],
              data["title"],
              data["description"],
              data["image"],
              data["date"],
              data["author"],
            ));
          });
          print('HERE');
          print(storePostData);
        });
        // BlocProvider.of<GetApiData>(context).passData(storePostData);
        userInputCubit.passData(storePostData);
      }
    });
  }

  void signInBlocFunction() {
    if (_checkInput) {
      userInputCubit.checkSignIn(_userNameController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostPageList(
            finalProjectApi: finalProjectApi, //,
            //storePostData: storePostData
          ),
        ),
      );
    } else {
      print('Arrived');
      userInputCubit.checkisNotValid();
    }
  }

  @override
  Widget build(BuildContext context) {
    userInputCubit = BlocProvider.of<GetApiData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Project'),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<GetApiData, ApiRequest>(
          bloc: context.read<GetApiData>(),
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/mewlions.jpeg',
                  width: 300,
                  height: 300,
                ),
                Center(
                  //margin: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // BlocBuilder<UsernameCubit, String>(
                      //   builder: (context, state) {
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _userNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: " UserName ",
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        //width: 50,
                        margin: const EdgeInsets.all(30),
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: MaterialButton(
                          shape: const StadiumBorder(
                              side:
                                  BorderSide(color: Colors.black12, width: 2)),
                          textColor: Colors.black,
                          color: Colors.cyanAccent,
                          child: const Text('Enter to the App',
                              style: TextStyle(fontSize: 20)),
                          onPressed: !_checkInput
                              ? null
                              : () {
                                  signInBlocFunction();
                                },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              shape: const StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.black12, width: 2)),
                              textColor: Colors.black,
                              color: Colors.cyanAccent,
                              child: const Text('Test: Posts Details',
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPageList(
                                          finalProjectApi: finalProjectApi)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is SignInRequest && _checkInput == true) {
              print("Listener is activated");
              finalProjectApi.sink.add('${state.userNameInput}');
            }
          }),
    );
  }
}
