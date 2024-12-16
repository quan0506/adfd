class Place {
  final int id;
  final String name;
  final double rate;
  final String image;


  Place({
    required this.id,
    required this.name,
    required this.rate,
    required this.image,

  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      rate: json['rate'].toDouble(),
      image: json['image'],
    );
  }
}
