import 'package:package_info_plus/package_info_plus.dart';

import 'remote_config_service.dart';

abstract class UpdateManager {
  Future<bool> needsUpdate();
}

class UpdateManagerImpl implements UpdateManager {
  final RemoteConfigService _remoteConfigService;

  UpdateManagerImpl(this._remoteConfigService);

  Future<String> _getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  @override
  Future<bool> needsUpdate() async {
    final currentVersion = await _getCurrentVersion();
    final enforcedVersion = _remoteConfigService.enforcedVersion;

    final currentVersionNumbers = currentVersion
        .split('.')
        .map((String number) => int.parse(number))
        .toList();

    final enforcedVersionNumbers = enforcedVersion
        .split('.')
        .map((String number) => int.parse(number))
        .toList();

    for (int i = 0; i < 3; i++) {
      if (enforcedVersionNumbers[i] > currentVersionNumbers[i]) return true;
    }

    return false;
  }
}
