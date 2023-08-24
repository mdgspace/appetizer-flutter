import 'package:appetizer/data/constants/api_endpoints.dart';
import 'package:appetizer/domain/models/appetizer_version.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/domain/models/feedback/feedback_response.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:dio/dio.dart' hide Headers;
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

  // TODO: add token to all headers
  // TODO: find a way to remove maps

  // Coupon API

  @POST(ApiEnpoints.coupon)
  Future<CouponStatus> applyForCoupon(
    @Body() Map<String, dynamic> map,
  );

  @PATCH(ApiEnpoints.couponWithId)
  Future<CouponStatus> cancelCoupon(
    @Path("couponId") String couponId,
    @Body() Map<String, dynamic> map,
  );

  // Feedback API

  @GET(ApiEnpoints.submittedFeedback)
  Future<List<AppetizerFeedback>> submittedFeedbacks();

  @GET(ApiEnpoints.responseOfFeedback)
  Future<List<FeedbackResponse>> responseOfFeedbacks();

  @POST(ApiEnpoints.newFeedback)
  Future<AppetizerFeedback> newFeedback(
    @Body() Map<String, dynamic> map,
  );

  
}
