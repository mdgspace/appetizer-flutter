String weekDayIntToString(int day) {
  switch (day) {
    case 1:
      {
        return 'M';
      }
      break;
    case 2:
      {
        return 'T';
      }
      break;
    case 3:
      {
        return "W";
      }
      break;
    case 4:
      {
        return "T";
      }
      break;
    case 5:
      {
        return "F";
      }
      break;
    case 6:
      {
        return "S";
      }
      break;
    case 7:
      return "S";
      break;
    default:
      {
        return "";
      }
      break;
  }
}
