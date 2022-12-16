import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../models/reminder_model.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addReminder({Reminder? reminder}) async {
    return await DBHelper.insert(reminder);
  }
}
