import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/theme/component/photo_view/full_photo.dart';
import 'package:unuseful/theme/component/photo_view/number_indicator.dart';

class MealPageView extends ConsumerStatefulWidget {
  const MealPageView({required this.meal, Key? key}) : super(key: key);

  final MealModelList meal;

  @override
  ConsumerState<MealPageView> createState() => _MealPageViewState();
}

class _MealPageViewState extends ConsumerState<MealPageView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cp = widget.meal;

    return Stack(
      children: [
        PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: cp.imgUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  child: AspectRatio(
                    aspectRatio: 1 / 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          // print('tap');
                          // print(cp.data![index].imgUrls[index2]);
                          context.pushNamed(FullPhoto.routeName,
                              queryParameters: {
                                'currentIndex': index.toString(),
                                'totalCount': cp.imgUrls.length.toString(),
                                'title': cp.title,
                              },
                              extra: cp.imgUrls);
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: cp.imgUrls[index],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
        Positioned(
          bottom: 16,
          right: 16,
          child: NumberIndicator(
            currentPage: currentIndex + 1,
            length: cp.imgUrls.length,
          ),
        ),
      ],
    );
  }
}
