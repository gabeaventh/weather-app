import 'package:core/modules/logger/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLogger extends BlocObserver {
  List<String> excludeBlocName;

  BlocLogger({this.excludeBlocName = const []});

  static const String TAG = 'BlocLogger';
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!excludeBlocName.contains(_removeInstanceOf(bloc.toString()))) {
      Log.info(TAG, 'On Event: $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!excludeBlocName.contains(_removeInstanceOf(bloc.toString()))) {
      Log.warning(TAG, 'On Change: $change');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!excludeBlocName.contains(_removeInstanceOf(bloc.toString()))) {
      Log.info(TAG, 'On Transition: $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    if (!excludeBlocName.contains(_removeInstanceOf(bloc.toString()))) {
      Log.warning(TAG, 'On Error: $error');
    }
  }

  String _removeInstanceOf(String val) {
    if (val.contains('Instance of')) return val.substring(13, val.length - 1);
    return val;
  }
}
