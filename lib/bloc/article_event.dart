import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ArticleEvent extends Equatable {}

class FetchData extends ArticleEvent {
  @override
  List<Object> get props => [];
}

class CategoryData extends ArticleEvent {
  final category;

  CategoryData({@required this.category});

  @override
  List<Object> get props => [category];
}
