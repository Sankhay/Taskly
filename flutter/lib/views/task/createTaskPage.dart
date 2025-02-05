import 'package:flutter/material.dart';
import 'package:taskly/components/tasklyTextInput/tasklyTextInput.dart';
import 'package:taskly/components/pageTitle/pageTitle.dart';
import 'package:taskly/constants/strings.dart';
import 'package:taskly/utils/utils.dart';


import 'package:taskly/viewmodels/task.dart';
import 'package:taskly/views/task/tasksPage.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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

  void handleCreateTaskButton() async {
    if (_formKey.currentState!.validate()) {
     try {
      final successResponse = await _taskViewModel.createTask(_titleController.text, _descriptionController.text, _timeController.text, _dateController.text);

      if (successResponse) {
        
      bool finished = await Utils.showNotificationToUser(context, Strings.taskCreatedMessage, title: Strings.success);
        
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
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Strings.createTaskTitle)
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
              title: Strings.createTaskTitle
            ),
            TasklyTextInput(
              hintText: Strings.enterTaskName, 
              errorText: "error text",
              controller: _titleController,
            ),
            TasklyTextInput(
              hintText: Strings.enterTaskDescription, 
              errorText: "error text",
              controller: _descriptionController,
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(context),
                    )
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
          
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                handleCreateTaskButton();
              }
            }, child: Text(Strings.createTaskTitle)),
          ],
        ))
      ),
    );
  }
}