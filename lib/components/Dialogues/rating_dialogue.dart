import 'package:flutter/material.dart';

import '../../commands/rating_command.dart';
import '../../styles/colors.dart';

class RatingDialogue extends StatefulWidget {
  const RatingDialogue({Key? key, 
    required this.ratingInput
  }) : super(key: key);

  final ratingInput;

  @override
  _RatingDialogueState createState() => _RatingDialogueState();
}

class _RatingDialogueState extends State<RatingDialogue> {
  int _gameRating = 4;
  int _hostRating = 4;
  int _locationRating = 4;

  TextEditingController _gameFeedbackController = TextEditingController(text: "");
  TextEditingController _hostFeedbackController = TextEditingController(text: "");
  TextEditingController _locationFeedbackController = TextEditingController(text: "");

  Widget _buildStarRow(int ratingValue, Function(int) onRatingSelected) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () => onRatingSelected(index + 1),
          icon: Icon(
            index < ratingValue ? Icons.star : Icons.star_border,
            color: AppColors.tsnGreen,
          ),
        );
      }),
    );
  }



  createEventRating(){   
    
  

    dynamic eventRatingInput = {
      "eventRating": _gameRating,
      "hostRating": _hostRating,
      "fieldLocationRating": _locationRating,      
      "eventFeedback": _gameFeedbackController.text,
      "hostFeedback": _hostFeedbackController.text,
      "fieldLocationFeedback": _locationFeedbackController.text,
      "eventId": widget.ratingInput['eventId'],
      "userId": widget.ratingInput['userId'],
      "fieldLocationId": widget.ratingInput['fieldLocationId'],

    };

    print("eventRatingInput: "+ eventRatingInput.toString());

    RatingCommand().createRatingForEvent(eventRatingInput);
  }

   @override
  void dispose() {
    // Don't forget to dispose of the controllers when the widget is disposed
    _gameFeedbackController.dispose();
    _hostFeedbackController.dispose();
    _locationFeedbackController.dispose();
    super.dispose();
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
              color: AppColors.tsnAlmostBlack,
            ),
          ),
          _buildStarRow(_gameRating, (rating) {
            setState(() {
              _gameRating = rating;
            });
          }),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Game feedback',
              border: OutlineInputBorder(),   
                         
            ),
            // Other TextField properties as needed
          ),
          const SizedBox(height: 16),
          Text(
            'Rate your host',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.tsnAlmostBlack,
            ),
          ),
          _buildStarRow(_hostRating, (rating) {
            setState(() {
              _hostRating = rating;
            });
          }),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Host feedback',
              border: OutlineInputBorder(),
            ),
            // Other TextField properties as needed
          ),
          const SizedBox(height: 16),
          Text(
            'Rate the location',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.tsnAlmostBlack,
            ),
          ),
          _buildStarRow(_locationRating, (rating) {
            setState(() {
              _locationRating = rating;
            });
          }),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Location feedback',
              border: OutlineInputBorder(),
            ),
            // Other TextField properties as needed
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('CANCEL', style: TextStyle(color: AppColors.tsnRed)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  createEventRating();
                  // Process the ratings
                  // Navigator.pop(context, {
                  //   'gameRating': _gameRating,
                  //   'hostRating': _hostRating,
                  //   'locationRating': _locationRating,
                  // });
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.tsnGreen,
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
