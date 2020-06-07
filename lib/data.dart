  
class PlanetInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  PlanetInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
    this.images,
  });
}


List<PlanetInfo> planets = [
  PlanetInfo(1,
      name: 'Ventas',
      iconImage: 'assets/logogumen.png'),

  PlanetInfo(2,
      name: 'Ventas',
      iconImage: 'assets/logogumen.png'),
];