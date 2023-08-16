import 'package:flutter/material.dart';
import 'package:unuseful/colors.dart';


void CustomAlert({
  required BuildContext context,
  required String contents,
  required yesTitle,
  required VoidCallback yesAction,
  String? noTitle,
  VoidCallback? noAction,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: new Text(
          contents,
          style: TextStyle(fontSize: 14.0),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: yesAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: Text(yesTitle!),
          ),
          if (noTitle != null)
            ElevatedButton(
              onPressed: noAction, //Navigator.of(context).pop()
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  width: 1.0,
                  color: PRIMARY_COLOR,
                ),
              ),
              child: Text(noTitle!,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                  )),
            ),
        ],
      );
    },
  );
}
//
// Widget _whenOnlyYes({
//   required VoidCallback yesAction,
//   required String yesTitle,
// }) {
//   return ElevatedButton(
//     onPressed: yesAction,
//     style: ElevatedButton.styleFrom(
//       backgroundColor: PRIMARY_COLOR,
//     ),
//     child: Text(yesTitle),
//   );
// }
//
// Widget[]
//
// _whenYesAndNo({
//   required VoidCallback yesAction,
//   required String yesTitle,
//   required VoidCallback noAction,
//   required String noTitle,
// }) {
//   return ElevatedButton(
//     onPressed: () {},
//     style: ElevatedButton.styleFrom(
//       backgroundColor: PRIMARY_COLOR,
//     ),
//     child: Text('확인'),
//   ),
//   ElevatedButton(
//   onPressed: () => Navigator.of(context).pop(),
//   style: ElevatedButton.styleFrom(
//   backgroundColor: Colors.white,
//   side: const BorderSide(
//   width: 1.0,
//   color: PRIMARY_COLOR,
//   ),
//   ),
//   child: Text('취소',
//   style: TextStyle(
//   color:
//   PRIMARY_COLOR
//   ,
//   )
//   )
//   ,
//   );
// }
