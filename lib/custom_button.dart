import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget{

  final String buttonText;
  final bool isNumberButton;
  final Function onPressed;

  bool isPressed = false;
  double pressedPadding = 0;

  CustomButton(this.buttonText, this.isNumberButton, this.onPressed){}


  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>{

  @override
  Widget build(BuildContext context) {

    Color color = Theme.of(context).colorScheme.inversePrimary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12 + (widget.pressedPadding/2), horizontal: widget.isNumberButton ? 12 + (widget.pressedPadding/2) : 7 + (widget.pressedPadding/2)),
      child: GestureDetector(
        onTap:(){
          setState(() {});
          widget.onPressed(widget.buttonText);
        },
        onTapDown: (TapDownDetails a){
          setState(() {
            widget.isPressed = true;
            widget.pressedPadding = 2;
          });
        },
        onTapUp: (TapUpDetails a){
          setState(() {
            widget.isPressed = false;
            widget.pressedPadding = 0;
          });
        },
        child: Container(
          color: widget.isNumberButton
              ? Color.fromARGB(255, color.red, color.green, color.blue)
              : Color.fromARGB(255, color.red - 20, color.green - 20, color.blue - 20),
          height: 40 - widget.pressedPadding,
          width: widget.isNumberButton ? 40 - widget.pressedPadding : 50 - widget.pressedPadding,
          child: Center(
            child: Text(widget.buttonText, style: TextStyle(fontSize: 30)),
          ),
        ),
      ),
    );
  }

}
