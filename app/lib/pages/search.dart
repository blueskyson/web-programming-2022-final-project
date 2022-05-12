import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The search area
          backgroundColor: const Color.fromARGB(255, 234, 234, 234),
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _controller.clear),
                hintText: '搜尋',
                border: InputBorder.none,
                hintStyle: const TextStyle(height: 1.2),
              ),
            ),
          ),
        ),
        body: Row(
          children: const [
            Text(
              '近期搜尋紀錄',
              style: TextStyle(color: Colors.grey, fontSize: 15, height: 2),
              textAlign: TextAlign.center,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ));
  }
}
