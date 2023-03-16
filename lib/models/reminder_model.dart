class Reminder {
  int? id;
  String? title;
  String? reminder;
  String? date;
  String? time;
  String? remindBefore;
  String? label;
  int? interval;
  int? firstColor;
  int? secondColor;
  int? isReminded;

  Reminder({
    this.id,
    this.title,
    this.reminder,
    this.date,
    this.time,
    this.remindBefore,
    this.label,
    this.interval,
    this.firstColor,
    this.secondColor,
    this.isReminded,
  });

  Reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    reminder = json['reminder'];
    date = json['date'];
    time = json['time'];
    remindBefore = json['remindBefore'];
    interval = json['interval'];
    label = json['label'];
    firstColor = json['firstColor'];
    secondColor = json['secondColor'];
    isReminded = json['isReminded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['reminder'] = this.reminder;
    data['date'] = this.date;
    data['time'] = this.time;
    data['remindBefore'] = this.remindBefore;
    data['interval'] = this.interval;
    data['label'] = this.label;
    data['firstColor'] = this.firstColor;
    data['secondColor'] = this.secondColor;
    data['isReminded'] = this.isReminded;
    return data;
  }
}
