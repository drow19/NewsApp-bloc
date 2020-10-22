import 'package:equatable/equatable.dart';
import 'package:flutternewsbloc/model/article_model.dart';
import 'package:meta/meta.dart';

abstract class ArticleState extends Equatable {}

class LoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

class IsLoadedState extends ArticleState {
  final List<ArticleModel> list;

  IsLoadedState({@required this.list});

  @override
  List<Object> get props => [list];
}

class IsErrorState extends ArticleState {
  final message;

  IsErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
