import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GITHUB_CLIENT_ID', obfuscate: true)
  static final String githubClientId = _Env.githubClientId;
  @EnviedField(varName: 'GITHUB_CLIENT_SECRET', obfuscate: true)
  static final String githubClientSecret = _Env.githubClientSecret;
}
