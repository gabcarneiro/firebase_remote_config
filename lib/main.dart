import 'package:firebase_remote_config_demo/update_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final updateManager = UpdateManagerImpl();

    return MaterialApp(
      title: 'Remote Config Demo',
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
          future: updateManager.needsUpdate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final needsUpdate = snapshot.data ?? false;

            return needsUpdate ? UpdateRequiredPage() : HomePage();
          }),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
    );
  }
}

class UpdateRequiredPage extends StatelessWidget {
  const UpdateRequiredPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Required'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A new version of the application is available and is required '
              'to continue, please click below to update to the latest version.',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //go to the store
              },
              child: Text('UPDATE NOW'),
            ),
          ],
        ),
      ),
    );
  }
}
