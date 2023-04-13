import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/repository.dart';
import 'package:new_weather/domain/notifiers/weather_state.dart';

final weatherValueProvider =
    StateNotifierProvider<WeatherStateNotifier, WeatherState>((ref) =>
        WeatherStateNotifier(ref.watch(weatherRepositoryProvider))
          ..getWeather());

class WeatherStateNotifier extends StateNotifier<WeatherState> {
  Timer? _debounceTimer;

  final WeatherRepository _weatherRepository;

  WeatherStateNotifier(this._weatherRepository) : super(WeatherState.initial());

  void getWeather({String? query}) async {
    if (state.whenOrNull(
          loading: () => true,
        ) ==
        true) {
      return;
    }

    state = WeatherState.loading();
    await debounce();

    //moram spremiti dodatni state u drugu varijablu u notifieru il weatherState.loading dodati parametar koji sadrzi listu i zbrojim liste
    final result = await _weatherRepository.getWeather(query ?? 'Zagreb');
    //raspakiravanje rezultata
    result.fold(
      (error) => state = WeatherState.failure(error),
      //dohvat podatka weather
      (weather) => state = WeatherState.loaded(weather),
    );
  }

  Future<void> debounce({
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    if (_debounceTimer?.isActive == true) {
      _debounceTimer?.cancel();
    }
    final debounceCompleter = Completer();
    _debounceTimer = Timer(
      duration,
      () => debounceCompleter.complete(),
    );
    await debounceCompleter.future;
  }
}
