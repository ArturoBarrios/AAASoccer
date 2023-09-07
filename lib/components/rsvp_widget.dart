import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/user_command.dart';
import '../models/enums/RsvpStatus.dart';

class RSVPWidget extends StatefulWidget {        
    final dynamic? event;
    final List? userParticipants;
    const RSVPWidget({
      Key? key,            
      required this.event,
      required this.userParticipants,
    }) : super(key: key);

    @override
    State<RSVPWidget> createState() => _RSVPWidgetState();
  }
  class _RSVPWidgetState extends State<RSVPWidget> {    
      RsvpStatus? currentRsvpStatus;


  
    Future<void> updateRsvp(RsvpStatus rsvpStatus) async {
      dynamic appModelUser = UserCommand().getAppModelUser();

      final participantId = UserCommand().getParticipantIdByUserId(
          widget.event['userParticipants']['data'],
          appModelUser['_id']);

      Map<String, dynamic> input = {
        "participantId": participantId['_id'],
        "eventId": widget.event['_id'],
        "userId": appModelUser['_id'],
        "isAttending": rsvpStatus.name.toUpperCase(),
      };
      final result = await EventCommand().updateEventUserParticipantRsv(input);
      if (result['data'] != null) {
        setState(() {
          currentRsvpStatus = rsvpStatus;
          widget.event['userParticipants']['data'] =
              result['data'];
          // widget.userParticipants = result['data'];
          // BaseCommand().updateUserEventDetailsModel(widget.userObjectDetails);
        });
      }
    }

    loadInitialData(){
      currentRsvpStatus = RsvpStatus.maybe;
    }

    @override
    initState(){
      super.initState();
      loadInitialData();
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          const Text("Will you attend this event"),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => updateRsvp?.call(RsvpStatus.yes),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: currentRsvpStatus == RsvpStatus.yes
                          ? Colors.grey.shade400
                          : Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text("Yes"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => updateRsvp?.call(RsvpStatus.no),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: currentRsvpStatus == RsvpStatus.no
                          ? Colors.grey.shade400
                          : Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text("No"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => updateRsvp?.call(RsvpStatus.maybe),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: currentRsvpStatus == RsvpStatus.maybe
                          ? Colors.grey.shade400
                          : Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text("Maybe"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
        ],
      );
    }
  }
