// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:permissions/config/config.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref)async{
 return await LocalAuthPlugin.canCheckBiometrics();

});


//! opcional (guardar el estado y el error del la autenticacion en el el estado de la app)

enum LocalAuthStatus {authenticated, notAuthenticated, authtenticating}

class LocalAtuhState {
  final bool didAuthenticate;
  final LocalAuthStatus status;
  final String message;


  LocalAtuhState({
     this.didAuthenticate = false, 
     this.status = LocalAuthStatus.notAuthenticated, 
     this.message = ''
  });

  LocalAtuhState copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? status,
    String? message,
  }) => LocalAtuhState(
      didAuthenticate: didAuthenticate ?? this.didAuthenticate,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  
  @override
  String toString() {
    return '''

  autenticado: $didAuthenticate 
  estado: $status 
  mensaje: $message 
''';
  }
}

class LocalAuthNotifier extends StateNotifier<LocalAtuhState>{

  LocalAuthNotifier() : super(LocalAtuhState());

  Future <(bool,String)> authenticateUser() async {
    final (didAuthenticate, message) = await LocalAuthPlugin.authenticate();

    state = state.copyWith(
      didAuthenticate: didAuthenticate,
      status: didAuthenticate? LocalAuthStatus.authenticated : LocalAuthStatus.notAuthenticated,
      message: message
    );

    return(didAuthenticate,message);
  }
}

final localAuthProvider = StateNotifierProvider<LocalAuthNotifier,LocalAtuhState>((ref){
  return LocalAuthNotifier();
});
