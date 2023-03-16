import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/http/parameter/check_earning_income.dart';

final orderDetailRecordProvider = StateNotifierProvider<OrderDetailNotifier,List<CheckEarningIncomeData> >((ref) {
return OrderDetailNotifier();
});

class OrderDetailNotifier extends StateNotifier<List<CheckEarningIncomeData>> {
  OrderDetailNotifier() : super([]);


}
