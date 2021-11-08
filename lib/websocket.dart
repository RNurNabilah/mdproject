import 'dart:convert';
//import 'package:mdproject/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:mdproject/postspage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket extends StatefulWidget {
  const WebSocket({Key? key}) : super(key: key);

  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  final finalProjectApi = WebSocketChannel.connect(
    Uri.parse('ws://besquare-demo.herokuapp.com'),
  );

  void apiStream() {
    finalProjectApi.stream.listen((message) {
      final decodedMessage = jsonDecode(message);

      print(decodedMessage);
    });
  }

  // //view all post
  // void _getPostResponse() {
  //   finalProjectApi.sink.add('{"type": "get_posts"}');
  // }

  // //create post
  // void _getToPost(String title, String description, String image) {
  //   finalProjectApi.sink.add(
  //       '{"type": "create_post", "data": {"title": "$title", "description": "$description", "image": "$image"}}');
  // }

  // //delete call
  // void _getTodeletePost(String postId) {
  //   finalProjectApi.sink
  //       .add('{"type": "delete_post", "data": {"postId": "$postId"}}');
  // }

  // void _toPostPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PostPage(channel:finalProjectApi))
  //   );
  // }

  // void _mainPage() {
  //   if (_usernameInput.text.isNotEmpty) {
  //     finalProjectApi.sink.add(_getSignInResponse);
  //     print('${_usernameInput.text} sign in success');
  //     _usernameInput.clear();
  //     _toPostPage();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
