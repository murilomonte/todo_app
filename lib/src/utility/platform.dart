import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

const isWeb = kIsWeb;
final isAndroid = !isWeb && Platform.isAndroid;
final isIOS = !isWeb && Platform.isIOS;
final isLinux = !isWeb && Platform.isLinux;
final isMacOS = !isWeb && Platform.isMacOS;
final isWindows = !isWeb && Platform.isWindows;

final isDesktop = isLinux || isMacOS || isWindows;
final isMobile = isIOS || isAndroid;
final isApplePlatform = isIOS || isMacOS;

final pathSeparator = Platform.pathSeparator;