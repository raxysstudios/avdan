import 'package:avdan/l10n/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(super.locale);

  String get code => state.languageCode;
  String get name => codeToName(code);

  void update(String code) {
    emit(Locale(code));
  }
}
