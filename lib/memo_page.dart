import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notepad/memo.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: _appBar(), body: _body(ref));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text('MemoPad'),
    );
  }

  Widget _body(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _header(),
          _editor(ref),
        ],
      ),
    );
  }

  Widget _header() {
    return HookConsumer(builder: (BuildContext context, ref, child) {
      return Align(
        alignment: Alignment.centerRight,
        child: Text(
          ref.watch(memoStateNotifierProvider
              .select<String>((state) => state.wordCount)),
          style: TextStyle(color: Theme.of(useContext()).disabledColor),
        ),
      );
    });
  }

  Widget _editor(WidgetRef ref) {
    var notifier = ref.watch(memoStateNotifierProvider.notifier);
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
