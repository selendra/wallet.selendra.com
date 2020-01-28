import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelAsset {
  final formStateAsset = GlobalKey<FormState>();
  TextEditingController controllerAssetCode = TextEditingController(text: "");
  TextEditingController controllerIssuer = TextEditingController(text: "");

  FocusNode nodeAssetCode = FocusNode();
  FocusNode nodeIssuer = FocusNode();
}