import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_weather/domain/entities/failure.dart';
import 'package:new_weather/domain/entities/weather.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  //definirat koje cu imati stateove,
  const factory WeatherState.initial() = _Initial;
  const factory WeatherState.loading() = _Loading;
  const factory WeatherState.failure(Failure failure) = _Failure;
  //Za razliku od beer projekta ovdje samo objekt redajem ne slistu jer en cuvam listu prognoza
  const factory WeatherState.loaded(Weather weather) = _Loaded;
}

//nakon sto ovo napisem build runner pokrenuti kako bi se izgenerirao .freezed dart 
