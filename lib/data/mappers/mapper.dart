import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/weather_response.dart';
import 'package:new_weather/domain/entities/weather.dart';

typedef EntityMapper<Entity, Response> = Entity Function(Response);

final weatherEntityMapperProvider =
    Provider<EntityMapper<Weather, WeatherResponse>>(
  (ref) => (response) => Weather(
        response.location.name,
        response.location.country,
        response.current.tempC,
        response.current.condition.text,
        'http:${response.current.condition.icon}',
      ),
);
