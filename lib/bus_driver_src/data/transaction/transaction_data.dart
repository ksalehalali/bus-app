class Transaction {
  Transaction({
    required this.username,
    required this.createdDate,
    required this.status,
  });

  final String? username;
  String? createdDate;
  final bool? status;

  String get time {
    List<String> texts = createdDate!.split(' ');
    return '${texts[1]} ${texts[2]}';
  }
  String get date => '${createdDate?.split(' ').first}';
  String get statusIconPath{if(status == true) return 'assets/icon/success.png'; else return 'assets/icon/failed.png' ;}
}