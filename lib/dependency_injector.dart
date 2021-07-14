import 'package:firebase_remote_config_demo/remote_config_service.dart';
import 'package:firebase_remote_config_demo/update_manager.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupDependencies() {
  serviceLocator.registerLazySingleton<RemoteConfigService>(
    () => RemoteConfigServiceImpl(),
  );

  serviceLocator.registerLazySingleton<UpdateManager>(
    () => UpdateManagerImpl(serviceLocator.get<RemoteConfigService>()),
  );
}
