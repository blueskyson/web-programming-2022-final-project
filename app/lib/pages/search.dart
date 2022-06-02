import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      // Make empty spaces clickable
      behavior: HitTestBehavior.translucent,

      // Lose the current Focus after clicking
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },

      child: Scaffold(
        appBar: AppBar(
          // The search area
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              prefixIcon: null,
              suffixIcon: IconButton(
                iconSize: 20,
                splashRadius: 20,
                icon: const Icon(
                  Icons.clear,
                  size: 20,
                ),
                onPressed: _controller.clear,
              ),
              hintText: '',
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              focusColor: const Color.fromARGB(255, 234, 234, 234),
              fillColor: Colors.blue,
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
