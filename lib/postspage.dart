import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdproject/aboutpage.dart';
import 'package:mdproject/blocandcubit/websocketcubit.dart';
import 'package:mdproject/createpostpage.dart';

import 'package:mdproject/websocketstate.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PostPageList extends StatefulWidget {
  const PostPageList({required this.finalProjectApi, Key? key})
      : super(key: key);

  final WebSocketChannel finalProjectApi;
  //final List<PostsData> storePostData;

  @override
  _PostPageListState createState() => _PostPageListState();
}

class _PostPageListState extends State<PostPageList> {
  @override
  initState() {
    getPostDetails();
    super.initState();
  }

  void getPostDetails() {
    widget.finalProjectApi.sink.add('{"type": "get_posts"}');
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
                            onPressed: () {},
                            icon: const Icon(Icons.sort),
                            alignment: Alignment.topRight,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
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
                                    builder: (context) => const CreatePost()),
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
                                    return Card(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 50,
                                            bottom: 50,
                                            right: 25,
                                            left: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 64,
                                              child: Image.network(state
                                                  .postDataList[index].image),
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
                                                        'Date Created: ' +
                                                            state
                                                                .postDataList[
                                                                    index]
                                                                .date,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  // IconButton(
                                                  //   onPressed: () {},
                                                  //   icon: const Icon(Icons.favorite),
                                                  //   alignment: Alignment.topRight,
                                                  // ),
                                                  FavoriteButton(
                                                    //iconSize: 10,
                                                    isFavorite: false,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print('Is Favorite: ');
                                                    },
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      size: 30,
                                                    ),
                                                    alignment:
                                                        Alignment.topRight,
                                                  ),
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
}

// class PostPage extends StatelessWidget {
//   const PostPage({Key? key, channel}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: const Text('Final Project'),
//     //     backgroundColor: Colors.white,
//     //   ),
//     //   body: Center(
//     //     child: Column(
//     //       children: [
//     //         Row(
//     //           children: <Widget>[
//     //             IconButton(
//     //               icon: const Icon(
//     //                 Icons.settings,
//     //                 color: Colors.grey,
//     //               ),
//     //               onPressed: () {
//     //                 Navigator.push(
//     //                   context,
//     //                   MaterialPageRoute(
//     //                     builder: (context) => const AboutPage(),
//     //                   ),
//     //                 );
//     //               },
//     //             ),
//     //             Expanded(
//     //               child: Row(
//     //                 mainAxisAlignment: MainAxisAlignment.end,
//     //                 children: <Widget>[
//     //                   IconButton(
//     //                     onPressed: () {},
//     //                     icon: const Icon(Icons.sort),
//     //                     alignment: Alignment.topRight,
//     //                   ),
//     //                   IconButton(
//     //                     onPressed: () {},
//     //                     icon: const Icon(
//     //                       Icons.favorite,
//     //                       color: Colors.red,
//     //                     ),
//     //                     alignment: Alignment.topRight,
//     //                   ),
//     //                   IconButton(
//     //                     onPressed: () {
//     //                       Navigator.push(
//     //                         context,
//     //                         MaterialPageRoute(
//     //                             builder: (context) => const CreatePost()),
//     //                       );
//     //                     },
//     //                     icon: const Icon(
//     //                       Icons.add,
//     //                       color: Colors.blue,
//     //                     ),
//     //                     alignment: Alignment.topRight,
//     //                   ),
//     //                 ],
//     //               ),
//     //             )
//     //           ],
//     //         ),
//     //         Card(
//     //           child: Container(
//     //             padding: const EdgeInsets.all(8),
//     //             child: Row(
//     //               mainAxisAlignment: MainAxisAlignment.start,
//     //               children: [
//     //                 const CircleAvatar(
//     //                   radius: 30,
//     //                   child: CircleAvatar(
//     //                       // backgroundImage: NetworkImage(
//     //                       //     'https://www.amkmc.org.sg/wp/wp-content/uploads/ddcab749bde82b971c58cc6e80c462e4.jpg'),
//     //                       // fit: BoxFit.fill,
//     //                       ),
//     //                 ),
//     //                 const SizedBox(width: 20),
//     //                 Column(
//     //                   children: const [
//     //                     Text('Title: \n Description: \n Date Created:'),
//     //                   ],
//     //                 ),
//     //                 Expanded(
//     //                   child: Row(
//     //                     mainAxisAlignment: MainAxisAlignment.end,
//     //                     children: <Widget>[
//     //                       // IconButton(
//     //                       //   onPressed: () {},
//     //                       //   icon: const Icon(Icons.favorite),
//     //                       //   alignment: Alignment.topRight,
//     //                       // ),
//     //                       FavoriteButton(
//     //                         //iconSize: 10,
//     //                         isFavorite: false,
//     //                         valueChanged: (_isFavorite) {
//     //                           print('Is Favorite: $_isFavorite');
//     //                         },
//     //                       ),
//     //                       IconButton(
//     //                         onPressed: () {},
//     //                         icon: const Icon(
//     //                           Icons.delete,
//     //                           size: 30,
//     //                         ),
//     //                         alignment: Alignment.topRight,
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }
