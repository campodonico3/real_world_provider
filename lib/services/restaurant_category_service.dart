/*
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:real_world_provider/core/api/api_config.dart';
import 'package:real_world_provider/core/api/api_endpoints.dart';
import 'package:real_world_provider/models/restaurant_category_model.dart';

import '../core/api/api_response.dart';
import '../core/utils/api_exception_handler.dart';

class RestaurantCategoryService {
  static Future<ApiResponse<List<RestaurantCategoryModel>>>
  getCategories() async {
    debugPrint('\n🔵 ===== OBTAINING CATEGORIES =====');
    debugPrint(
      '🌐 URL: ${ApiEndpoints.getUrl(ApiEndpoints.restaurantCategories)}',
    );
    try {
      debugPrint('⏳ Sending request...');

      final response = await http
          .get(
            Uri.parse(ApiEndpoints.getUrl(ApiEndpoints.restaurantCategories)),
            headers: ApiConfig.headers,
          )
          .timeout(
            ApiConfig.requestTimeout,
            onTimeout: () => throw ApiExceptionHandler.handleTimeout(),
          );

      debugPrint('📨 Response received!');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📄 Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        debugPrint('✅ Parsing ${data.length} categories..');
        final categories = data.map((json) => RestaurantCategoryModel.fromJson(json),).toList();
        debugPrint('✅ ${categories.length} categories loaded successfully');
        return ApiResponse.success(categories);
      } else {
        final Map<String, dynamic>? errorData = jsonDecode(response.body);
        return ApiResponse.error(
          errorData?['message'] ??
              errorData?['error'] ??
              'Error getting categories',
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiExceptionHandler.handleError(e);
    }
  }
}*/
