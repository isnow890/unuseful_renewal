import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_memory_image/provider/cached_memory_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/common/provider/full_photo_title_provider.dart';

import '../../meal/model/meal_model.dart';
import '../provider/full_photo_start_index_provider.dart';
import '../utils/data_utils.dart';

class FullPhoto extends ConsumerStatefulWidget {
  final int currentIndex;
  final int totalCount;
  final String title;
  final List<MealImageModel> images;

  static String get routeName => 'fullPhoto';

  FullPhoto(
      {required this.currentIndex,
      required this.totalCount,
      required this.images,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<FullPhoto> createState() => _FullPhotoState();
}

class _FullPhotoState extends ConsumerState<FullPhoto> {
  late PageController _pageController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
    print('currentIndex');
    print(widget.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      isDrawerVisible: false,
      // title: Text('FullPhoto ${state + 1}/${widget.images.length}'),
      title: Text(widget.title),
      child: GestureDetector(
        onTap: () {
          // final checkTitleVisibility = ref.read(titleVisiblityProvider);
          //
          // ref.read(titleVisiblityProvider.notifier).update((state) => checkTitleVisibility ? false:true);
        },
        child: Stack(children: [
          Container(
              child: PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (int index) {
              ref
                  .read(fullPhotoIndexProvider.notifier)
                  .update((state) => index);
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedMemoryImageProvider(
                  base64: widget.images[index].base64Encoded,
                  widget.images[index].url,
                ),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.covered * 1.8,
              );
              // return PhotoViewGalleryPageOptions.customChild(
              //   childSize: Size(
              //       Image.memory(
              //         DataUtils.base64Decoder(
              //             widget.images[index].base64Encoded),
              //         fit: BoxFit.fill,
              //       ).low.width!,
              //       Image.memory(
              //         DataUtils.base64Decoder(
              //             widget.images[index].base64Encoded),
              //         fit: BoxFit.fill,
              //       ).height!),
              //   child: Image.memory(
              //     DataUtils.base64Decoder(widget.images[index].base64Encoded),
              //     fit: BoxFit.fill,
              //   ),
              // );
            },
            // scrollPhysics: BouncingScrollPhysics(),
          )
              // PhotoView(
              //   imageProvider: AssetImage(url),
              // ),
              ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _BottomPage(totalCount: widget.totalCount),
            ],
          ),
        ]),
      ),
    );
  }
}

class _BottomPage extends ConsumerWidget {
  const _BottomPage({required this.totalCount, Key? key}) : super(key: key);
  final int totalCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(fullPhotoIndexProvider);
    final title = ref.watch(fullPhotoTitleProvider);

    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Text(
              '${index + 1}/$totalCount',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )),
    ]);
  }
}

//
// class FullPhotoScreen extends StatefulWidget {
//   final String url;
//
//   FullPhotoScreen({Key? key, required this.url}) : super(key: key);
//
//   @override
//   State createState() => FullPhotoScreenState(url: url);
// }
//
// class FullPhotoScreenState extends State<FullPhotoScreen> {
//   final String url;
//
//   FullPhotoScreenState({Key? key, required this.url});
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Container(child: PhotoView(imageProvider: AssetImage(url)));
//
//     return Container(child: PhotoViewGallery.builder(itemCount: null, builder: (BuildContext context, int index) {  },))
//
//   }
// }
