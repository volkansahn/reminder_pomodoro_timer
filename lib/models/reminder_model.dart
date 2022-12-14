class Reminder {
  int? id;
  String? title;
  String? reminder;
  String? date;
  String? remindBefore;
  String? repeat;
  String? label;
  int? color;
  int? isReminded;

  Reminder({
    this.id,
    this.title,
    this.reminder,
    this.date,
    this.remindBefore,
    this.repeat,
    this.label,
    this.color,
    this.isReminded,
  });

  Reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    reminder = json['reminder'];
    date = json['date'];
    remindBefore = json['remindBefore'];
    repeat = json['repeat'];
    label = json['label'];
    color = json['color'];
    isReminded = json['isReminded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['reminder'] = this.reminder;
    data['date'] = this.date;
    data['remindBefore'] = this.remindBefore;
    data['repeat'] = this.repeat;
    data['label'] = this.label;
    data['color'] = this.color;
    data['isReminded'] = this.isReminded;
    return data;
  }
}
