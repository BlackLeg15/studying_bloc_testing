class Weather {
  final String cityName;
  final double temperatureInCelsius;

  const Weather(this.cityName, this.temperatureInCelsius);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Weather &&
        o.cityName == cityName &&
        o.temperatureInCelsius == temperatureInCelsius;
  }

  @override
  int get hashCode => cityName.hashCode + temperatureInCelsius.hashCode;
}
