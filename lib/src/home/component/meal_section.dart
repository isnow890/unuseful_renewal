import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/theme/component/section_card.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';
import 'package:unuseful/src/meal/provider/meal_provider.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/component/photo_view/full_photo.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

class MealSection extends ConsumerStatefulWidget {
  const MealSection({required this.hspTpCd, super.key});

  final String hspTpCd;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MealSectionState();
}

class _MealSectionState extends ConsumerState<MealSection> {

  _renderCardInside(String hspTpCd, MealModel mealModel) {
    final theme = ref.watch(themeServiceProvider);

    if (mealModel.data!.isEmpty) {
      return Text('No data found ${hspTpCd}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hspTpCd == '01' ? '서울병원' : '목동병원',
          style: theme.typo.subtitle1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(
          height: 15,
        ),
        Text(style: theme.typo.body1, mealModel.data![0].title),
        Column(
          children: mealModel.data![0].imgUrls
              .asMap()
              .entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    child: AspectRatio(
                      aspectRatio: 1 / 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(FullPhoto.routeName,
                                queryParameters: {
                                  'currentIndex': e.key.toString(),
                                  'totalCount': mealModel
                                      .data![0].imgUrls.length
                                      .toString(),
                                  'title': mealModel.data![0].title,
                                },
                                extra: mealModel.data![0].imgUrls);
                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: e.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mealFamilyProvider(widget.hspTpCd));
    var model = MealModel();

    if (state is MealModel) {
      model = state;
    }

    return SectionCard(
      contentWidget: Column(
        children: [
          _renderCardInside(widget.hspTpCd, model),
        ],
      ),
    );
  }
}
