import 'package:flutter/material.dart';

import '../enums/rsv_status.dart';

class RSVPWidget extends StatelessWidget {
  final Function(RsvStatus)? onTap;
  final RsvStatus? currentRsvStatus;
  const RSVPWidget({
    Key? key,
    this.onTap,
    this.currentRsvStatus,
  }) : super(key: key);

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
                onTap: () => onTap?.call(RsvStatus.yes),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: currentRsvStatus == RsvStatus.yes
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
                onTap: () => onTap?.call(RsvStatus.no),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: currentRsvStatus == RsvStatus.no
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
                onTap: () => onTap?.call(RsvStatus.maybe),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: currentRsvStatus == RsvStatus.maybe
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
