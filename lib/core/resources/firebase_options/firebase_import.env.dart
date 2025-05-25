import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:envied/envied.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

part 'firebase_import.env.g.dart';

abstract final class FirebaseImport {
  static FirebaseOptions get getCurrentPlatform => switch (AppConstants.compileFlavor) {
    'prod' =>
      TargetPlatform.iOS == defaultTargetPlatform
          ? FirebaseOptions(
              apiKey: _DefaultPROD.iOSApiKey,
              appId: _DefaultPROD.iOSAppID,
              messagingSenderId: _DefaultPROD.messagingSenderID,
              projectId: _DefaultPROD.projectID,
              storageBucket: _DefaultPROD.storageBucket,
              iosBundleId: _DefaultPROD.iOSBundleID,
            )
          : FirebaseOptions(
              apiKey: _DefaultPROD.androidApiKey,
              appId: _DefaultPROD.androidAppID,
              messagingSenderId: _DefaultPROD.messagingSenderID,
              projectId: _DefaultPROD.projectID,
              storageBucket: _DefaultPROD.storageBucket,
            ),
    'qa' || _ =>
      TargetPlatform.iOS == defaultTargetPlatform
          ? FirebaseOptions(
              apiKey: _DefaultQA.iOSApiKey,
              appId: _DefaultQA.iOSAppID,
              messagingSenderId: _DefaultQA.messagingSenderID,
              projectId: _DefaultQA.projectID,
              storageBucket: _DefaultQA.storageBucket,
              iosBundleId: _DefaultQA.iOSBundleID,
            )
          : FirebaseOptions(
              apiKey: _DefaultQA.androidApiKey,
              appId: _DefaultQA.androidAppID,
              messagingSenderId: _DefaultQA.messagingSenderID,
              projectId: _DefaultQA.projectID,
              storageBucket: _DefaultQA.storageBucket,
            ),
  };
}

@Envied(path: '.env.qa', requireEnvFile: true, name: 'GeneratedQAConfig')
sealed class _DefaultQA {
  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID', obfuscate: true)
  static final String androidApiKey = _GeneratedQAConfig.androidApiKey;
  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID', obfuscate: true)
  static final String androidAppID = _GeneratedQAConfig.androidAppID;
  @EnviedField(varName: 'FIREBASE_API_KEY_IOS', obfuscate: true)
  static final String iOSApiKey = _GeneratedQAConfig.iOSApiKey;
  @EnviedField(varName: 'FIREBASE_APP_ID_IOS', obfuscate: true)
  static final String iOSAppID = _GeneratedQAConfig.iOSAppID;
  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID', obfuscate: true)
  static final String iOSBundleID = _GeneratedQAConfig.iOSBundleID;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', obfuscate: true)
  static final String messagingSenderID = _GeneratedQAConfig.messagingSenderID;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID', obfuscate: true)
  static final String projectID = _GeneratedQAConfig.projectID;
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET', obfuscate: true)
  static final String storageBucket = _GeneratedQAConfig.storageBucket;
}

@Envied(path: '.env.prod', requireEnvFile: true, name: 'GeneratedPRODConfig')
sealed class _DefaultPROD {
  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID', obfuscate: true)
  static final String androidApiKey = _GeneratedPRODConfig.androidApiKey;
  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID', obfuscate: true)
  static final String androidAppID = _GeneratedPRODConfig.androidAppID;
  @EnviedField(varName: 'FIREBASE_API_KEY_IOS', obfuscate: true)
  static final String iOSApiKey = _GeneratedPRODConfig.iOSApiKey;
  @EnviedField(varName: 'FIREBASE_APP_ID_IOS', obfuscate: true)
  static final String iOSAppID = _GeneratedPRODConfig.iOSAppID;
  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID', obfuscate: true)
  static final String iOSBundleID = _GeneratedPRODConfig.iOSBundleID;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', obfuscate: true)
  static final String messagingSenderID = _GeneratedPRODConfig.messagingSenderID;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID', obfuscate: true)
  static final String projectID = _GeneratedPRODConfig.projectID;
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET', obfuscate: true)
  static final String storageBucket = _GeneratedPRODConfig.storageBucket;
}
