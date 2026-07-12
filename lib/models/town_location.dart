enum TownStatus { active, expanding }

class TownLocation {
  final String name;
  final String region;
  final TownStatus status;
  final String description;

  const TownLocation({
    required this.name,
    required this.region,
    required this.status,
    required this.description,
  });

  static const List<TownLocation> all = [
    TownLocation(
      name: 'Bungoma',
      region: 'Western Kenya',
      status: TownStatus.active,
      description: 'Our home base — full fiber and hotspot coverage across town.',
    ),
    TownLocation(
      name: 'Nairobi',
      region: 'Nairobi County',
      status: TownStatus.expanding,
      description: 'Kenya\'s capital — expansion planned for estates and business districts.',
    ),
    TownLocation(
      name: 'Nakuru',
      region: 'Rift Valley',
      status: TownStatus.expanding,
      description: 'Growing hub — bringing reliable connectivity to homes and SMEs.',
    ),
    TownLocation(
      name: 'Kisumu',
      region: 'Nyanza',
      status: TownStatus.expanding,
      description: 'Lakeside city — planned hotspot and fiber rollout.',
    ),
    TownLocation(
      name: 'Mombasa',
      region: 'Coast',
      status: TownStatus.expanding,
      description: 'Coastal expansion — connecting businesses along the coast.',
    ),
    TownLocation(
      name: 'Kericho',
      region: 'Rift Valley',
      status: TownStatus.expanding,
      description: 'Tea country — upcoming network deployment for the region.',
    ),
  ];
}
