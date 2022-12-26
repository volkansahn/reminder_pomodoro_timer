class Reminder {
  int? id;
  String? title;
  String? reminder;
  String? date;
  String? time;
  String? remindBefore;
  String? repeat;
  String? label;
  int? color;
  int? isReminded;
  bool? isWaterReminder;

  Reminder({
    this.id,
    this.title,
    this.reminder,
    this.date,
    this.time,
    this.remindBefore,
    this.repeat,
    this.label,
    this.color,
    this.isReminded,
    this.isWaterReminder,
  });

  Reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    reminder = json['reminder'];
    date = json['date'];
    time = json['time'];
    remindBefore = json['remindBefore'];
    repeat = json['repeat'];
    label = json['label'];
    color = json['color'];
    isReminded = json['isReminded'];
    isWaterReminder = json['isWaterReminder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['reminder'] = this.reminder;
    data['date'] = this.date;
    data['time'] = this.time;
    data['remindBefore'] = this.remindBefore;
    data['repeat'] = this.repeat;
    data['label'] = this.label;
    data['color'] = this.color;
    data['isReminded'] = this.isReminded;
    data['isWaterReminder'] = this.isWaterReminder;
    return data;
  }
}
