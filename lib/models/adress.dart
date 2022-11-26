class Adress {
  String street;
  String number;
  String complement;
  String district;
  String city;
  String state;
  String zip;

  double latitude;
  double longitude;

  Adress({
    this.street,
    this.number,
    this.complement,
    this.district,
    this.city,
    this.state,
    this.zip,
    this.latitude,
    this.longitude,
  });

  Adress.fromMap(Map<String, dynamic> map) {
    street = map['street'] as String;
    number = map['number'] as String;
    complement = map['complement'] as String;
    district = map['district'] as String;
    city = map['city'] as String;
    state = map['state'] as String;
    zip = map['zip'] as String;
    latitude = map['lat'] as double;
    longitude = map['long'] as double;
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'city': city,
      'state': state,
      'zip': zip,
      'lat': latitude,
      'long': longitude,
    };
  }
}
