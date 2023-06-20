import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/component/full_photo.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/common/utils/data_utils.dart';
import 'package:unuseful/meal/model/meal_model.dart';
import 'package:unuseful/meal/provider/hsp_tp_cd_provider.dart';
import 'package:unuseful/meal/provider/meal_current_index_provider.dart';
import 'package:unuseful/meal/provider/meal_provider.dart';
import 'package:unuseful/user/provider/login_variable_provider.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/provider/full_photo_start_index_provider.dart';
import '../../common/provider/full_photo_title_provider.dart';

class MealScreen extends ConsumerStatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  static String get routeName => 'meal';

  @override
  ConsumerState<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends ConsumerState<MealScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(tabListener);

    print('hspTpCdProvider');

    var tmpHspTpCd = ref.read(hspTpCdProvider) == ''
        ? ref.read(loginVariableStateProvider).hspTpCd
        : ref.read(hspTpCdProvider);

    ref.read(mealCurrentIndexProvider.notifier).initializeIndex();

    index = tmpHspTpCd == '01' ? 0 : 1;
  }

  void tabListener() {
    setState(() => index = controller.index);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);
    super.dispose();
    ref.refresh(mealNotifierProvider);

  }

  @override
  Widget build(BuildContext context) {
    final hspTpCd = ref.watch(hspTpCdProvider);

    return DefaultLayout(
      centerTitle: false,
      title: Text('meal'),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          index = value;
          controller.animateTo(value);

          ref
              .read(hspTpCdProvider.notifier)
              .update((state) => index == 0 ? "01" : "02");
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_outlined), label: 'se'),
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'md'),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          MealScreenMain(),
          MealScreenMain(),
        ],
      ),
    );
  }
}

class MealScreenMain extends ConsumerStatefulWidget {
  const MealScreenMain({Key? key}) : super(key: key);

  @override
  ConsumerState<MealScreenMain> createState() => _MealScreenMainState();
}

class _MealScreenMainState extends ConsumerState<MealScreenMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('초기화 실행');
    // ref.read(mealNotifierProvider.notifier).getMeal();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(mealNotifierProvider);
    // final currentIndex = ref.watch(mealCurrentIndexProvider);
    if (state is MealModelLoading) {
      return Center(child: const CustomCircularProgressIndicator());
    }

    if (state is MealModelError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(mealNotifierProvider.notifier).getMeal();
              },
              child: Text('다시 시도')),
        ],
      );
    }

    final cp = state as MealModel;
    return RefreshIndicator(
        onRefresh: () async {
          ref.read(mealNotifierProvider.notifier).getMeal();
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              CarouselController controller = CarouselController();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            cp.data[index].title,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      carouselController: controller,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,

                        onPageChanged: (index2, reason) {
                          ref
                              .read(mealCurrentIndexProvider.notifier)
                              .updateAndGetCurrentIndex(
                                  cp.data[index].mealSeq, index2);

                          ref
                              .read(mealCurrentIndexAlaramProvider.notifier)
                              .update((state) =>
                                  ref.read(mealCurrentIndexAlaramProvider) +
                                  "1");

                          // ref.refresh(mealCurrentIndexProvider.notifier);
                        },
                        height: 400,
                        // aspectRatio: 3.0,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                      ),
                      items: cp.data[index].images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(fullPhotoTitleProvider.notifier)
                                        .update(
                                            (state) => cp.data[index].title);
                                    ref
                                        .read(fullPhotoIndexProvider.notifier)
                                        .update((state) => ref
                                            .read(mealCurrentIndexProvider
                                                .notifier)
                                            .getCurrentIndex(
                                                cp.data[index].mealSeq));
                                    context.pushNamed(FullPhoto.routeName,
                                        queryParameters: {
                                          'currentIndex': ref
                                              .read(mealCurrentIndexProvider
                                                  .notifier)
                                              .getCurrentIndex(
                                                  cp.data[index].mealSeq)
                                              .toString(),
                                          'totalCount': cp
                                              .data[index].images.length
                                              .toString(),
                                          'title': cp.data[index].title,
                                        },
                                        extra: cp.data[index].images);
                                  },
                                  child: Center(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: DataUtils.base64Decoder(
                                                  i.base64Encoded) !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),

                                        child:Image.memory(
                                          DataUtils.base64Decoder(
                                              i.base64Encoded),
                                          fit: BoxFit.fill,
                                        ),
                                              // child: CachedMemoryImage(
                                              //   uniqueKey: i.url,
                                              //   base64: i.base64Encoded,
                                              //   fit: BoxFit.fill,
                                              // ),
                                            )
                                          : Icon(Icons.image),
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          },
                        );
                      }).toList(),
                    ),
                    _MealCurrentIndexIndicator(
                      mealSeq: cp.data[index].mealSeq,
                      currentIndex: ref
                          .read(mealCurrentIndexProvider.notifier)
                          .getCurrentIndex(cp.data[index].mealSeq),
                      totalCount: cp.data[index].images.length,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 20.0,
              );
            },
            itemCount: state.data.length));

    ;
  }

  renderDefaultLayOut({
    required Widget widget,
  }) {
    return DefaultLayout(
        centerTitle: false, title: Text('meal'), child: widget);
  }
}

class _MealCurrentIndexIndicator extends ConsumerStatefulWidget {
  final int mealSeq;
  final int totalCount;
  final int currentIndex;

  const _MealCurrentIndexIndicator(
      {required this.totalCount,
      required this.mealSeq,
      required this.currentIndex,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<_MealCurrentIndexIndicator> createState() =>
      _MealCurrentIndexIndicatorState();
}

class _MealCurrentIndexIndicatorState
    extends ConsumerState<_MealCurrentIndexIndicator> {
  @override
  Widget build(BuildContext context) {
    ref.watch(mealCurrentIndexAlaramProvider);
    final h = ref.watch(mealCurrentIndexProvider.notifier);
    final index = ref
        .watch(mealCurrentIndexProvider.notifier)
        .getCurrentIndex(widget.mealSeq);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        '${index + 1}/${widget.totalCount}',
        style: (TextStyle(
          fontSize: 12,
          color: BODY_TEXT_COLOR,
          fontWeight: FontWeight.w500,
        )),
      ),
    );
  }
}

//
// class MealScreen extends ConsumerStatefulWidget {
//   const MealScreen({Key? key}) : super(key: key);
//
//   static String get routeName => 'meal';
//
//   @override
//   ConsumerState<MealScreen> createState() => _MealScreenState();
// }
//
// class _MealScreenState extends ConsumerState<MealScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print('초기화 실행');
//
//     ref.read(mealNotifierProvider.notifier).getMeal();
//   }
//
//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     final state = ref.watch(mealNotifierProvider);
//     final hspTpCd = ref.watch(hspTpCdProvider);
//     // final currentIndex = ref.watch(mealCurrentIndexProvider);
//     if (state is MealModelLoading) {
//       return renderDefaultLayOut(
//         widget: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Center(child: CustomCircularProgressIndicator()),
//           ],
//         ),
//       );
//     }
//
//     if (state is MealModelError) {
//       return renderDefaultLayOut(
//         widget: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               state.message,
//               textAlign: TextAlign.center,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(mealNotifierProvider.notifier).getMeal();
//                 },
//                 child: Text('다시 시도')),
//           ],
//         ),
//       );
//     }
//
//     final cp = state as MealModel;
//     return RefreshIndicator(
//         child: renderDefaultLayOut(
//             widget: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Flexible(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8),
//                 child: MaterialSegmentedControl(
//                   children: {
//                     0: Text(
//                       'se',
//                       style:
//                           TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//                     ),
//                     1: Text(
//                       'md',
//                       style:
//                           TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//                     )
//                   },
//                   selectionIndex: (hspTpCd == ''
//                               ? ref.read(loginVariableStateProvider).hspTpCd
//                               : hspTpCd) ==
//                           "01"
//                       ? 0
//                       : 1,
//                   borderColor: Colors.transparent,
//                   selectedColor: PRIMARY_COLOR,
//                   unselectedColor: INPUT_BORDER_COLOR,
//                   selectedTextStyle: TextStyle(color: Colors.white),
//                   unselectedTextStyle: TextStyle(color: Colors.black),
//                   borderWidth: 0,
//                   borderRadius: 1.0,
//                   onSegmentTapped: (index) {
//                     ref
//                         .read(hspTpCdProvider.notifier)
//                         .update((state) => index == 0 ? "01" : "02");
//                   },
//                 ),
//               ),
//             ),
//             Flexible(
//               flex: 20,
//               child: ListView.separated(
//                   itemBuilder: (context, index) {
//                     CarouselController controller = CarouselController();
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text(
//                                   cp.data[index].title,
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: PRIMARY_COLOR,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           CarouselSlider(
//                             carouselController: controller,
//                             options: CarouselOptions(
//                               enableInfiniteScroll: false,
//
//                               onPageChanged: (index2, reason) {
//                                 ref
//                                     .read(mealCurrentIndexProvider.notifier)
//                                     .updateAndGetCurrentIndex(
//                                         cp.data[index].mealSeq, index2);
//
//                                 ref
//                                     .read(
//                                         mealCurrentIndexAlaramProvider.notifier)
//                                     .update((state) =>
//                                         ref.read(
//                                             mealCurrentIndexAlaramProvider) +
//                                         "1");
//
//                                 // ref.refresh(mealCurrentIndexProvider.notifier);
//                               },
//                               height: 400,
//                               // aspectRatio: 3.0,
//                               enlargeCenterPage: true,
//                               viewportFraction: 1,
//                             ),
//                             items: cp.data[index].images.map((i) {
//                               return Builder(
//                                 builder: (BuildContext context) {
//                                   return Column(children: [
//                                     Flexible(
//                                       flex: 1,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // print(ref
//                                           //     .read(mealCurrentIndexProvider.notifier)
//                                           //     .getCurrentIndex(
//                                           //         cp.data[index].mealSeq));
//
//                                           ref
//                                               .read(fullPhotoTitleProvider
//                                                   .notifier)
//                                               .update((state) =>
//                                                   cp.data[index].title);
//
//                                           ref
//                                               .read(fullPhotoIndexProvider
//                                                   .notifier)
//                                               .update((state) => ref
//                                                   .read(mealCurrentIndexProvider
//                                                       .notifier)
//                                                   .getCurrentIndex(
//                                                       cp.data[index].mealSeq));
//
//                                           context.pushNamed(FullPhoto.routeName,
//                                               queryParameters: {
//                                                 'currentIndex': ref
//                                                     .read(
//                                                         mealCurrentIndexProvider
//                                                             .notifier)
//                                                     .getCurrentIndex(
//                                                         cp.data[index].mealSeq)
//                                                     .toString(),
//                                                 'totalCount': cp
//                                                     .data[index].images.length
//                                                     .toString(),
//                                               },
//                                               extra: cp.data[index].images);
//                                         },
//                                         child: Center(
//                                           child: Container(
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             margin: EdgeInsets.symmetric(
//                                                 horizontal: 5.0),
//                                             child: DataUtils.base64Decoder(
//                                                         i.base64Encoded) !=
//                                                     null
//                                                 ? ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.0),
//                                                     child: CachedMemoryImage(
//                                                       uniqueKey: i.url,
//                                                       base64: i.base64Encoded,
//                                                       fit: BoxFit.fill,
//                                                     ),
//                                                   )
//                                                 : Icon(Icons.image),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]);
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                           _MealCurrentIndexIndicator(
//                             mealSeq: cp.data[index].mealSeq,
//                             currentIndex: ref
//                                 .read(mealCurrentIndexProvider.notifier)
//                                 .getCurrentIndex(cp.data[index].mealSeq),
//                             totalCount: cp.data[index].images.length,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       height: 20.0,
//                     );
//                   },
//                   itemCount: state.data.length),
//             ),
//           ],
//         )),
//         color: PRIMARY_COLOR,
//         onRefresh: () async {
//           ref.read(mealNotifierProvider.notifier).getMeal();
//         });
//
//     ;
//   }
//
//   renderDefaultLayOut({
//     required Widget widget,
//   }) {
//     return DefaultLayout(
//         centerTitle: false, title: Text('meal'), child: widget);
//   }
// }
//
// class _MealCurrentIndexIndicator extends ConsumerStatefulWidget {
//   final int mealSeq;
//   final int totalCount;
//   final int currentIndex;
//
//   const _MealCurrentIndexIndicator(
//       {required this.totalCount,
//       required this.mealSeq,
//       required this.currentIndex,
//       Key? key})
//       : super(key: key);
//
//   @override
//   ConsumerState<_MealCurrentIndexIndicator> createState() =>
//       _MealCurrentIndexIndicatorState();
// }
//
// class _MealCurrentIndexIndicatorState
//     extends ConsumerState<_MealCurrentIndexIndicator> {
//   @override
//   Widget build(BuildContext context) {
//     ref.watch(mealCurrentIndexAlaramProvider);
//     final h = ref.watch(mealCurrentIndexProvider.notifier);
//     final index = ref
//         .watch(mealCurrentIndexProvider.notifier)
//         .getCurrentIndex(widget.mealSeq);
//     return Text(
//       '${index + 1}/${widget.totalCount}',
//       style: (TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w500,
//       )),
//     );
//   }
// }
