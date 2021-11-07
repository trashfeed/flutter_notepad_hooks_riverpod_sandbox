import 'package:hooks_riverpod/hooks_riverpod.dart';

final memoStateNotifierProvider =
    StateNotifierProvider<MemoStateNotifier, Memo>((ref) {
  return MemoStateNotifier(Memo.empty());
});

class Memo {
  Memo({required this.memo, required this.wordCount});
  final String memo;
  final String wordCount;
  factory Memo.empty() {
    return Memo(memo: '', wordCount: '');
  }
}

class MemoStateNotifier extends StateNotifier<Memo> {
  MemoStateNotifier(Memo state) : super(state);
  void update({required String memo}) {
    state = Memo(
        memo: memo,
        wordCount: memo.isEmpty ? '' : 'count:${memo.length}');
  }
}
