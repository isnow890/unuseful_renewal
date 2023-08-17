import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_memory_image/provider/cached_memory_image_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import '../../../../util/helper/data_utils.dart';
import 'number_indicator.dart';

class FullPhoto extends ConsumerStatefulWidget {
  final int currentIndex;
  final int totalCount;
  final String title;
  final List<String> images;

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

  int currentIndex = 0;

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
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      tabToHideAppbar: true,
      isDrawerVisible: false,
      // title: Text('FullPhoto ${state + 1}/${widget.images.length}'),
      title: widget.title,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          child: PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(widget.images[index]),
                minScale: PhotoViewComputedScale.contained * 0.9,
                maxScale: PhotoViewComputedScale.covered * 1.5,
              );
            },
            // scrollPhysics: BouncingScrollPhysics(),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Center(
            child: NumberIndicator(
              length: widget.totalCount,
              currentPage: currentIndex + 1,
            ),
          ),
        ),
      ]),
    );
  }
}
