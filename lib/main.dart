import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/cache/cache_helper.dart';
import '/core/database/sqflite_helper.dart';
import '/core/services/bloc_observer.dart';
import '/core/services/local_notification_services.dart';
import '/core/services/services_locator.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/home/cubit/home_cubit.dart';
import '/features/splash/presentation/screens/splash_screen.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:device_preview_plus/device_preview_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyObserver();
  await getItSetup();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.local);
  await instance<CacheHelper>().init();

  await instance<DBHelper>().getDB();
  await LocalNotificationServices.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<AuthCubit>()),
        BlocProvider(create: (context) => instance<HomeCubit>()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Notes",
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: SplashScreen(),
      ),
    );
  }
}

/* kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
    lint {
        baseline = file("lint-baseline.xml")
/*    }

/*rules:
   - prefer_const_constructors 
   - prefer_const_literals_to_create_immutables 
   - prefer_const_declarations*/

/*for notifications 3.38
     android/app/buildgradle: 


    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
     flutter {
    source = "../.."
}
     dependencies{
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}*/



android/gadle.properties


kotlin.incremental=false
kotlin.daemon.useFallbackStrategy=true
kotlin.incremental.useClasspathSnapshot=false*/*/

/**
 * flutter clean
flutter pub cache repair
gradlew --stop
gradlew clean
 */

/**
 <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>


  <!--notifications-->
          <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ActionBroadcastReceiver" />
          <receiver
    android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />

<receiver
    android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
    </intent-filter>
</receiver>


 */
