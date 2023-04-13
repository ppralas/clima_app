import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/weather_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

final apiClientProvider = Provider(
  (ref) => WeatherValuesApiClient(
    Dio()
      ..interceptors.add(
        TokenInterceptor(),
      ),
  ),
);

@RestApi(baseUrl: 'https://weatherapi-com.p.rapidapi.com')
abstract class WeatherValuesApiClient {
  factory WeatherValuesApiClient(Dio dio, {String baseUrl}) =
      _WeatherValuesApiClient;

  @GET('/current.json')
  Future<WeatherResponse> getWeather(@Query('q') String city);
}

class TokenInterceptor extends QueuedInterceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.responseType = ResponseType.json;
    options.headers.addEntries(
      const [
        MapEntry<String, String>(
          'X-RapidAPI-Key',
          '7d72957525msh0a3476e8238d3c2p12c493jsne6832b801c90',
        ),
        MapEntry<String, String>(
          'X-RapidAPI-Host',
          'weatherapi-com.p.rapidapi.com',
        ),
      ],
    );
    super.onRequest(options, handler);
  }
}
