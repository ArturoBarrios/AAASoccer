import 'User.dart';
import 'Rating.dart';

class Coach {
  User? user;
  List<Rating>? ratings;

  Coach({
    this.user,
    this.ratings,
  });
}
