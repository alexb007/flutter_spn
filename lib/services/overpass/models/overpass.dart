import 'dart:convert';

OverpassResponse overpassResponseFromJson(String str) => OverpassResponse.fromJson(json.decode(str));

String overpassResponseToJson(OverpassResponse data) => json.encode(data.toJson());

class OverpassResponse {
  double version;
  String generator;
  Osm3S osm3S;
  List<Element> elements;

  OverpassResponse({
    this.version,
    this.generator,
    this.osm3S,
    this.elements,
  });

  factory OverpassResponse.fromJson(Map<String, dynamic> json) => new OverpassResponse(
    version: json["version"].toDouble(),
    generator: json["generator"],
    osm3S: Osm3S.fromJson(json["osm3s"]),
    elements: new List<Element>.from(json["elements"].map((x) => Element.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "generator": generator,
    "osm3s": osm3S.toJson(),
    "elements": new List<dynamic>.from(elements.map((x) => x.toJson())),
  };
}

class Element {
  Type type;
  int id;
  double lat;
  double lon;
  Tags tags;
  List<int> nodes;

  Element({
    this.type,
    this.id,
    this.lat,
    this.lon,
    this.tags,
    this.nodes,
  });

  factory Element.fromJson(Map<String, dynamic> json) => new Element(
    type: typeValues.map[json["type"]],
    id: json["id"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    tags: json["tags"] == null ? null : Tags.fromJson(json["tags"]),
    nodes: json["nodes"] == null ? null : new List<int>.from(json["nodes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "id": id,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
    "tags": tags == null ? null : tags.toJson(),
    "nodes": nodes == null ? null : new List<dynamic>.from(nodes.map((x) => x)),
  };
}

class Tags {
  AddrCity addrCity;
  String addrCountry;
  String addrHousenumber;
  String addrPostcode;
  String addrStreet;
  String amenity;
  String cuisine;
  String name;
  String tagsOperator;
  String phone;
  String refVatin;
  String shop;
  String email;
  String website;
  String paymentBitcoin;
  String description;
  String openingHours;
  String serviceBicycleRental;
  String nameIt;
  String delivery;
  String nameRu;
  String building;
  String source;

  Tags({
    this.addrCity,
    this.addrCountry,
    this.addrHousenumber,
    this.addrPostcode,
    this.addrStreet,
    this.amenity,
    this.cuisine,
    this.name,
    this.tagsOperator,
    this.phone,
    this.refVatin,
    this.shop,
    this.email,
    this.website,
    this.paymentBitcoin,
    this.description,
    this.openingHours,
    this.serviceBicycleRental,
    this.nameIt,
    this.delivery,
    this.nameRu,
    this.building,
    this.source,
  });

  factory Tags.fromJson(Map<String, dynamic> json) => new Tags(
    addrCity: json["addr:city"] == null ? null : addrCityValues.map[json["addr:city"]],
    addrCountry: json["addr:country"] == null ? null : json["addr:country"],
    addrHousenumber: json["addr:housenumber"] == null ? null : json["addr:housenumber"],
    addrPostcode: json["addr:postcode"] == null ? null : json["addr:postcode"],
    addrStreet: json["addr:street"] == null ? null : json["addr:street"],
    amenity: json["amenity"] == null ? null : json["amenity"],
    cuisine: json["cuisine"] == null ? null : json["cuisine"],
    name: json["name"] == null ? null : json["name"],
    tagsOperator: json["operator"] == null ? null : json["operator"],
    phone: json["phone"] == null ? null : json["phone"],
    refVatin: json["ref:vatin"] == null ? null : json["ref:vatin"],
    shop: json["shop"],
    email: json["email"] == null ? null : json["email"],
    website: json["website"] == null ? null : json["website"],
    paymentBitcoin: json["payment:bitcoin"] == null ? null : json["payment:bitcoin"],
    description: json["description"] == null ? null : json["description"],
    openingHours: json["opening_hours"] == null ? null : json["opening_hours"],
    serviceBicycleRental: json["service:bicycle:rental"] == null ? null : json["service:bicycle:rental"],
    nameIt: json["name:it"] == null ? null : json["name:it"],
    delivery: json["delivery"] == null ? null : json["delivery"],
    nameRu: json["name:ru"] == null ? null : json["name:ru"],
    building: json["building"] == null ? null : json["building"],
    source: json["source"] == null ? null : json["source"],
  );

  Map<String, dynamic> toJson() => {
    "addr:city": addrCity == null ? null : addrCityValues.reverse[addrCity],
    "addr:country": addrCountry == null ? null : addrCountry,
    "addr:housenumber": addrHousenumber == null ? null : addrHousenumber,
    "addr:postcode": addrPostcode == null ? null : addrPostcode,
    "addr:street": addrStreet == null ? null : addrStreet,
    "amenity": amenity == null ? null : amenity,
    "cuisine": cuisine == null ? null : cuisine,
    "name": name == null ? null : name,
    "operator": tagsOperator == null ? null : tagsOperator,
    "phone": phone == null ? null : phone,
    "ref:vatin": refVatin == null ? null : refVatin,
    "shop": shop,
    "email": email == null ? null : email,
    "website": website == null ? null : website,
    "payment:bitcoin": paymentBitcoin == null ? null : paymentBitcoin,
    "description": description == null ? null : description,
    "opening_hours": openingHours == null ? null : openingHours,
    "service:bicycle:rental": serviceBicycleRental == null ? null : serviceBicycleRental,
    "name:it": nameIt == null ? null : nameIt,
    "delivery": delivery == null ? null : delivery,
    "name:ru": nameRu == null ? null : nameRu,
    "building": building == null ? null : building,
    "source": source == null ? null : source,
  };
}

enum AddrCity { ROMA }

final addrCityValues = new EnumValues({
  "Roma": AddrCity.ROMA
});

enum Type { NODE, WAY, ME }

final typeValues = new EnumValues({
  "node": Type.NODE,
  "way": Type.WAY,
  "me": Type.ME
});

class Osm3S {
  DateTime timestampOsmBase;
  String copyright;

  Osm3S({
    this.timestampOsmBase,
    this.copyright,
  });

  factory Osm3S.fromJson(Map<String, dynamic> json) => new Osm3S(
    timestampOsmBase: DateTime.parse(json["timestamp_osm_base"]),
    copyright: json["copyright"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp_osm_base": timestampOsmBase.toIso8601String(),
    "copyright": copyright,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
