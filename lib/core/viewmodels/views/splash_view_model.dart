// import 'package:flutter/widgets.dart';
// import 'package:flutter_base/core/apis/interfaces/local_storage_api.dart';
// import 'package:flutter_base/core/constants/app_contstants.dart';
// import 'package:flutter_base/core/services/authentication_service.dart';
import 'package:flutter_base/core/viewmodels/base_model.dart';

class SplashViewModel extends BaseModel {
//   AuthenticationService _authenticationService;
//   LocalStorageApi _localStorageService;

//   SplashViewModel({
//     @required AuthenticationService authenticationService,
//     @required LocalStorageApi localStorageService,
//   })  : _authenticationService = authenticationService,
//         _localStorageService = localStorageService;

//   Future<bool> isLoginInSaved() async {
// //    return false; // this is only to test login logout routing
//     setBusy(true);
//     String username = await _localStorageService.read(LocalStorageKey.username);
//     if (username == null) {
//       return false;
//     }
//     String password = await _localStorageService.read(LocalStorageKey.password);
//     var login = await _authenticationService.login(
//         username: username, password: password);
//     setBusy(false);
//     return login;
//   }
}
