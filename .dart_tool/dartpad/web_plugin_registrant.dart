// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

<<<<<<< HEAD
// ignore_for_file: type=lint

void registerPlugins() {}
=======
// @dart = 2.13
// ignore_for_file: type=lint

import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  ImagePickerPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
>>>>>>> 5fd5c52bf9a9751aabf71e1a9c621740c7720af1
