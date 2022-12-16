  class ReminderController extends GetxController{
  
    @override
    void onReady(){
      super.onReady();
    }

    Future<int> addReminder({Reminder? reminder}) async{
      return await DBHelper.insert(reminder);
    }
  }
