import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sukoon/Const/constant.dart';

class AdvancedCustomAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        //overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 260,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  const Text(
                    "Device is Not Conected",
                    style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Reload',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 60,
              child: Icon(
                Icons.assistant_photo,
                size: 50,
                color: Colors.white,
              ),
            ),
            top: -60,
          )
        ],
      ),
    );
  }
}
