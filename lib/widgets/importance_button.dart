import 'package:flutter/material.dart';
import 'package:idea_note4/constants/sizes.dart';

class ImportanceButton extends StatelessWidget {
  const ImportanceButton({
    super.key,
    required this.selectedScore,
    required this.isClicked,
  });

  final int selectedScore;
  final bool isClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: isClicked ? Theme.of(context).primaryColor : Colors.black,
          ),
          borderRadius: BorderRadius.circular(Sizes.size10),
        ),
        color: isClicked ? Theme.of(context).primaryColor : Colors.white,
      ),
      alignment: Alignment.center,
      width: Sizes.size50,
      height: Sizes.size40,
      child: Text(
        selectedScore.toString(),
        style: TextStyle(
          color: isClicked ? Colors.white : Colors.black,
          fontSize: Sizes.size14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
