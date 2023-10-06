import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SelectableIconGrid extends StatefulWidget {
  final List<Svg> svgs;

  SelectableIconGrid({required this.svgs});

  @override
  _SelectableIconGridState createState() => _SelectableIconGridState();
}

class _SelectableIconGridState extends State<SelectableIconGrid> {
  List<bool> selectedIcons = List.generate(9, (index) => false);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.svgs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIcons[index] = !selectedIcons[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: selectedIcons[index]
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.all(color: Colors.transparent, width: 0),
            ),
            child: Center(
              child: ColorFiltered(
                colorFilter: selectedIcons[index]
                    ? ColorFilter.mode(
                        Colors.blue, BlendMode.modulate)
                    : ColorFilter.mode(
                        Colors.transparent, BlendMode.dst),
                child: Image(
                            width: 20,
                            height: 20,
                            image: widget.svgs[index],
                            color: Colors.white,
                          ),
              ),
            ),
          ),
        );
      },
    );
  }
}
