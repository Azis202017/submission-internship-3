import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
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
      'notification_added',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    const platfromChannelSpesifics =
        NotificationDetails(android: androidPlatfromChannelSpesifics);
    flutterLocalNotificationsPlugin!.zonedSchedule(
     
      0,
      'Notification added Successfull',
      'You will be get message from ur family or ur frineds',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      platfromChannelSpesifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Notification Added Successfull"),
          content: SizedBox(
            height : 200,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(
                    'assets/json/14584-well-done.json',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Success to active notification!'),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}
