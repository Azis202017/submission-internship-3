import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: Lottie.asset('assets/json/43320-notifications.json'),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Enable Notifications so you don\'t miss another message from ur friend or ur family',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 170,
                height: 50,
                child: ElevatedButton(
                  onPressed: _showNotification,
                  child: const Text('Enable Notification'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _showNotification() async {
    const androidPlatfromChannelSpesifics = AndroidNotificationDetails(
      'notification_channel_id',
      'Channel Name',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    const platfromChannelSpesifics =
        NotificationDetails(android: androidPlatfromChannelSpesifics);
    flutterLocalNotificationsPlugin!.show(
      0,
      'Notification Added Successfull',
      'You will be get message from ur family or ur friends',
      platfromChannelSpesifics,
      payload: 'Notification Added Successfull',
    );
  }

  Future<void> onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Notification Added Successfull"),
          content: Text("$payload"),
        );
      },
    );
  }
}
