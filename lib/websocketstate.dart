abstract class ApiRequest {}

class ValueNotEntered extends ApiRequest {}

class ValueEntered extends ApiRequest {}

class SignInRequest extends ApiRequest {
  late String userNameInput;

  SignInRequest(String input) {
    userNameInput = input;
  }
}

class AddPost extends ApiRequest {
  late String title;
  late String description;
  late String image;

  addPost(String title, String description, String image) {
    this.title = title;
    this.description = description;
    this.image = image;
  }
}

class StoreListData extends ApiRequest {
  late List postDataList;

  StoreListData(List data) {
    postDataList = data;
  }
}
