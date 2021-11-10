//import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
//import 'package:getwidget/getwidget.dart';
import 'package:mdproject/aboutpage.dart';
import 'package:mdproject/blocandcubit/websocketcubit.dart';
import 'package:mdproject/createpostpage.dart';
import 'package:mdproject/websocketstate.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:mdproject/favoritepage.dart';

class PostPageList extends StatefulWidget {
  PostPageList({required this.finalProjectApi, Key? key}) : super(key: key);

  WebSocketChannel finalProjectApi;
  //final List<PostsData> storePostData;

  @override
  _PostPageListState createState() => _PostPageListState();
}

class _PostPageListState extends State<PostPageList> {
  Color _iconColor = Colors.black;
  Future<void> FilterThePageWithDate() {
    getPostDetails();
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  initState() {
    getPostDetails();
    super.initState();
  }

  void getPostDetails() {
    widget.finalProjectApi.sink
        .add('{"type": "get_posts", "data": {"sortBy": "date"}}');
  }

  void favoritePost() {
    widget.finalProjectApi.sink.add('{"type":"get_posts",}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Project'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(color: Colors.lightBlue),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              FilterThePageWithDate();
                            },
                            icon: const Icon(Icons.sort),
                            alignment: Alignment.topRight,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () => pushToFavoriteWordsRoute(context),
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            alignment: Alignment.topRight,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreatePost(
                                        api: widget.finalProjectApi)),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            alignment: Alignment.topRight,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              BlocConsumer<GetApiData, ApiRequest>(
                bloc: context.read<GetApiData>(),
                builder: (context, state) {
                  return state is StoreListData
                      ? state.postDataList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: state.postDataList.length,
                                  itemBuilder: (context, index) {
                                    DateTime template = DateTime.parse(
                                        state.postDataList[index].date);
                                    return Card(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 30,
                                            bottom: 30,
                                            right: 25,
                                            left: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                ),
                                              ),
                                              child: Image.network(
                                                state.postDataList[index].image,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return const Image(
                                                      image: AssetImage(
                                                          'assets/empty.jpg'));
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Container(
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text('Title: ' +
                                                        state
                                                            .postDataList[index]
                                                            .title),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        'Description: ' +
                                                            state
                                                                .postDataList[
                                                                    index]
                                                                .description,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        'Date and Time Created: ' +
                                                            DateFormat(
                                                                    'yyyy-MM-dd hh:mm:ss')
                                                                .format(
                                                                    template),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  IconButton(
                                                    color: _iconColor,
                                                    onPressed: () =>
                                                        setState(() {
                                                      if (_iconColor ==
                                                          Colors.black) {
                                                        _iconColor = Colors.red;
                                                      } else {
                                                        _iconColor =
                                                            Colors.black;
                                                      }
                                                    }),
                                                    icon: const Icon(
                                                        Icons.favorite),
                                                    alignment:
                                                        Alignment.topRight,
                                                  ),
                                                  // FavoriteButton(
                                                  //   //iconSize: 10,
                                                  //   isFavorite: false,
                                                  //   valueChanged:
                                                  //       (_isFavorite) {
                                                  //     print(
                                                  //         'Is Favorite: $_isFavorite');
                                                  //   },
                                                  // ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(IconData(
                                                            58634,
                                                            fontFamily:
                                                                'MaterialIcons')
                                                        //size: 30,
                                                        ),
                                                    alignment:
                                                        Alignment.topRight,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      //size: 30,
                                                    ),
                                                    alignment:
                                                        Alignment.topRight,
                                                  ),
                                                  // GFButton(
                                                  //   onPressed: () {},
                                                  //   text: 'Read More',
                                                  //   shape: GFButtonShape.pills,
                                                  //   position: GFPosition.end,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container()
                      : const SizedBox.shrink();
                },
                listener: (context, state) {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pushToFavoriteWordsRoute(BuildContext context) {
    favoritePost();
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const FavoriteWordsRoute(
            //finalProjectApi: savedWords,
            ),
      ),
    );
  }
}
