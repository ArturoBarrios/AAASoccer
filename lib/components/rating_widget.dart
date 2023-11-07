import 'package:flutter/material.dart';
import '../styles/colors.dart'; // Make sure this import points to your colors file

class RatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating = 5;
  final int totalRatings; // New field for the total number of ratings

  RatingWidget({
    Key? key,
    required this.rating,
    this.totalRatings = 12, // Default total ratings is 5
  }) : super(key: key) {
    assert(rating >= 0 && rating <= maxRating, 'Rating must be between 0 and maxRating');
  }

  @override
  Widget build(BuildContext context) {
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

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rating Widget Example'),
        ),
        body: Center(
          // Example usage of the RatingWidget with 3 out of 5 stars and total ratings of 123
          child: RatingWidget(rating: 3, totalRatings: 123),
        ),
      ),
    ),
  );
}
