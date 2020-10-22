
import 'package:flutternewsbloc/bloc/article_event.dart';
import 'package:flutternewsbloc/bloc/article_state.dart';
import 'package:flutternewsbloc/model/article_model.dart';
import 'package:flutternewsbloc/repository/article_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({@required this.repository});

  @override
  ArticleState get initialState => LoadingState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if(event is FetchData){
      try {
        Future.delayed(const Duration(seconds: 3));
        List<ArticleModel> list = await repository.getData("");
        yield IsLoadedState(list: list);
      } catch (e) {
        yield IsErrorState(message: e.toString());
      }
    }else if(event is CategoryData){
      yield LoadingState();
      try {
        Future.delayed(const Duration(seconds: 3));
        List<ArticleModel> list = await repository.getData(event.category);
        yield IsLoadedState(list: list);
      } catch (e) {
        yield IsErrorState(message: e.toString());
      }
    }

  }

}
