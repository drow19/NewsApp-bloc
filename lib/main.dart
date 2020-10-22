import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutternewsbloc/bloc/article_bloc.dart';
import 'package:flutternewsbloc/repository/article_repository.dart';
import 'package:flutternewsbloc/view/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
            create: (context) => ArticleBloc(repository: ArticleRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
