import 'package:flutter_app_riverpod/provider_examples/change_notifier_provider/big_counter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bigCounterModelProvider = ChangeNotifierProvider((ref) => BigCounterModel());