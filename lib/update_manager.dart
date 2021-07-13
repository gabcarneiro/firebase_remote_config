import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class UpdateManager {
  Future<void> needsUpdate();
}

class UpdateManagerImpl implements UpdateManager {
  static const _minVersionKey = 'minimal_version';

  UpdateManagerImpl();

  Future<String> _getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  Future<String> _getMinimalVersion() async {
    final remoteConfig = RemoteConfig.instance;

    await remoteConfig.fetchAndActivate();

    return remoteConfig.getString(_minVersionKey);
  }

  @override
  Future<bool> needsUpdate() async {
    final currentVersion = await _getCurrentVersion();
    final minimalVersion = await _getMinimalVersion();

    final currentVersionNumbers = currentVersion
        .split('.')
        .map((String number) => int.parse(number))
        .toList();

    final minimalVersionNumbers = minimalVersion
        .split('.')
        .map((String number) => int.parse(number))
        .toList();

    for (int i = 0; i < 3; i++) {
      if (minimalVersionNumbers[i] > currentVersionNumbers[i]) return true;
    }

    return false;
  }
}
