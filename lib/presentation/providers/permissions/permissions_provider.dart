import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';


final permissionProvider = StateNotifierProvider<PermissionsNotifier,PermissionsState>((ref){
  return PermissionsNotifier();
});


class PermissionsNotifier extends StateNotifier<PermissionsState>{
  PermissionsNotifier(): super(PermissionsState()){
   checkPermissions();
  }
  bool _isRequestingPermissions = false;
  Future<void> checkPermissions() async{
      final permissionsArray = await Future.wait([
          Permission.camera.status,
          Permission.photos.status,
          Permission.sensors.status,
          Permission.sensorsAlways.status,

          Permission.location.status,
          Permission.locationAlways.status,
          Permission.locationWhenInUse.status,
      ]);
      state.copyWith(
      camera: permissionsArray[0],
      photolibrary:permissionsArray[1],
      sensors:permissionsArray[2],
      sensorsAlways:permissionsArray[3],
      location:permissionsArray[4],
      locationAlways:permissionsArray[5],
      locationWhenInUse:permissionsArray[6],
      );
  }
openSettingsSceen(){
  openAppSettings();
}

void _checkPermissionsStatus(PermissionStatus status){
  if(status == PermissionStatus.permanentlyDenied){
        openSettingsSceen();
      }
}

  Future<void> requestCameraAccess() async {
    final status = await Permission.camera.request();
      state = state.copyWith(camera: status);
      _checkPermissionsStatus(status);
  }

 Future<void> requestPhotoLibraryAccess() async {
    if (_isRequestingPermissions) {
      return;
    }
    _isRequestingPermissions = true;

    try {
      if (Platform.isAndroid) {
        final androidVersion = await getAndroidVersion();
        if (androidVersion != null) {
          if (androidVersion >= 34) { // UPSIDE_DOWN_CAKE
            await [
              Permission.photos,
              Permission.videos,
              Permission.mediaLibrary
            ].request();
          } else if (androidVersion >= 33) { // TIRAMISU
            await [
              Permission.photos,
              Permission.videos
            ].request();
          } else {// android <= 12 
            await Permission.storage.request();
          }
        }
      } else if (Platform.isIOS) {
        await Permission.photos.request();
      }
    } finally {
      _isRequestingPermissions = false;
        if (Platform.isAndroid) {
        final androidVersion = await getAndroidVersion();
        //android inferior a 12
        if (androidVersion!= null && androidVersion <= 32) {
          final status = await Permission.storage.status;
          state = state.copyWith(photolibrary: status);
          _checkPermissionsStatus(status);
        }else{
          //android superior a 12
          final status = await Permission.photos.status;
          state = state.copyWith(photolibrary: status);
           _checkPermissionsStatus(status);
        }
        }else if (Platform.isIOS) {
          //IOS
         final status =  await Permission.photos.status;
      state = state.copyWith(photolibrary: status);
       _checkPermissionsStatus(status);
    }
    }
  }

  Future<int?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt;
    }
    return null;
  }

  Future<void> requestSensorsAccess() async {
    final status = await Permission.sensors.request();
      state = state.copyWith(sensors: status);
      if(status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
  }

  Future<void> requestSensorsAlwaysAccess() async {
    final status = await Permission.sensorsAlways.request();
      state = state.copyWith(sensorsAlways: status);
      if(status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
  }

  Future<void> requestLocationAccess() async {
    final status = await Permission.location.request();
      state = state.copyWith(location: status);
      if(status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
  }

  Future<void> requestLocationWhenInUseAccess() async {
    final status = await Permission.locationWhenInUse.request();
      state = state.copyWith(locationWhenInUse: status);
      if(status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
  }

  Future<void> requestLocationAlwaysAccess() async {
    final status = await Permission.locationWhenInUse.request();
      state = state.copyWith(locationAlways: status);
      if(status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
  }
}



class PermissionsState{
  final PermissionStatus camera;
  final PermissionStatus photolibrary;
  final PermissionStatus sensors;
  final PermissionStatus sensorsAlways;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
     this.camera = PermissionStatus.denied, 
     this.photolibrary = PermissionStatus.denied, 
     this.sensors = PermissionStatus.denied, 
     this.sensorsAlways = PermissionStatus.denied, 
     this.location = PermissionStatus.denied, 
     this.locationAlways = PermissionStatus.denied, 
     this.locationWhenInUse = PermissionStatus.denied
    });

     get cameraGranted{
      return camera == PermissionStatus.granted;
     }     
     get photolibraryGranted{
      return photolibrary == PermissionStatus.granted;
     } 
     get sensorsGranted{
      return sensors == PermissionStatus.granted;
     } 
     get sensorsAlwaysGranted{
      return sensors == PermissionStatus.granted;
     } 
     get locationGranted{
      return location == PermissionStatus.granted;
     } 
     get locationAlwaysGranted{
      return locationAlways == PermissionStatus.granted;
     } 
     get locationWhenInUseGranted{
      return locationWhenInUse == PermissionStatus.granted;
     }

    PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photolibrary,
    PermissionStatus? sensors,
    PermissionStatus? sensorsAlways,

    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
    }) =>PermissionsState( 
      camera: camera ?? this.camera,
      photolibrary: photolibrary ?? this.photolibrary,
      sensors: sensors ?? this.sensors,
      sensorsAlways: sensorsAlways ?? this.sensorsAlways,
      location: location ?? this.location,
      locationAlways: locationAlways ?? this.locationAlways,
      locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
    );

}