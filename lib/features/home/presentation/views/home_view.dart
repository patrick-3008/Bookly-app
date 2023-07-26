import 'package:bookly_app/features/home/presentation/view_model(manager)/searched_books_cubit/searched_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/not_searching.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/searching.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants.dart';
import '../../../../core/utils/assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchTextController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leadingWidth: 20,
        leading:Container(),
        title: _isSearching ? _buildSearchFiled() : _buildAppBarTitle(),
        actions: [_buildAppBarActions()],
      ),
      body: _isSearching ? const Searching() : const NotSearching(),
    );
  }

  _buildAppBarTitle() {
    return Image.asset(AssetsData.logo, height: 18);
  }

  _buildSearchFiled() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        hintText: 'Search a Book',
        border: InputBorder.none,
      ),
      onChanged: (newVal) {
        BlocProvider.of<SearchedBooksCubit>(context)
            .fetchSearchedBooks(searchText: newVal);
      },
    );
  }

  _buildAppBarActions() {
    return _isSearching
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _clearSearchField();
              Navigator.pop(context);
            },
          )
        : IconButton(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 22),
            onPressed: _startSearch,
          );
  }

  _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() => _isSearching = true);
  }

  _stopSearch() {
    _clearSearchField();
    setState(() => _isSearching = false);
  }

  _clearSearchField() {
    setState(() => _searchTextController.clear());
  }
}
