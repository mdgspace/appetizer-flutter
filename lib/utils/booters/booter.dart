part of 'app_booter_bloc.dart';

abstract class Booter<T> {
  Future<T> bootUp();

  void onBootUp();

  void bootDown();
}
