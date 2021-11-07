import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notepad/memo.dart';

class MemoPage extends HookWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text('MemoPad'),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _header(),
          _editor(),
        ],
      ),
    );
  }

  Widget _header() {
    return HookBuilder(builder: (BuildContext context) {
      return Align(
        alignment: Alignment.centerRight,
        child: Text(
          useProvider(
              memoStateNotifierProvider.select((state) => state.wordCount)),
          style: TextStyle(color: Theme.of(useContext()).disabledColor),
        ),
      );
    });
  }

  Widget _editor() {
    var notifier = useProvider(memoStateNotifierProvider.notifier);
    return Expanded(
      child: TextField(
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          expands: true,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
          ),
          onChanged: (memo) => notifier.update(memo: memo)),
    );
  }
}
