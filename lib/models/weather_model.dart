import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;

  Weather({required this.cityName, required this.temperature});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
