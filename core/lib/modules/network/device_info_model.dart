import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AgentInfo {
  AgentInfo({
    required this.appName,
    required this.version,
    required this.buildNumber,
    required this.device,
    required this.sdkVersion,
  });

  final String appName;
  final String version;
  final String buildNumber;
  final Device device;
  final String sdkVersion;

  String get userAgent => Uri.encodeFull(
      '$appName/$version-$buildNumber (${device.os} ${device.version} ${device.name}) $sdkVersion');

  String? get deviceName =>
      Platform.isIOS ? device.name : "${device.brand} ${device.name}";

  static Future<AgentInfo> getAgentInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    final Device device = await () async {
      if (Platform.isIOS) {
        final IosDeviceInfo iOSDeviceInfo = await deviceInfo.iosInfo;

        return Device(
          os: iOSDeviceInfo.systemName,
          version: iOSDeviceInfo.systemVersion,
          name: iOSDeviceInfo.utsname.machine,
          osType: 'ios',
          id: iOSDeviceInfo.identifierForVendor,
          brand: iOSDeviceInfo.utsname.machine,
          isPhysicalDevice: iOSDeviceInfo.isPhysicalDevice != false,
        );
      } else {
        final AndroidDeviceInfo androidDeviceInfo =
            await deviceInfo.androidInfo;

        return Device(
          os: 'Android',
          version: androidDeviceInfo.version.sdkInt.toString(),
          name: androidDeviceInfo.model,
          osType: 'android',
          id: androidDeviceInfo.id,
          brand: androidDeviceInfo.brand,
          isPhysicalDevice: androidDeviceInfo.isPhysicalDevice != false,
        );
      }
    }();

    return AgentInfo(
      appName: packageInfo.appName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      device: device,
      sdkVersion: 'Flutter 2.2.3',
    );
  }
}

class Device {
  Device({
    this.os,
    this.version,
    this.name,
    this.osType,
    this.id,
    this.isPhysicalDevice,
    this.brand,
  });

  final String? os;
  final String? version;
  final String? name;
  final String? osType;
  final String? id;
  final bool? isPhysicalDevice;
  final String? brand;
}
