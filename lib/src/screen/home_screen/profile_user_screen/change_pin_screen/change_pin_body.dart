import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget changePinBodyWidget(
  BuildContext _context, ModelChangePin _modelChangePin,
  Function popScreen, Function onChanged, Function submitPin
){
  return Container(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    width: double.infinity,
    height: double.infinity,
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context,
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Change PIN", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded( /* Body Change Pin */
          child: Container(
          margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container( /* Old PIN */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                  _modelChangePin.formStateChangePin,
                  _context,
                  "Old PIN",
                  "",
                  "changePinScreen",
                  true,
                  4,
                  TextInputType.number,
                  TextInputAction.next,
                  _modelChangePin.controllerOldPin,
                  _modelChangePin.nodeOldPin,
                  validateInstance.validatePin, onChanged, null
                ),
              ),
              Container( /* New PIN */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                  _modelChangePin.formStateChangePin,
                  _context,
                  "New PIN",
                  "",
                  "changePinScreen",
                  true,
                  4,
                  TextInputType.number,
                  TextInputAction.next,
                  _modelChangePin.controllerNewPin,
                  _modelChangePin.nodeNewPin,
                  validateInstance.validatePin, onChanged, null
                ),
              ),
              Container( /* Old PIN */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                  _modelChangePin.formStateChangePin,
                  _context,
                  "Confirm PIN",
                  "",
                  "changePinScreen",
                  true,
                  4,
                  TextInputType.number,
                  TextInputAction.done,
                  _modelChangePin.controllerConfirmPin,
                  _modelChangePin.nodeConfirmPin,
                  validateInstance.validatePin, onChanged, null
                ),
              ),
              customFlatButton(
                _context,
                "Change Now",
                "changePinScreen",
                blueColor,
                FontWeight.normal,
                size18,
                EdgeInsets.only(top: 15.0),
                EdgeInsets.only(top: size15, bottom: size15),
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.54), blurRadius: 5.0),
                submitPin
              )
            ],
          ),
        ))
      ],
    ),
  );
}
