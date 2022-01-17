class PlanetResponse {
  PlanetResponse({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });
  late final int count;
  late final String next;
  late final Null previous;
  late final List<Planet> results;

  PlanetResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = null;
    results =
        List.from(json['results']).map((e) => Planet.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Planet {
  Planet({
    required this.name,
    required this.rotationPeriod,
    required this.orbitalPeriod,
    required this.diameter,
    required this.climate,
    required this.gravity,
    required this.terrain,
    required this.surfaceWater,
    required this.population,
    required this.residents,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });
  late final String name;
  late final String rotationPeriod;
  late final String orbitalPeriod;
  late final String diameter;
  late final String climate;
  late final String gravity;
  late final String terrain;
  late final String surfaceWater;
  late final String population;
  late final List<String> residents;
  late final List<String> films;
  late final String created;
  late final String edited;
  late final String url;

  Planet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rotationPeriod = json['rotation_period'];
    orbitalPeriod = json['orbital_period'];
    diameter = json['diameter'];
    climate = json['climate'];
    gravity = json['gravity'];
    terrain = json['terrain'];
    surfaceWater = json['surface_water'];
    population = json['population'];
    residents = List.castFrom<dynamic, String>(json['residents']);
    films = List.castFrom<dynamic, String>(json['films']);
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['rotation_period'] = rotationPeriod;
    _data['orbital_period'] = orbitalPeriod;
    _data['diameter'] = diameter;
    _data['climate'] = climate;
    _data['gravity'] = gravity;
    _data['terrain'] = terrain;
    _data['surface_water'] = surfaceWater;
    _data['population'] = population;
    _data['residents'] = residents;
    _data['films'] = films;
    _data['created'] = created;
    _data['edited'] = edited;
    _data['url'] = url;
    return _data;
  }
}
