import 'package:flutter/material.dart';
import 'package:taskly/components/tasklyTextInput/tasklyTextInput.dart';
import 'package:taskly/components/pageTitle/pageTitle.dart';
import 'package:taskly/constants/strings.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/utils/utils.dart';
import 'package:taskly/viewmodels/task.dart';
import 'package:taskly/views/task/tasksPage.dart';


class TaskDescriptionPage extends StatefulWidget {
  final Task task;

  const TaskDescriptionPage({super.key, required this.task});

  @override
  State<TaskDescriptionPage> createState() => _TaskDescriptionState();
}

class _TaskDescriptionState extends State<TaskDescriptionPage> {
  late  TextEditingController _titleController = TextEditingController();
  late  TextEditingController _descriptionController = TextEditingController();
  late  TextEditingController _dateController = TextEditingController(text: widget.task.taskDay);
  late  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description); 
    _dateController = TextEditingController(text: widget.task.taskDay);
    _timeController = TextEditingController(text: widget.task.taskHour);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TaskViewModel _taskViewModel = TaskViewModel();

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        
        _timeController.text = Utils.setFormattedTimeOfDay(picked);
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context, 
      firstDate: DateTime(2024), 
      lastDate: DateTime(2100)
    );

    if (_picked != null){
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  void handleUpdateTask() async {
    if (_formKey.currentState!.validate()) {
      try {

      final successResponse = await _taskViewModel.updateTask(widget.task.id, _titleController.text, _descriptionController.text, _timeController.text, _dateController.text);

      if (successResponse) {
        bool finished = await Utils.showNotificationToUser(context, Strings.taskUpdatedMessage, title: Strings.success);
        
        if (finished) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TasksPage()),
        );
        }
      
      } else {
        Utils.showNotificationToUser(context, Strings.errorApi);
      }
    } catch (e) {
      Utils.showNotificationToUser(context, Strings.errorApi);
    }
  }}

  void handleDeleteTask() async {
    if (_formKey.currentState!.validate()) {
      try {
      final successResponse = await _taskViewModel.deleteTask(widget.task.id);

      if (successResponse) {
        bool finished = await Utils.showNotificationToUser(context, Strings.taskDeletedMessage, title: Strings.success);
        
        if (finished) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TasksPage()),
        );
        }
      } else {
        Utils.showNotificationToUser(context, Strings.errorApi);
      }
    } catch (e) {
      Utils.showNotificationToUser(context, Strings.errorApi);
    }
  }}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Strings.taskDescriptionTitle)
      ),
      body: SingleChildScrollView(
        child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            PageTitle(
              title: Strings.taskDescriptionTitle
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Strings.name, 
                        style: TextStyle(
                      fontSize: 18
              )) ,
              ),
            ),
            TasklyTextInput(
              hintText: Strings.enterTaskName, 
              errorText: "error text",
              controller: _titleController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Strings.description, 
                        style: TextStyle(
                      fontSize: 18
              )) ,
              ),
            ),
            TasklyTextInput(
              hintText: Strings.enterTaskDescription, 
              errorText: "error text",
              controller: _descriptionController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Strings.hour, 
                        style: TextStyle(
                      fontSize: 18
              )) ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.96,
                child: TextField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          hintText: Strings.selectHourHintText,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(context),
                    )
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Strings.date, 
                        style: TextStyle(
                      fontSize: 18
              )) ,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.96,
              height: 110,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                  child: TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: Strings.selectDateHintText,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(),
                  )
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    handleDeleteTask();
                  }
                },
                child: Text(Strings.deleteTask)
                ),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    handleUpdateTask();
                  }
                },
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      color: Colors.red
                    ), 
                ), 
                child: Text(Strings.updateTask)),
              ],
            )
          ],
        ))
      ),
      );
  }
}