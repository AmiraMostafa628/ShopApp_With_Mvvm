import 'package:clean_architecture/app/constants.dart';

extension NunNullString on String?
{
  String orEmpty()
  {
    if(this == null)
      {
        return Constants.empty;
      }
    else
      {
        return this!;
      }
  }
}

extension NunNullInteger on int?
{
  int orZero()
  {
    if(this == null)
    {
      return Constants.zero;
    }
    else
    {
      return this!;
    }
  }
}