// To parse this JSON data, do
//
//     final orsResponse = orsResponseFromJson(jsonString);

import 'dart:convert';

OrsResponse orsResponseFromJson(String str) => OrsResponse.fromJson(json.decode(str));

String orsResponseToJson(OrsResponse data) => json.encode(data.toJson());

class OrsResponse {
  List<Route> routes;
  List<double> bbox;
  Metadata metadata;

  OrsResponse({
    this.routes,
    this.bbox,
    this.metadata,
  });

  factory OrsResponse.fromJson(Map<String, dynamic> json) => new OrsResponse(
    routes: new List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    bbox: new List<double>.from(json["bbox"].map((x) => x.toDouble())),
    metadata: Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "routes": new List<dynamic>.from(routes.map((x) => x.toJson())),
    "bbox": new List<dynamic>.from(bbox.map((x) => x)),
    "metadata": metadata.toJson(),
  };
}

class Metadata {
  String attribution;
  String service;
  int timestamp;
  Query query;
  Engine engine;

  Metadata({
    this.attribution,
    this.service,
    this.timestamp,
    this.query,
    this.engine,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => new Metadata(
    attribution: json["attribution"],
    service: json["service"],
    timestamp: json["timestamp"],
    query: Query.fromJson(json["query"]),
    engine: Engine.fromJson(json["engine"]),
  );

  Map<String, dynamic> toJson() => {
    "attribution": attribution,
    "service": service,
    "timestamp": timestamp,
    "query": query.toJson(),
    "engine": engine.toJson(),
  };
}

class Engine {
  String version;
  DateTime buildDate;

  Engine({
    this.version,
    this.buildDate,
  });

  factory Engine.fromJson(Map<String, dynamic> json) => new Engine(
    version: json["version"],
    buildDate: DateTime.parse(json["build_date"]),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "build_date": buildDate.toIso8601String(),
  };
}

class Query {
  List<List<double>> coordinates;
  String profile;
  String format;

  Query({
    this.coordinates,
    this.profile,
    this.format,
  });

  factory Query.fromJson(Map<String, dynamic> json) => new Query(
    coordinates: new List<List<double>>.from(json["coordinates"].map((x) => new List<double>.from(x.map((x) => x.toDouble())))),
    profile: json["profile"],
    format: json["format"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": new List<dynamic>.from(coordinates.map((x) => new List<dynamic>.from(x.map((x) => x)))),
    "profile": profile,
    "format": format,
  };
}

class Route {
  Summary summary;
  List<Segment> segments;
  List<double> bbox;
  String geometry;
  List<int> wayPoints;

  Route({
    this.summary,
    this.segments,
    this.bbox,
    this.geometry,
    this.wayPoints,
  });

  factory Route.fromJson(Map<String, dynamic> json) => new Route(
    summary: Summary.fromJson(json["summary"]),
    segments: new List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
    bbox: new List<double>.from(json["bbox"].map((x) => x.toDouble())),
    geometry: json["geometry"],
    wayPoints: new List<int>.from(json["way_points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "segments": new List<dynamic>.from(segments.map((x) => x.toJson())),
    "bbox": new List<dynamic>.from(bbox.map((x) => x)),
    "geometry": geometry,
    "way_points": new List<dynamic>.from(wayPoints.map((x) => x)),
  };
}

class Segment {
  double distance;
  double duration;
  List<Step> steps;

  Segment({
    this.distance,
    this.duration,
    this.steps,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => new Segment(
    distance: json["distance"].toDouble(),
    duration: json["duration"].toDouble(),
    steps: new List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
    "steps": new List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}

class Step {
  double distance;
  double duration;
  int type;
  String instruction;
  String name;
  List<int> wayPoints;

  Step({
    this.distance,
    this.duration,
    this.type,
    this.instruction,
    this.name,
    this.wayPoints,
  });

  factory Step.fromJson(Map<String, dynamic> json) => new Step(
    distance: json["distance"].toDouble(),
    duration: json["duration"].toDouble(),
    type: json["type"],
    instruction: json["instruction"],
    name: json["name"],
    wayPoints: new List<int>.from(json["way_points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
    "type": type,
    "instruction": instruction,
    "name": name,
    "way_points": new List<dynamic>.from(wayPoints.map((x) => x)),
  };
}

class Summary {
  double distance;
  double duration;

  Summary({
    this.distance,
    this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => new Summary(
    distance: json["distance"].toDouble(),
    duration: json["duration"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
  };
}
