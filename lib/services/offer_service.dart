import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:waste_bank/models/offer_model.dart';
import 'package:waste_bank/services/api_client.dart';

/// Type alias for offer responses
typedef OfferResult = Either<String, OfferModel>;
typedef OffersListResult = Either<String, List<OfferModel>>;

class OfferService {
  final ApiClient _apiClient;

  OfferService(this._apiClient);

  /// Create a new offer (farmer posts waste/resource)
  Future<OfferResult> createOffer({
    required String title,
    required String category,
    required String description,
    required double quantity,
    required String unit,
    required double price,
    required String location,
    String? availableDate,
  }) async {
    try {
      final response = await _apiClient.post(
        '/offers',
        data: {
          'title': title,
          'category': category,
          'description': description,
          'quantity': quantity,
          'unit': unit,
          'price': price,
          'location': location,
          if (availableDate != null) 'available_date': availableDate,
        },
      );

      final offer = OfferModel.fromJson(response.data as Map<String, dynamic>);
      return Right(offer);
    } on DioException catch (e) {
      return Left(e.message ?? 'Failed to create offer. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Fetch all offers (with optional filters)
  Future<OffersListResult> getOffers({
    String? category,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _apiClient.get(
        '/offers',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final List<dynamic> offersData;
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        offersData = data['data'] as List<dynamic>? ??
            data['offers'] as List<dynamic>? ??
            [];
      } else if (response.data is List) {
        offersData = response.data as List<dynamic>;
      } else {
        offersData = [];
      }

      final offers = offersData
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(offers);
    } on DioException catch (e) {
      return Left(e.message ?? 'Failed to load offers.');
    } catch (e) {
      return Left('An unexpected error occurred.');
    }
  }

  /// Fetch a single offer by ID
  Future<OfferResult> getOffer(String id) async {
    try {
      final response = await _apiClient.get('/offers/$id');
      final offer = OfferModel.fromJson(response.data as Map<String, dynamic>);
      return Right(offer);
    } on DioException catch (e) {
      return Left(e.message ?? 'Failed to load offer.');
    } catch (e) {
      return Left('An unexpected error occurred.');
    }
  }
}
