import 'package:assignment_zrex_instagram/utils/search_screen_shimmer.dart';
import 'package:assignment_zrex_instagram/view/widgets/search_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<String>> _searchData;

  @override
  void initState() {
    super.initState();
    _searchData = _fetchSearchData();
  }

  Future<List<String>> _fetchSearchData() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 3));
    return List.generate(21, (i) => 'https://picsum.photos/id/${i + 60}/500/500');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 38,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 9),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.scanner_copy, color: Colors.black, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _searchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SearchScreenShimmer();
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error loading explore feed"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _searchData = _fetchSearchData();
              });
            },
            child: SearchGridWidget(imageUrls: snapshot.data!),
          );
        },
      ),
    );
  }
}