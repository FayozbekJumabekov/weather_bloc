part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather(this.cityName);
}
