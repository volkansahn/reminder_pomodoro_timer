class Timer {
  int? id;
  String? groupName;
  String? timerName;
  int? workTime;
  int? resetTime;
  int? totalSession;
  int? workedSession;

  Timer({
    this.id,
    this.groupName,
    this.timerName,
    this.workTime,
    this.resetTime,
    this.totalSession,
    this.workedSession,
  });

  Timer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['groupName'];
    timerName = json['timerName'];
    workTime = json['workTime'];
    resetTime = json['resetTime'];
    totalSession = json['totalSession'];
    workedSession = json['workedSession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> timerData = new Map<String, dynamic>();
    timerData['id'] = this.id;
    timerData['groupName'] = this.groupName;
    timerData['timerName'] = this.timerName;
    timerData['workTime'] = this.workTime;
    timerData['resetTime'] = this.resetTime;
    timerData['totalSession'] = this.totalSession;
    timerData['workedSession'] = this.workedSession;
    return timerData;
  }
}
