class InstallationListByPromoterDTO {
  bool? status;
  List<Description>? description;
  int? total;

  InstallationListByPromoterDTO({this.status, this.description, this.total});

  InstallationListByPromoterDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {description!.add(new Description.fromJson(v));});
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.description != null) {data['description'] = this.description!.map((v) => v.toJson()).toList();}
    data['total'] = this.total;
    return data;
  }

  bool? isSuccess() => status;
}

class Description {
  String? id, promoter, promoterID, user, userID, date;

  Description({this.id, this.promoter, this.promoterID, this.user, this.userID, this.date});

  Description.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    promoter = json['promoter'];
    promoterID = json['promoterID'];
    user = json['user'];
    userID = json['userID'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['promoter'] = this.promoter;
    data['promoterID'] = this.promoterID;
    data['user'] = this.user;
    data['userID'] = this.userID;
    data['date'] = this.date;
    return data;
  }
}