import 'package:dartz/dartz.dart';
import 'package:fz_netflix/domain/core/failures/main_failures.dart';
import 'package:fz_netflix/domain/search/models/search_resp/search_resp.dart';

abstract class SearchService {
  Future<Either<MainFailures, SearchResp>> searchMovies({
    required String movieQuery,
  });
}
