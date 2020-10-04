import 'package:floortesting/database/note_table.dart';
import 'package:floortesting/database/notedao.dart';
import 'package:floortesting/screen/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_screen.dart';
class Home extends StatelessWidget {
  final NoteDao noteDao=Get.find();
  List<Note> notes=List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Floor Database"),
      ),
      body: notelist(),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            child: Icon(Icons.add),
            onPressed: ()/*async{
             await noteDao.addNote(Note('This is Title','This is TitleMessage'));
            }*/{
              Get.to(AddScreen());
            }
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: 'delete',
            child: Icon(Icons.delete),
            onPressed: (){
              noteDao.deleteAllNotes(notes);
            },
          ),
        ],
      ),
    );
  }
  Widget notelist(){
    return StreamBuilder<List<Note>>(
        stream: noteDao.getNoteData(),
        builder: (_,data){
         if(data.hasData){
           notes=data.data;
           return ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (_,position){
             return Card(
               child: ListTile(
                 title: Text(data.data[position].title),
                 subtitle: Text(data.data[position].message),
                 trailing: IconButton(
                   icon: Icon(Icons.delete),
                   onPressed: (){
                     noteDao.deleteNote(data.data[position]);
                   },
                 ),
                 leading: IconButton(
                   icon: Icon(Icons.edit),
                   onPressed: (){
                      Get.to(EditScreen(),arguments: data.data[position]);
                   },
                 ),
               ),
             );
             },
           );
         }
         else if(data.hasError){
           return Text("Error");
  }else{
           return Text("loading");
  }
        }
        );
  }
}
