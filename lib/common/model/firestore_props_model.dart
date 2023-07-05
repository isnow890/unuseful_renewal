import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/common/model/search_history_specimen_model.dart';
import 'package:unuseful/common/model/search_history_telephone_model.dart';

part 'firestore_props_model.g.dart';

abstract class FirestorePropsModelBase {}

@JsonSerializable()
class FirestorePropsModel extends FirestorePropsModelBase {
  final String id;
  List<SearchHistoryTelephoneModel> telephoneHistory;
  List<SearchHistorySpecimenModel> specimenHistory;

  FirestorePropsModel(
      {required this.id,
      required this.telephoneHistory,
      required this.specimenHistory});
}

class FirestorePropsModelLoading extends FirestorePropsModelBase {}

class FirestorePropsModelError extends FirestorePropsModelBase {
  final String message;

  FirestorePropsModelError({required this.message});
}
