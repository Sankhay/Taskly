import 'package:flutter/material.dart';
import 'package:taskly/models/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskly/views/task/taskDescriptionPage.dart';

class TaskView extends StatefulWidget {
  final Task task;
  const TaskView({super.key, required this.task});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap:() {
        Navigator.push(
        context,
        MaterialPageRoute(builder: 
          (context) => TaskDescriptionPage(task: widget.task),
        )
    );
      },
      child: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0
            ),
          borderRadius: BorderRadius.circular(8.0)
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                child: Text(widget.task.title,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blueAccent,
                  letterSpacing: 2
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(widget.task.taskHour ,
                style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueAccent,
                              ),
                              ),
              
            ],),
            Row(children: [],)
          ],
        ),
      ),
    )
    );
  }
}