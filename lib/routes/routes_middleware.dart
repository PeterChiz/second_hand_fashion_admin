import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import 'routes.dart';

class SHFRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated ? null : const RouteSettings(name: SHFRoutes.login);
  }
}
