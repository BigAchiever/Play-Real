import 'package:flutter/material.dart';

import '../../config/theme/themedata.dart';
import 'grid_button.dart';

class GridSizeSelectionWidget extends StatefulWidget {
  final ValueChanged<int> onGridSizeChanged;

  const GridSizeSelectionWidget({super.key, required this.onGridSizeChanged});
  @override
  _GridSizeSelectionWidgetState createState() =>
      _GridSizeSelectionWidgetState();
}

class _GridSizeSelectionWidgetState extends State<GridSizeSelectionWidget> {
  int selectedGridSize = 7;

  void _selectGridSize(int gridSize) async {
    setState(() {
      selectedGridSize = gridSize;
    });
    widget.onGridSizeChanged(gridSize); // Call the callback function
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grid Size:',
          style: TextStyle(
            fontSize: 16,
            fontFamily: "GameFont",
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GridSizeButton(
              size: 7,
              isSelected: selectedGridSize == 7,
              onChanged: _selectGridSize,
            ),
            SizedBox(width: 8),
            GridSizeButton(
              size: 10,
              isSelected: selectedGridSize == 10,
              onChanged: _selectGridSize,
            ),
          ],
        ),
      ],
    );
  }
}
