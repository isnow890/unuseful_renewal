import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/component/full_photo.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';
import 'package:unuseful/common/utils/data_utils.dart';
import 'package:unuseful/meal/model/meal_model.dart';
import 'package:unuseful/meal/provider/hsp_tp_cd_provider.dart';
import 'package:unuseful/meal/provider/meal_provider.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/component/main_drawer.dart';
import '../../common/provider/drawer_selector_provider.dart';
import '../../common/provider/full_photo_start_index_provider.dart';
import '../../user/provider/login_variable_provider.dart';

class MealScreen extends ConsumerStatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  static String get routeName => 'meal';

  @override
  ConsumerState<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends ConsumerState<MealScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(mealNotifierProvider);

    if (state is MealModelLoading) {
      return renderDefaultLayOut(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CustomCircularProgressIndicator()),
          ],
        ),
      );
    }

    if (state is MealModelError) {
      return renderDefaultLayOut(
        widget: Column(
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
        ),
      );
    }

    final cp = state as MealModel;
    return renderDefaultLayOut(
        widget: ListView.separated(
            itemBuilder: (context, index) {
              CarouselController controller = CarouselController();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                                fontSize: 25,
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      carouselController: controller,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,

                        onPageChanged: (index, reason) {
                          ref
                              .read(fullPhotoIndexProvider.notifier)
                              .update((state) => index);
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
                                    context.pushNamed(FullPhoto.routeName,
                                        extra: cp.data[index].images);
                                  },
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: DataUtils.base64Decoder(
                                                  i.base64Encoded) !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.memory(
                                                DataUtils.base64Decoder(
                                                    i.base64Encoded),
                                                fit: BoxFit.fill,
                                              ),
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
  }

  renderDefaultLayOut({
    required Widget widget,
  }) {
    return DefaultLayout(
        centerTitle: false, title: Text('Meal'), child: widget);
  }
}
