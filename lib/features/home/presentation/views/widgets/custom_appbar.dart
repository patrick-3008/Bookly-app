import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/assets.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _searchTextController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppBar(
        backgroundColor: kPrimaryColor,
        leadingWidth: 20,
        leading:
            _isSearching ? const BackButton(color: Colors.white) : Container(),
        title: _isSearching ? _buildSearchFiled() : _buildAppBarTitle(),
        actions: [_buildAppBarActions()],
      ),
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
      onChanged: (newVal) {},
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
