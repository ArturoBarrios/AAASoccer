import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils.dart';

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({Key? key, required this.testText, required this.events})
      : super(key: key);

  final String testText;
  final dynamic events;

  @override
  State<EventsCalendar> createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
 ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by long-pressing a date
  DateTime _focusedDay = DateTime.now();  
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  LinkedHashMap<DateTime, List<Event>> kEventsReal =
      LinkedHashMap<DateTime, List<Event>>();

  void loadInitialData(dynamic events) async {
    print("loadInitialData()");    
    dynamic eventsFromData = await getEventsFromData(events);
    setState(() {
      _focusedDay = DateTime.utc(_focusedDay.year, _focusedDay.month, _focusedDay.day);
      _selectedDay = _focusedDay;
      print("_selectedDay: "+_selectedDay.toString());
      kEventsReal = eventsFromData;
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
      print("kEventsReal: $kEventsReal");
       print("setState: "+_selectedEvents.toString());
      
    });
  }

  Future<LinkedHashMap<DateTime, List<Event>>> getEventsFromData(dynamic events) async {
    LinkedHashMap<DateTime, List<Event>> dateTimeLinkedHashMap =
        LinkedHashMap<DateTime, List<Event>>();
        print("getEventsFromData()");

    for (int i = 0; i < events.length; i++) {
      dynamic event = events[i];
      if(event['isMainEvent'] == false){
        print("niceeeeekjekjekjekjekjej");
        int millis = int.parse(event['endTime']); // Parse string to integer
        DateTime endTime = DateTime.fromMillisecondsSinceEpoch(millis);
        DateTime day = DateTime.utc(endTime.year, endTime.month, endTime.day);
        dateTimeLinkedHashMap.update(
            day, (value) => value..add(Event(event['name'])),
            ifAbsent: () => [Event(event['name'])]);

      }
    }

    return dateTimeLinkedHashMap;
  }

  @override
  void initState() {    
    loadInitialData(widget.events);

  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEventsReal[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print("onDaySelected: "+selectedDay.toString());
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

@override
Widget build(BuildContext context) {
  if (kEventsReal.isEmpty) {
    return FutureBuilder<LinkedHashMap<DateTime, List<Event>>>(
      future: getEventsFromData(widget.events),
      builder: (BuildContext context, AsyncSnapshot<LinkedHashMap<DateTime, List<Event>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else {
            kEventsReal = snapshot.data!;
            _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
            return buildCalendarAndEvents();
          }
        }
      },
    );
  } else {
    return buildCalendarAndEvents();
  }
}

Widget buildCalendarAndEvents() {
  return Scaffold(
    body: Column(
      children: [
        TableCalendar<Event>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _calendarFormat,
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              print("_selectedEvents: "+_selectedEvents.toString());
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}


}
