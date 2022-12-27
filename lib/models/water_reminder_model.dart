class WaterReminder {
  int? id;
  double? goal;
  String? date;
  int? remindPeriod;
  double? totalDrink;

  WaterReminder(
      {this.id, this.goal, this.date, this.remindPeriod, this.totalDrink});

  WaterReminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goal = json['goal'];
    date = json['date'];
    remindPeriod = json['remindPeriod'];
    totalDrink = json['totalDrink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goal'] = this.goal;
    data['date'] = this.date;
    data['remindPeriod'] = this.remindPeriod;
    data['totalDrink'] = this.totalDrink;
    return data;
  }
}
