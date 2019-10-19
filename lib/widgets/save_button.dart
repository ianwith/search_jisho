import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

const Color iconColor = Color(0xFFFF5252);

class SaveButton extends StatelessWidget {
  final bool saved;
  final VoidCallback onPressed;

  SaveButton({
    this.saved,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: 10),
      onPressed: onPressed,
      child: saved
          ? Icon(CupertinoIcons.heart_solid, color: iconColor)
          : Icon(CupertinoIcons.heart),
    );
  }
}
