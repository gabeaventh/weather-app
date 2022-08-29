import 'package:core/core.dart';
import 'package:core/modules/env/env.dart';
import 'package:core/modules/logger/log.dart';
import 'package:core/modules/network/device_info_model.dart';
import 'package:delosaqua_trial/myapp.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  Future init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AgentInfo agentInfo = await AgentInfo.getAgentInfo();
    Device device = agentInfo.device;

    await NetworkInterface.instance.setDevicePreference(
      deviceId: device.id,
      deviceName: device.name,
      isPhysicalDevice: device.isPhysicalDevice,
      osType: device.osType,
      appName: packageInfo.appName,
      buildNumber: packageInfo.buildNumber,
      sdkVersion: device.version,
      version: packageInfo.version,
    );

    Log.init();

    Env.instance?.initEnv();

    return "next";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.data.toString().contains("next")) {
            return Container();
          }
          return const MyApp();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
