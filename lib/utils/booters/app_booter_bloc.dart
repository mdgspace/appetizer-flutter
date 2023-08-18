import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_booter_event.dart';
part 'booter.dart';

enum AppBooterStatus { booting, booted }

class AppBooter extends Bloc<AppBooterEvent, AppBooterStatus> {
  AppBooter() : super(AppBooterStatus.booting) {
    on<BootUp>(_bootUp);
    on<OnBootUp>(_onBootUp);
  }

  void _bootUp(BootUp event, Emitter<AppBooterStatus> emit) {
    log('[AppBooter.BootUp]');
  }

  void _onBootUp(OnBootUp event, Emitter<AppBooterStatus> emit) {}
}
