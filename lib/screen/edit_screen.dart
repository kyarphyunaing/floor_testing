import 'package:floortesting/database/note_table.dart';
import 'package:floortesting/database/notedao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EditScreen extends StatelessWidget {
  TextEditingController title=TextEditingController();
  TextEditingController message=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final NoteDao noteDao=Get.find();
    Note note=Get.arguments;
    title.text=note.title;
    message.text=note.message;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note"),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children:[
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Title',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: message,
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder()
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Edit Note"),
              onPressed: (){
                noteDao.updateNote(Note(title.text,message.text,id: note.id));
                Get.back();
              },
            )
          ]
        ),
      ),
    );
  }
}
