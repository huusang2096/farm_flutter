import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseConfig {
  static Future<FirebaseConfig> init() async {
    final notificationService = FirebaseConfig();
    await notificationService.setupFirebaseDatabase();
    return notificationService;
  }

  FirebaseApp firebaseDatabase;

  setupFirebaseDatabase() async {
    firebaseDatabase = await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}
