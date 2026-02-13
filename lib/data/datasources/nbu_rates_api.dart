import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/data/datasources/api_config.dart';
import 'package:test_project_kiojuprivat/app/helper/date_formatter.dart';

class NbuRatesApi {
  NbuRatesApi(this._dio);

  final Dio _dio;

  Future<List<Map<String, dynamic>>> fetchRatesRaw() async {
    try {
      final today = DateFormatter.formatDate(DateTime.now());
      final response = await _dio.get<List<dynamic>>(
        ApiConfig.exchangeUrl,
        queryParameters: <String, dynamic>{
          'start': today,
          'end': today,
          if (!ApiConfig.isWeb) 'json': '',
        },
      );
      final data = response.data;

      if (data == null) throw StateError('Response body is null');

      return data.cast<Map<String, dynamic>>();
    } catch (e, s) {
      debugPrint('fetchRatesRaw failed: $e\n$s');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchRatesForRange({
    required String valcode,
    required String start,
    required String end,
  }) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        ApiConfig.exchangeUrl,
        queryParameters: <String, dynamic>{
          'start': start,
          'end': end,
          'valcode': valcode,
          'sort': 'exchangedate',
          'order': 'asc',
          if (!ApiConfig.isWeb) 'json': '',
        },
      );
      final data = response.data;
      if (data == null) {
        throw StateError('Response body is null');
      }
      return data.cast<Map<String, dynamic>>();
    } catch (e, s) {
      debugPrint('fetchRatesForRange failed: $e\n$s');
      rethrow;
    }
  }
}
