String weekDayIntToWeekDayName(int day) {
  switch (day) {
    case 1:
      {
        return 'MON';
      }
      break;
    case 2:
      {
        return 'TUE';
      }
      break;
    case 3:
      {
        return "WED";
      }
      break;
    case 4:
      {
        return "THU";
      }
      break;
    case 5:
      {
        return "FRI";
      }
      break;
    case 6:
      {
        return "SAT";
      }
      break;
    case 7:
      return "SUN";
      break;
    default:
      {
        return "";
      }
      break;
  }
}