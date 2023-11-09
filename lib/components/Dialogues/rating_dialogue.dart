import 'package:flutter/material.dart';

import '../../commands/rating_command.dart';

class RatingDialogue extends StatefulWidget {
  const RatingDialogue({Key? key}) : super(key: key);

  @override
  _RatingDialogueState createState() => _RatingDialogueState();
}

class _RatingDialogueState extends State<RatingDialogue> {
  int _gameRating = 4;
  int _hostRating = 4;
  int _locationRating = 4;

  Widget _buildStarRow(int ratingValue, Function(int) onRatingSelected) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () => onRatingSelected(index + 1),
          icon: Icon(
            index < ratingValue ? Icons.star : Icons.star_border,
            color: Colors.deepOrange,
          ),
        );
      }),
    );
  }

  createEventRating(){
    //EHL(Event, Host, Location)
    //5,5,5
    String ratings = "5,5,5";
    //EHF(Event, Host, Field)
    String ratingCategories = "E,H,F";
    String feedbacks = "{}";

    dynamic eventRatingInput = {
      "ratings": ratings,
      "ratingCategories": ratingCategories,
      "feedbacks": "test",
      "_id": "60f9b0b0c9b7c40015f1b0a0",

    };

    RatingCommand().createRatingForEvent(eventRatingInput);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Text(
                'Rate your game',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              _buildStarRow(_gameRating, (rating) {
                setState(() {
                  _gameRating = rating;
                });
              }),
              const SizedBox(height: 16),
              Text(
                'Rate your host',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              _buildStarRow(_hostRating, (rating) {
                setState(() {
                  _hostRating = rating;
                });
              }),
              const SizedBox(height: 16),
              Text(
                'Rate the location',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              _buildStarRow(_locationRating, (rating) {
                setState(() {
                  _locationRating = rating;
                });
              }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('CANCEL', style: TextStyle(color: Colors.deepOrange)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      createEventRating();
                      // Process the ratings
                    //   Navigator.pop(context, {
                    //     'gameRating': _gameRating,
                    //     'hostRating': _hostRating,
                    //     'locationRating': _locationRating,
                    //   });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
