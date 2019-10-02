import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:spn_flutter/models/orsresponse.dart';
import 'package:spn_flutter/services/base_route_service.dart';
import 'package:spn_flutter/services/openroute/openroute_api_client.dart';

class OpenRouteService extends BaseRouteAPIService<OrsResponse> {
  final String apiUrl =
      'https://api.openrouteservice.org/v2/directions/foot-walking';
  final String apiKey =
      '5b3ce3597851110001cf62489d3b6706de0147a18ffc79c553a45cd6';
  http.Client client;

  OpenRouteService() {
    client = OpenRouteApiClient(apiKey);
  }

  @override
  Future<OrsResponse> getRoute(points) async {
    var body = {"coordinates": points};
    var response = await client.post(apiUrl, body: json.encode(body));
    var responseBody = utf8.decode(response.bodyBytes);
    return OrsResponse.fromJson(json.decode(responseBody));
  }
}
