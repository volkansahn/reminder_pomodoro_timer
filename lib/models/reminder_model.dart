class Reminder{
  int? id;
  String? title;
  String? reminder;
  String? date;
  String? time;
  String? remindBefore;
  String? repeat;
  int? color;
  int? isReminded;
  
  Reminder({
    this.id;
    this.title;
    this.reminder;
    this.date;
    this.time;
    this.remindBefore;
    this.repeat;
    this.color;
    this.isReminded;
  });
  
  Reminder.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    reminder = json['reminder'];
    date = ['date'];
    time = json['time'];
    remindBefore = json['remindBefore'];
    repeat = json['repeat'];
    color = json['color'];
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
    data['repeat'] = this.repeat;
    data['color'] = this.color;
    data['isReminded'] = this.isReminded;
    return data;
  }
                    
}
