import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealCurrentIndexFamilyProvider =
    Provider.family<int, int>((ref, mealSeq) {
  final index = ref.watch(mealCurrentIndexProvider.notifier);
  final currentIndex =
      ref.watch(mealCurrentIndexProvider.notifier).getCurrentIndex(mealSeq);
  print('currentIndex');
  print(currentIndex);

  return currentIndex;
});

final mealCurrentIndexProvider =
    StateNotifierProvider<MealCurrentIndexNotifier, List<CurrentIndex>>((ref) {
  return MealCurrentIndexNotifier();
});

class MealCurrentIndexNotifier extends StateNotifier<List<CurrentIndex>> {
  MealCurrentIndexNotifier() : super([]);

  int getCurrentIndex(int mealSeq) {
    List<CurrentIndex> tmpMap = state;

    if (state.where((element) => element.mealSeq == mealSeq).isNotEmpty) {
      return state
          .firstWhere((element) => element.mealSeq == mealSeq)
          .currentIndex;
    }

    return 0;
  }

  int updateAndGetCurrentIndex(int mealSeq, int currentIndex) {


    List<CurrentIndex> cp = [...state];


    if (cp.where((element) => element.mealSeq == mealSeq).isNotEmpty) {
      for (var o in cp)
        if (o.mealSeq == mealSeq)    o.currentIndex = currentIndex;
    } else {
      cp.add(CurrentIndex(mealSeq: mealSeq, currentIndex: currentIndex));
    }

    print(
        cp.firstWhere((element) => element.mealSeq == mealSeq).currentIndex);

    state = cp;
    return cp
        .firstWhere((element) => element.mealSeq == mealSeq)
        .currentIndex;
  }

  //인덱스 초기화
  void initializeIndex() => state = [];
}


class CurrentIndex{
  int mealSeq;
  int currentIndex;

  CurrentIndex({required this.mealSeq, required this.currentIndex});
}

final mealCurrentIndexAlaramProvider = StateProvider<String>((ref) => '');
