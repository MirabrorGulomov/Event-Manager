import 'package:flutter/material.dart';

class Event {
  final int? id;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final Color color;

  Event(
      {this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.date,
      required this.time,
      required this.color});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'location': location,
      'date': date,
      'time': time,
      'color': color.value,
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      date: map['date'],
      time: map['time'],
      color: Color(map['color']),
    );
  }

  Event copy(
      {int? id,
      String? title,
      String? description,
      String? location,
      String? date,
      String? time,
      int? priority,
      Color? color}) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      color: color ?? this.color,
    );
  }
}
