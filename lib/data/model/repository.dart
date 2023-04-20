import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/utils/mapper.dart';
import 'package:new_weather/data/weather_api_client.dart';
import 'package:new_weather/data/mappers/weather_mapper.dart';
import 'package:new_weather/data/model/weather_response.dart';
import 'package:new_weather/domain/entities/failure.dart';
import 'package:new_weather/domain/entities/weather.dart';

final weatherRepositoryProvider = Provider((ref) => WeatherRespositoryImpl(
      ref.watch(apiClientProvider),
      ref.watch(weatherEntityMapperProvider),
    ));

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeather(String query);
}

class WeatherRespositoryImpl extends WeatherRepository {
  final WeatherValuesApiClient weatherApi;
  final EntityMapper<Weather, WeatherResponse> mapper;

  WeatherRespositoryImpl(this.weatherApi, this.mapper);

  @override
  Future<Either<Failure, Weather>> getWeather(String query) async {
    try {
      final weatherResponse = await weatherApi.getWeather(query);
      final weather = mapper.call(weatherResponse);
      return right(weather);
    } catch (error, StackTrace) {
      return left(
        Failure(error, StackTrace),
      );
    }
  }
}
