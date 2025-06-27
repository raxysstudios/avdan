import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(super.locale);
  LocaleCubit.fromName(String name)
      : this(
          Locale(
            switch (name) {
              'russian' => 'ru',
              'turkish' => 'tr',
              _ => 'en',
            },
          ),
        );

  void update(String code) {
    emit(Locale(code));
  }
}
