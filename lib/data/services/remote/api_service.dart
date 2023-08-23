import 'package:appetizer/data/constants/api_endpoints.dart';
import 'package:appetizer/domain/models/appetizer_version.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiEnpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiEnpoints.checkVersion)
  Future<AppetizerVersion> checkVersion(
    @Path("platform") String platform,
    @Path("versionNumber") String versionNumber,
  );
}
