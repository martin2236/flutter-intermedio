
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin{

 static final LocalAuthentication auth = LocalAuthentication();

  

static Future<bool> canCheckBiometrics() async{
  return await auth.canCheckBiometrics;
}

static Future<(bool,String)> authenticate() async{
  try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Debe autenticarse antes de continuar',
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            biometricOnly: false
            ));
            return(didAuthenticate, didAuthenticate ? 'Hecho' : 'Cancelado por el usuario');
  } on PlatformException catch (e) {
    print(e);
    if(e.code == auth_error.notEnrolled) return(false,'No se encontraron sensores biometricos enrolados');
    if(e.code == auth_error.lockedOut) return(false,'Demasiados intentos an usar los sensores biometricos');
    if(e.code == auth_error.notAvailable) return(false,'No se encontraron sensores biometricos en el dispositivo');
    if(e.code == auth_error.otherOperatingSystem) return(false,'El sistema operativo detectado no es soportado');
    if(e.code == auth_error.passcodeNotSet) return(false,'No hay un pin configurado');
    if(e.code == auth_error.permanentlyLockedOut) return(false,'Se requiere desbloquear el telefono');
    if(e.code == auth_error.biometricOnlyNotSupported) return(false,'no se puede acceder en windows');

    return (false,'$e');
      
  }
}
}