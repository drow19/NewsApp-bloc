import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutternewsbloc/bloc/article_bloc.dart';
import 'package:flutternewsbloc/bloc/article_event.dart';
import 'package:flutternewsbloc/bloc/article_state.dart';
import 'package:flutternewsbloc/model/article_model.dart';
import 'package:flutternewsbloc/view/detail_screen.dart';
import 'package:flutternewsbloc/widget/list_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArticleBloc _bloc;

  List<CategoryModel> _category = new List<CategoryModel>();

  @override
  void initState() {
    _bloc = BlocProvider.of<ArticleBloc>(context);
    _bloc.add(FetchData());
    _category = getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('NewsApp'),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            child: ListView.builder(
                itemCount: _category.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    images: _category[index].image,
                    categoryName: _category[index].categoryName,
                    bloc: _bloc,
                  );
                }),
          ),
          Expanded(
            child: BlocBuilder<ArticleBloc, ArticleState>(
                // ignore: missing_return
                builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is IsLoadedState) {
                return _listNews(state.list);
              } else if (state is IsErrorState) {
                print("print error : ${state.message}");
                return Center(
                  child: Text("Error..."),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _listNews(List<ArticleModel> list) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (list[index].urlToImage == "" &&
              list[index].author == "" &&
              list[index].description == "") {
            return Container();
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) =>
                            DetailScreen(url: list[index].url)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: CachedNetworkImage(
                            imageUrl: list[index].urlToImage)),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${list[index].title}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${list[index].description}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${list[index].publishedAt.toString().substring(0, 19)}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.white12,
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}

class CategoryTile extends StatelessWidget {
  final categoryName;
  final images;
  final ArticleBloc bloc;

  CategoryTile({this.categoryName, this.images, this.bloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.add(CategoryData(category: categoryName.toString().toLowerCase()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: images,
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.black26,
              width: 120,
              height: 80,
              child: Text(
                '${categoryName}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
