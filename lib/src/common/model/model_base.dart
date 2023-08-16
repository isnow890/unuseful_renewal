abstract class ModelBase {}

class ModelBaseLoading extends ModelBase {}

class ModelBaseError extends ModelBase {
  final String message;

  ModelBaseError({required this.message}) {}
}

class ModelBaseInit extends ModelBase {}
