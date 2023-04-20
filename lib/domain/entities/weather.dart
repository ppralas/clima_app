import 'package:equatable/equatable.dart';

//entitet se formira iskljucivo po UI-u i gledam koje mi stvari trebaju da oformim ovaj ui, mogu primati string

class Weather extends Equatable {
  final String cityName;
  final String countryName;
  final double tempC;
  final String text;
  final String icon;

  const Weather(
    this.cityName,
    this.countryName,
    this.tempC,
    this.text,
    this.icon,
  );

  @override
  List<Object?> get props => [
        cityName,
        countryName,
        tempC,
        text,
        icon,
      ];
}
