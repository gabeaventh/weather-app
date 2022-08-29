import 'dart:async';

import 'package:core/modules/logger/bloc_observer.dart';
import 'package:core/modules/utility/helper.dart';
import 'package:delosaqua_trial/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = BlocLogger();

  runZonedGuarded(() async {
    runApp(const InitApp());
  }, (e, s) => Helper.catchError(e, s));
}
