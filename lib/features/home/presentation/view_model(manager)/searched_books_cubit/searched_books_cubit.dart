// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/book_model/book_model.dart';
import '../../../data/repos/home_repo.dart';

part 'searched_books_state.dart';

class SearchedBooksCubit extends Cubit<SearchedBooksState> {
  SearchedBooksCubit(this.homeRepo) : super(SearchedBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchSearchedBooks({required String searchText}) async {
    emit(SearchedBooksLoading());
    var result = await homeRepo.fetchSearchedBooks(search: searchText);
    result.fold((failure) {
      emit(SearchedBooksFailure(failure.errMessage));
    }, (books) {
      emit(SearchedBooksSuccess(books));
    });
  }
}
