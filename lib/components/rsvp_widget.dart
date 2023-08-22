import 'package:flutter/material.dart';

class RSVPWidget extends StatefulWidget {
  final Function onRsvpStatusChanged;
  final String currentStatus;
  const RSVPWidget({
    Key? key,
    required this.onRsvpStatusChanged,
    required this.currentStatus,
  }) : super(key: key);

  @override
  State<RSVPWidget> createState() => _RSVPWidgetState();
}

class _RSVPWidgetState extends State<RSVPWidget> {
  late var selectedRsv = widget.currentStatus;
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
                onTap: () {
                  setState(() {
                    selectedRsv = "Yes";
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: selectedRsv == "Yes"
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
                onTap: () {
                  setState(() {
                    selectedRsv = "No";
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: selectedRsv == "No"
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
                onTap: () {
                  setState(() {
                    selectedRsv = "Maybe";
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: selectedRsv == "Maybe"
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
