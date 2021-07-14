import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class RemoteConfigService {
  Future<void> initialize();
  String get enforcedVersion;
}

class RemoteConfigServiceImpl implements RemoteConfigService {
  static const _enforcedVersionKey = 'enforced_version';

  late RemoteConfig _remoteConfig;

  RemoteConfigServiceImpl() {
    _remoteConfig = RemoteConfig.instance;
  }

  @override
  String get enforcedVersion => _remoteConfig.getString(_enforcedVersionKey);

  @override
  Future<void> initialize() async {
    _remoteConfig.setDefaults({
      _enforcedVersionKey: '1.0.0',
    });

    _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(hours: 1),
      ),
    );

    await _remoteConfig.fetchAndActivate();
  }
}
