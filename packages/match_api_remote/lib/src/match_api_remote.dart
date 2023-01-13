import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:match_api/match_api.dart';

/// {@template match_api_remote}
/// Match API remote connection
/// {@endtemplate}
class MatchApiRemote implements IMatchApiRemote {
  /// {@macro match_api_remote}
  const MatchApiRemote({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  final Dio _httpClient;

  @override
  Future<List<Match>> getMatchesOfTheDay(Map<String, dynamic> params) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/v4/matches',
        queryParameters: params,
      );

      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();
      if (response.data?['matches'] == null) return [];

      final matchesJson = response.data?['matches'] as List<dynamic>;
      final matches = matchesJson
          .map(
            (json) => Match.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return matches;
    } on DioError catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception(e);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  @override
  Future<List<League>> getAvailableLeagues() async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/v4/competitions',
      );

      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();
      if (response.data?['competitions'] == null) return [];

      final leaguesJson = response.data?['competitions'] as List<dynamic>;
      final leagues = leaguesJson
          .map(
            (json) => League.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return leagues;
    } on DioError catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception(e);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}
