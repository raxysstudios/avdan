import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(super.locale);

  void toggleLocale() {
    emit(state.languageCode == 'en' ? const Locale('ru') : const Locale('en'));
  }
}
