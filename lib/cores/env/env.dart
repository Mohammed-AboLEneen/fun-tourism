import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class EnvClass {
  @EnviedField(varName: 'AUTHENTICATIONKEY', obfuscate: true)
  static final String authorizationKey = _EnvClass.authorizationKey;
}
