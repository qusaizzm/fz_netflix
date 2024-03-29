import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:fz_netflix/domain/core/api_end_points.dart';
import 'package:fz_netflix/domain/search/models/search_resp/search_resp.dart';
import 'package:fz_netflix/domain/core/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fz_netflix/domain/search/search_service.dart';

@LazySingleton(as: SearchService)
class SearchImpl extends SearchService {
  @override
  Future<Either<MainFailures, SearchResp>> searchMovies(
      {required String movieQuery}) async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {
          'query': movieQuery,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailures.serverFailure());
      }
    } catch (e) {
      return const Left(MainFailures.clientFailure());
    }
  }
}
