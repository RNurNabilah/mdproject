import 'package:mdproject/websocketstate.dart';
//import 'package:mdproject/postsdata.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GetApiData extends Cubit<ApiRequest> {
  GetApiData() : super(ValueNotEntered());
  final finalProjectApi =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  // void passData(List<PostsData> data) {
  //   emit(StoreListData(data));
  // }
  void checkIsValid() {
    emit(ValueEntered());
  }

  void checkIsNotValid() {
    emit(ValueNotEntered());
  }

  void checkSignIn(String userNameInput) {
    // callAPI.sink.add(SignInRequest(
    // '{"type": "sign_in", "data": {"name": "$userNameInput"}}'));
    emit(SignInRequest(
        '{"type": "sign_in", "data": {"name": "$userNameInput"}}'));
  }

  void checkAddPostDetails(String title, String description, String image) {
    // emit
  }

  void passData(List postData) {
    emit(StoreListData(postData));
  }

  //view all post
  // void _getPostResponse() {
  //   finalProjectApi.sink.add('{"type": "get_posts"}');
  // }

  //sign-in
  // void _getSignInResponse(String userInput) {
  //   finalProjectApi.sink
  //       .add('{"type": "sign_in", "data": {"name": "$userInput"}}');
  // }

  //create post
  // void _getToPost(String title, String description, String image) {
  //   finalProjectApi.sink.add(
  //       '{"type": "create_post", "data": {"title": "$title", "description": "$description", "image": "$image"}}');
  // }

  //delete call
  // void _getTodeletePost(String postId) {
  //   finalProjectApi.sink
  //       .add('{"type": "delete_post", "data": {"postId": "$postId"}}');
  // }
}
