import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadgePlugin{

  static Future<bool> get isAviable{
    return FlutterAppBadger.isAppBadgeSupported();
  }

  static updateBadgeCount(int count) async{
  if(!await isAviable){
    print('badge no soportado');
    return;
  }

    FlutterAppBadger.updateBadgeCount(1);

    if(count == 0)  removeBadge();
  }

  static void removeBadge() async{
    if(!await isAviable){
    print('badge no soportado');
    return;
  }
    FlutterAppBadger.removeBadge();
  }
}