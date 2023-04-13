import 'package:equatable/equatable.dart';
import 'package:new_weather/data/model/weather_response.dart';

class Weather extends Equatable {
  final Location location;
  final Current current;

  Weather(this.location, this.current);

  @override
  List<Object?> get props => [location, current];
}
