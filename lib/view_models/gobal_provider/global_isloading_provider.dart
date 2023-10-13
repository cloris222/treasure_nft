import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalIsLoadingProvider = StateProvider<bool>((ref) => false);