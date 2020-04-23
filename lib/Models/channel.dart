class Channel{
  String channel_id;
  String channel_name;



  Channel(this.channel_id,this.channel_name);

  factory Channel.fromJson(dynamic json) {
    return Channel(
        json['channel_id'] as String, json['channel_name'] as String);
  }
  Map<String, dynamic> toJson() => {
    'channel_id': channel_id,
    'channel_name': channel_name,
  };


  String toString() {
    return '{${this.channel_id},${this.channel_name}}';
  }

}