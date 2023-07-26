import 'package:bookly_app/features/home/presentation/views/widgets/search_list_view.dart';
import 'package:flutter/material.dart';

class Searching extends StatelessWidget {
  const Searching({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SearchedListView(),
          ),
        ),
      ],
    );
  }
}
