class NotificationTXN {
  bool? isSuccessful;
  ResponseParam? responseParam;

  NotificationTXN({this.isSuccessful, this.responseParam});

  NotificationTXN.fromJson(Map<String, dynamic> json) {
    isSuccessful = json['isSuccessful'];
    responseParam = json['responseParam'] != null
        ? new ResponseParam.fromJson(json['responseParam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccessful'] = this.isSuccessful;
    if (this.responseParam != null) {
      data['responseParam'] = this.responseParam!.toJson();
    }
    return data;
  }
}

class ResponseParam {
  String? statusDesc;
  List<Messages>? messages;
  String? mobileNumber;
  bool? status;

  ResponseParam(
      {this.statusDesc, this.messages, this.mobileNumber, this.status});

  ResponseParam.fromJson(Map<String, dynamic> json) {
    statusDesc = json['statusDesc'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    mobileNumber = json['mobile_number']??'';
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusDesc'] = this.statusDesc;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['mobile_number'] = this.mobileNumber;
    data['status'] = this.status;
    return data;
  }
}

class Messages {
  int? messageId;
  String? category;
  String? message;
  int? expTime;
  String? isViewed;
  String? messagetime;

  Messages(
      {this.messageId,
        this.category,
        this.message,
        this.expTime,
        this.isViewed,
        this.messagetime});

  Messages.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id']??0;
    category = json['category']??'';
    message = json['message']??'';
    expTime = json['expTime']??0;
    isViewed = json['isViewed']??'';
    messagetime = json['messagetime']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_id'] = this.messageId;
    data['category'] = this.category;
    data['message'] = this.message;
    data['expTime'] = this.expTime;
    data['isViewed'] = this.isViewed;
    data['messagetime'] = this.messagetime;
    return data;
  }
}