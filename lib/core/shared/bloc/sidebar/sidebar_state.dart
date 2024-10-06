import 'package:flutter/foundation.dart';

@immutable
abstract class SidebarState {}

class SidebarOpened extends SidebarState {}

class SidebarClosed extends SidebarState {}
