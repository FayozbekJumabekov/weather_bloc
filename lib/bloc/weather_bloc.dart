import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/weather_model.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) => mapEventToState(event, emit));
  }

  Future<void> mapEventToState(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    print("Working");
    if (event is GetWeather) {
      emit(WeatherLoading());
      final weather = await fetchWeather(event.cityName);
      emit(WeatherLoaded(weather));
    }
  }

  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
        cityName: cityName,
        temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
      );
    });
  }
}
