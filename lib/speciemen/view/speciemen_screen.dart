import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/layout/default_layout.dart';

import '../../common/component/custom_radio_tile.dart';
import '../../common/component/custom_text_form_field.dart';
import '../../common/component/main_drawer.dart';
import '../../common/const/colors.dart';
import '../../common/provider/drawer_selector_provider.dart';
import '../../telephone/provider/telephone_order_radio_tile_provider.dart';
import '../../telephone/provider/telephone_search_value_provider.dart';

class SpeciemenScreen extends ConsumerWidget {
  static String get routeName => 'speciemen';

  const SpeciemenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
      ],

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.barcode_reader,
          size: 30,
        ),
      ),
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          child: CustomTextFormField(
            contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
            hintText: 'Scanned data will be shown. Or just type it.',
            onChanged: (value) {
              ref
                  .read(telephoneSearchValueProvider.notifier)
                  .update((state) => value);

            },
          ),
        ),
      ),
      child: Center(
        child: Text('speciemen'),
      ),
      // TextTitle(title:  'telephone',
      // ),
    );
  }

  barcodeScan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    print(barcodeScanRes);
    // barcodeText = barcodeScanRes;
  }
}
