import 'package:flutter/material.dart';
import '../styles/colors.dart'; // Make sure this import points to your colors file

class RatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating = 5;
  final int totalRatings;

  RatingWidget({
    Key? key,
    required this.rating,
    this.totalRatings = 12, // Default total ratings is 5
  }) : super(key: key) {
    assert(rating >= -1 && rating <= maxRating, 'Rating must be between -1 and maxRating');
  }

  @override
  Widget build(BuildContext context) {
    // Check if the rating is -1 to display "No Ratings"
    // if (rating == -1) {
    //   // return Text('!!!!No Ratings!!!!', style: TextStyle(color: AppColors.tsnGreen));
    //   return Text('', style: TextStyle(color: AppColors.tsnGreen));
    // }

    return InkWell(
      onTap: () {
        print('Star row pressed with rating: $rating');
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(maxRating, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              size:12,
              color: index < rating ? AppColors.tsnGreen : AppColors.tsnGrey,
            );
          }),
          SizedBox(width: 4), // Add some space between stars and the text
          Text('($totalRatings)', style: TextStyle(color: AppColors.tsnLightGreen)), // Display the total number of ratings
        ],
      ),
    );
  }
}


