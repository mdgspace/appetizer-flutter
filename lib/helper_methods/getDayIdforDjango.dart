int getDayId(DateTime dateTime) {
  switch (dateTime.weekday) {
    case 1:
      {
        return 2;
      }
      break;
    case 2:
      {
        return 3;
      }
      break;
    case 3:
      {
        return 4;
      }
      break;
    case 4:
      {
        return 5;
      }
      break;
    case 5:
      {
        return 6;
      }
      break;
    case 6:
      {
        return 7;
      }
      break;
    default:
      {
        return 1;
      }
      break;
  }
}
