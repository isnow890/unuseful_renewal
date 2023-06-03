import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:unuseful/common/layout/default_layout.dart';
import 'package:unuseful/common/utils/data_utils.dart';

import '../../meal/model/meal_model.dart';
import '../provider/full_photo_start_index_provider.dart';

class FullPhoto extends ConsumerStatefulWidget {
  final List<MealImageModel> images;

  static String get routeName => 'fullPhoto';

  FullPhoto({required this.images, Key? key}) : super(key: key);

  @override
  ConsumerState<FullPhoto> createState() => _FullPhotoState();
}

class _FullPhotoState extends ConsumerState<FullPhoto> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: ref.read(fullPhotoIndexProvider));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fullPhotoIndexProvider);

    return DefaultLayout(
      isDrawerVisible: false,
      title: Text('FullPhoto ${state + 1}/${widget.images.length}'),
      child: Container(
          child: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (int index) {
          ref.read(fullPhotoIndexProvider.notifier).update((state) => index);
        },
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: MemoryImage(
                DataUtils.base64Decoder(widget.images[index].base64Encoded)),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.8,
          );
        },
        // scrollPhysics: BouncingScrollPhysics(),
      )
          // PhotoView(
          //   imageProvider: AssetImage(url),
          // ),
          ),
    );
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
