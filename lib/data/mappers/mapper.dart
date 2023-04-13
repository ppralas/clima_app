import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/weather_response.dart';
import 'package:new_weather/domain/entities/weather.dart';

typedef EntityMapper<Entity, Response> = Entity Function(Response);

final weatherEntityMapperProvider =
    Provider<EntityMapper<Weather, WeatherResponse>>(
  (ref) => (response) => Weather(
        'http:' + response.current.condition.icon,
        response.current.condition.text,
        response.current.tempC,
        response.location.country,
        response.location.name,
      ),
);
