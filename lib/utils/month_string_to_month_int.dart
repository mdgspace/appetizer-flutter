int monthStringToMonthInt(String month) {
  switch (month) {
    case 'January':
      {
        return 1;
      }
      break;
    case 'February':
      {
        return 2;
      }
      break;
    case 'March':
      {
        return 3;
      }
      break;
    case 'April':
      {
        return 4;
      }
      break;
    case 'May':
      {
        return 5;
      }
      break;
    case 'June':
      {
        return 6;
      }
      break;
    case 'July':
      {
        return 7;
      }
      break;
    case 'August':
      {
        return 8;
      }
      break;
    case 'September':
      {
        return 9;
      }
      break;
    case 'October':
      {
        return 10;
      }
      break;
    case 'Novemver':
      {
        return 11;
      }
      break;
    case 'December':
      {
        return 12;
      }
      break;
    default:
      {
        return 0;
      }
      break;
  }
}
