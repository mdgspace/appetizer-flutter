import 'package:appetizer/data/constants/api_endpoints.dart';
import 'package:appetizer/domain/models/appetizer_version.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/domain/models/feedback/feedback_response.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/domain/models/transaction/faq.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/domain/models/user/notification.dart';
import 'package:appetizer/domain/models/user/oauth_user.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'dart:async';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiEndpoints.checkVersion)
  Future<AppetizerVersion> checkVersion(
    @Path("platform") String platform,
    @Path("versionNumber") String versionNumber,
  );

  // TODO: find a way to remove maps

  // Coupon API

  @POST(ApiEndpoints.coupon)
  Future<CouponStatus> applyForCoupon(
    @Body() Map<String, dynamic> map,
  );

  @PATCH(ApiEndpoints.couponWithId)
  Future<CouponStatus> cancelCoupon(
    @Path("couponId") String couponId,
    @Body() Map<String, dynamic> map,
  );

  @GET(ApiEndpoints.allCoupons)
  Future<List<Coupon>> getAllCoupon();

  // Feedback API

  @GET(ApiEndpoints.submittedFeedback)
  Future<List<AppetizerFeedback>> submittedFeedbacks();

  @GET(ApiEndpoints.responseOfFeedback)
  Future<List<FeedbackResponse>> responseOfFeedbacks();

  @POST(ApiEndpoints.newFeedback)
  Future<AppetizerFeedback> newFeedback(
    @Body() Map<String, dynamic> map,
  );

  // Leave API

  @GET(ApiEndpoints.remainingLeaves)
  Future<int> remainingLeaves();

  @GET(ApiEndpoints.getLeaves)
  Future<PaginatedLeaves> getLeaves(
    @Query("year") int year,
    @Query("month") int month,
  );

  @GET(ApiEndpoints.getLeaves)
  Future<PaginatedLeaves> getLeavesForYear(
    @Query("year") int year,
  );

  @POST(ApiEndpoints.check)
  Future<bool> check(
    @Body() Map<String, dynamic> map,
  );

  @POST(ApiEndpoints.leave)
  Future leave(
    @Body() Map<String, dynamic> map,
  );

  @DELETE(ApiEndpoints.cancelLeave)
  Future cancelLeave(
    @Path("id") int id,
  );

  // Menu API

  @GET(ApiEndpoints.weekMenuMultimessing)
  Future<WeekMenu> weekMenuMultimessing(
    @Query("hostel") String hostelCode,
    @Query("week_id") int week,
  );

  @GET(ApiEndpoints.weekMenuForYourMeals)
  Future<WeekMenu> weekMenuForYourMeals(
    @Query("week_id") int week,
  );

  @GET(ApiEndpoints.weekMenu)
  Future<WeekMenu> weekMenuByWeekId(
    @Query("week_id") int week,
  );

  @GET(ApiEndpoints.weekMenu)
  Future<WeekMenu> currentWeekMenu();

  @GET(ApiEndpoints.dayMenu)
  Future<WeekMenu> dayMenu(
    @Path("week") int week,
    @Path("dayOfWeek") String dayOfWeek,
  );

  // TODO: add Multimessing API

  // Transaction API

  @GET(ApiEndpoints.monthlyRebate)
  Future<int> getMonthlyRebate();

  @GET(ApiEndpoints.yearlyRebate)
  Future<PaginatedYearlyRebate> getYearlyRebate(
    @Query("year") int year,
  );

  @GET(ApiEndpoints.faqs)
  Future<List<Faq>> getFAQs();

  // User API

  @POST(ApiEndpoints.status)
  Future<String> status(
    @Body() Map<String, dynamic> map,
  );

  @POST(ApiEndpoints.login)
  Future<User> login(
    @Body() Map<String, dynamic> map,
  );

  @POST(ApiEndpoints.logout)
  Future<void> logout();

  @GET(ApiEndpoints.user)
  Future<User> getCurrentUser();

  @PATCH(ApiEndpoints.user)
  Future<User> updateUser(
    @Body() User user,
  );

  @PATCH(ApiEndpoints.user)
  Future<User> updateFcmTokenForUser(
    @Body() Map<String, dynamic> map,
  );

  @PUT(ApiEndpoints.password)
  Future<void> changePassword(
    @Body() Map<String, dynamic> map,
  );

  @POST(ApiEndpoints.resetpassword)
  Future<void> resetPassword(
    @Body() Map<String, dynamic> map,
  );

  @GET(ApiEndpoints.oAuthRedirect)
  Future<OAuthUser> oAuthRedirect(
    @Query("code") String code,
  );

  @POST(ApiEndpoints.oAuthComplete)
  Future<OAuthUser> oAuthComplete(
    @Body() Map<String, dynamic> map,
  );

  @GET(ApiEndpoints.notifications)
  Future<List<Notification>> getNotifications();
}
