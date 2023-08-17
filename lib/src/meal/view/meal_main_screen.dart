import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/src/meal/provider/meal_current_index_provider.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/src/meal/view/meal_current_index_indicator.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/photo_view/full_photo.dart';

class MealScreenMain extends ConsumerStatefulWidget {
  final String hspTpCd;

  const MealScreenMain({required this.hspTpCd, Key? key}) : super(key: key);

  @override
  ConsumerState<MealScreenMain> createState() => _MealScreenMainState();
}

class _MealScreenMainState extends ConsumerState<MealScreenMain> {

  int currentIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ref.read(mealNotifierProvider.notifier).getMeal();
  }

  @override
  Widget build(BuildContext context) {
    final gloabl = ref.watch(globalVariableStateProvider);
    final state = ref.watch(mealFamilyProvider(widget.hspTpCd));

    // final currentIndex = ref.watch(mealCurrentIndexProvider);
    if (state is ModelBaseLoading) {
      return Center(child: const CustomCircularProgressIndicator());
    }

    if (state is ModelBaseError) {
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
                ref.read(mealFamilyProvider(widget.hspTpCd).notifier).getMeal();
              },
              child: Text('다시 시도')),
        ],
      );
    }

    final cp = state as MealModel;
    return RefreshIndicator(
        onRefresh: () async {
          ref.read(mealFamilyProvider(widget.hspTpCd).notifier).getMeal();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 1),
          child: ListView.separated(
              itemBuilder: (context, index) {
                CarouselController controller = CarouselController();
                return Card(
                  shape: RoundedRectangleBorder(
                    //모서리를 둥글게 하기 위해 사용
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                cp.data![index].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        CarouselSlider(
                          carouselController: controller,
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            onPageChanged: (index2, reason) {


                              // ref
                              //     .read(mealCurrentIndexProvider.notifier)
                              //     .updateAndGetCurrentIndex(
                              //         cp.data![index].mealSeq, index2);
                              // ref
                              //     .read(mealCurrentIndexAlaramProvider.notifier)
                              //     .update((state) =>
                              //         ref.read(mealCurrentIndexAlaramProvider) +
                              //         "1");
                              // ref.refresh(mealCurrentIndexProvider.notifier);
                            },
                            height: 400,
                            // aspectRatio: 3.0,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                          ),
                          items: cp.data![index].imgUrls.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Column(children: [
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        // ref
                                        //     .read(
                                        //         fullPhotoTitleProvider.notifier)
                                        //     .update((state) =>
                                        //         cp.data[index].title);
                                        // ref
                                        //     .read(
                                        //         fullPhotoIndexProvider.notifier)
                                        //     .update((state) => ref
                                        //         .read(mealCurrentIndexProvider
                                        //             .notifier)
                                        //         .getCurrentIndex(
                                        //             cp.data[index].mealSeq));
                                        context.pushNamed(FullPhoto.routeName,
                                            queryParameters: {
                                              'currentIndex': ref
                                                  .read(mealCurrentIndexProvider
                                                      .notifier)
                                                  .getCurrentIndex(
                                                      cp.data![index].mealSeq)
                                                  .toString(),
                                              'totalCount': cp
                                                  .data![index].imgUrls.length
                                                  .toString(),
                                              'title': cp.data![index].title,
                                            },
                                            extra: cp.data![index].imgUrls);
                                      },
                                      child: Center(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(i!,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              },
                            );
                          }).toList(),
                        ),
                        MealCurrentIndexIndicator(
                          mealSeq: cp.data![index].mealSeq,
                          currentIndex: ref
                              .read(mealCurrentIndexProvider.notifier)
                              .getCurrentIndex(cp.data![index].mealSeq),
                          totalCount: cp.data![index].imgUrls.length,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 20.0,
                );
              },
              itemCount: state.data!.length),
        ));

    ;
  }
}
