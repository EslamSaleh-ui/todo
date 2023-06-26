// ignore_for_file: unnecessary_null_comparison
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DB{
  static final DB? D=DB.internal();
  static DB? internal(){
    return null;
  }
  static Database? _db;
  Future<Database> create() async{
    if(_db != null) {
      return _db!;
    }
    String path= join(await getDatabasesPath(),'notify.db');
    _db=await openDatabase(path,version: 1,onCreate: (Database b,int v)
    {
      b.execute('create table notes(id INTEGER primary key AUTOINCREMENT,title varchar(35),note varchar(500),date varchar(100),time varchar(100),color INTEGER)');
    } );
    return _db!;
  }
  Future<void> insertDB(Note a) async{
    Database v=await create();
    int b=await  v.insert('notes', a.toMap());
    print(b);
  }
  Future<List> query() async{
    Database v=await create();
    return v.rawQuery("SELECT * FROM notes ");
  }
  Future<List?> queries({String? title,int? color_,String? date}) async{
    Database v=await create();
     if(!title.isNull && !color_.isNull && !date.isNull)
     return v.query("notes",where: 'title LIKE ? and color=? and date=?',whereArgs: ['%$title%',color_,date]);
     else if(title.isNull || color_.isNull || date.isNull)
      return  v.query("notes",where:'title LIKE ? or color=? or date=?' ,whereArgs: ['%$title%',color_,date]);
      return null;
  }

  Future<int> delete(int id) async{
    Database v=await create();
    return v.delete('notes',where: 'id=?',whereArgs: [id]);
  }

  Future<int> updates(Note s) async{
    Database v=await create();
    var c= v.update('notes',s.toMap(),where: 'id=?',whereArgs: [s.id]);
    return c;
  }
}

class Note {
  int? id;
  String?  title ,note,date,time;
  int? color;

  Note(dynamic obj)
  {id=obj['id'];
  title=obj['title'];
  note=obj['note'];
  date=obj['date'];
  time=obj['time'];
  color=obj['color'];
  }
  Note.fromMap(Map<String,dynamic> data)
  {id=data['id'];
  title=data['title'];
  note=data['note'];
  date=data['date'];
  time=data['time'];
  color=data['color'];
  }
  Map<String,dynamic> toMap()=>{'id':id,'title':title,'note':note,'date':date,'time':time,'color':color };
}