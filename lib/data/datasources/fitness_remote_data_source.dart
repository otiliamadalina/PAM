import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  const ApiException(this.statusCode);
  final int statusCode;

  @override
  String toString() => 'The server returned HTTP $statusCode.';
}

class InvalidApiResponseException implements Exception {
  const InvalidApiResponseException();
}

class FitnessRemoteDataSource {
  FitnessRemoteDataSource({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _feedUrl =
      'https://test-api-jlbn.onrender.com/lab2026/v3/feed';
  static const _detailsUrl =
      'https://test-api-jlbn.onrender.com/lab2026/v3/feed/details';

  Future<Map<String, dynamic>> fetchFeed() => _fetchJson(_feedUrl);
  Future<Map<String, dynamic>> fetchDetails() => _fetchJson(_detailsUrl);

  Future<Map<String, dynamic>> _fetchJson(String url) async {
    final response = await _client
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode);
    }
    late final dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException {
      throw const InvalidApiResponseException();
    }
    if (decoded is! Map<String, dynamic>) {
      throw const InvalidApiResponseException();
    }
    return decoded;
  }
}
