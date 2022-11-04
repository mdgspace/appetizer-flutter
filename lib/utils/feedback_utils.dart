class FeedbackUtils {
  static String? resolveFeedbackTypeCode(String? str) {
    switch (str) {
      case null:
        return null;
      case 'gn':
        return 'General';
      case 'am':
        return 'Ambience';
      case 'hc':
        return 'Hygiene and Cleanliness';
      case 'tm':
        return 'Mess Timings';
      case 'wm':
        return 'Weekly Menu';
      case 'ws':
        return 'Worker and Services';
      case 'dn':
        return 'Diet and Nutrition';
      default:
        return 'General';
    }
  }
}
