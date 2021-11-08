import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mdproject/blocandcubit/websocketcubit.dart';
//import 'package:mdproject/createpostpage.dart';
import 'package:mdproject/postdetailspage.dart';
import 'package:mdproject/postsdata.dart';
import 'package:mdproject/postspage.dart';
//import 'package:mdproject/blocandcubit/username_bloc.dart';
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

  // @override
  // void dispose() {
  //   _userNameController.dispose();
  //   super.dispose();
  // }

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

  // @override
  // void dispose() {
  //   finalProjectApi.sink.close();
  //   super.dispose();
  // }

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
    // print(userInputBloc.passData(storePostData));

    // _besquare_API.sink.add('{"type": "get_posts"}');
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
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    //margin: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // BlocBuilder<UsernameCubit, String>(
                        //   builder: (context, state) {
                        TextField(
                          controller: _userNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: " UserName ",
                          ),
                          // onChanged: (String? _userNameController) {
                          //   context.read<UsernameCubit>().updateUsername;
                          // },
                          //   );
                          // },
                        ),
                        // BlocConsumer<UsernameCubit, String>(
                        //     listener: (context, state) {},
                        //     builder: (context, state) {
                        //       return Text(
                        //         state,
                        //         style: Theme.of(context).textTheme.headline4,
                        //       );
                        //     }),
                        Container(
                          height: 50,
                          //width: 50,
                          margin: const EdgeInsets.all(30),
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: MaterialButton(
                            shape: const StadiumBorder(
                                side: BorderSide(
                                    color: Colors.black12, width: 2)),
                            textColor: Colors.black,
                            color: Colors.cyanAccent,
                            child: const Text('Enter to the App',
                                style: TextStyle(fontSize: 20)),
                            onPressed: !_checkInput
                                ? null
                                : () {
                                    signInBlocFunction();
                                    // String textInput = (_userNameController.toString());
                                    // _getSignInResponse(textInput);
                                    // context.read<UsernameCubit>(_userNameController.text);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const PostPage()),
                                    // );
                                  },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // Expanded(
                            //   child: MaterialButton(
                            //     shape: const StadiumBorder(
                            //         side: BorderSide(
                            //             color: Colors.black12, width: 2)),
                            //     textColor: Colors.black,
                            //     color: Colors.cyanAccent,
                            //     child: const Text('Test: Create Post',
                            //         style: TextStyle(fontSize: 20)),
                            //     onPressed: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const CreatePost()),
                            //       );
                            //     },
                            //   ),
                            // ),
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
                                        builder: (context) =>
                                            const PostsDetailsPage()),
                                  );
                                },
                              ),
                            ),
                            // Expanded(
                            //   child: MaterialButton(
                            //     shape: const StadiumBorder(
                            //         side: BorderSide(
                            //             color: Colors.black12, width: 2)),
                            //     textColor: Colors.black,
                            //     color: Colors.cyanAccent,
                            //     child: const Text('Test: Posts',
                            //         style: TextStyle(fontSize: 20)),
                            //     onPressed: !_checkInput
                            //         ? null
                            //         : () {
                            //             signInBlocFunction();
                            //             Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       const PostPage()),
                            //             );
                            //           },
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is SignInRequest && _checkInput == true) {
              print("Listener is activated");
              finalProjectApi.sink.add('${state.userNameInput}');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PostPageList(
              //       finalProjectApi: finalProjectApi, //,
              //       //storePostData: storePostData
              //     ),
              //   ),
              // );
            }
          }),
    );
  }
}
