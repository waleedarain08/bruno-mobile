import 'package:brunos_kitchen/services/api_base_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

Future<GoogleGeocodingResult?> convertCoordinatesToPlaces({
  required double latitude,
  required double longitude,
}) async {
  final api = GoogleGeocodingApi(kGoogleApiKey, isLogged: kDebugMode);
  final result = await api.reverse('$latitude,$longitude');
  return result.results.firstOrNull;
  // List<Placemark> placeMarks = await placemarkFromCoordinates(
  //     latitude, longitude);
  // return placeMarks.first;
}
