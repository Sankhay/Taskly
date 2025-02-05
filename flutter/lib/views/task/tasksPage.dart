import 'package:flutter/material.dart';
import 'package:taskly/components/taskView/taskView.dart';
import 'package:taskly/constants/strings.dart';
import 'package:taskly/views/task/createTaskPage.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/utils/utils.dart';
import 'package:taskly/viewmodels/task.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPage();
}

class _TasksPage extends State<TasksPage> {
  final TaskViewModel _taskViewModel = TaskViewModel();
  
  @override
  void initState() {
    super.initState();
    getTasks();
  }

  List<Task> tasks = [];
  Map<String, List<Task>> groupedTasks = {};
  bool _isLoading = true;

  Future getTasks() async {
   _isLoading = true;
   var (bool successResponse, List<Task>? taskList)  = await _taskViewModel.getTasks();

    if (successResponse) {
      setState(() {
        taskList!.sort((a, b) {
          DateTime taskADate = DateTime.parse(a.taskDay);
          DateTime taskBDate = DateTime.parse(b.taskDay);
          int dateComparison = taskADate.compareTo(taskBDate);
          if (dateComparison == 0) {
            return a.taskHour.compareTo(b.taskHour);
          }
          return dateComparison;
        });
        tasks = taskList;

        groupedTasks = {};
        for (var task in tasks) {
          if (!groupedTasks.containsKey(task.taskDay)) {
            groupedTasks[task.taskDay] = [];
          }
          groupedTasks[task.taskDay]?.add(task);
        }
        _isLoading = false;
      });
    } else {
      Utils.showNotificationToUser(context, Strings.errorApi);
    }
  }

  void handleAddTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTaskPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        title: Center(child: Text(
          Strings.appTitle,
          style: TextStyle(
            letterSpacing: 1
          )
          )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          shape: CircleBorder(),
          child: Icon(Icons.add),
          onPressed: () {
            handleAddTaskButton();
          },
        ),
      ),
      floatingActionButtonLocation: 
        FloatingActionButtonLocation.endFloat,
      body: _isLoading 
      ? Center(child: CircularProgressIndicator())
      : RefreshIndicator(
        onRefresh: () => getTasks(),
        child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: groupedTasks.length,
        itemBuilder: (context, groupedIndex) {
          String taskDay = groupedTasks.keys.elementAt(groupedIndex);
          DateTime date = DateTime.parse(taskDay);
          String formattedDate = "${DateFormat('MMMM').format(date)} ${date.day}";
           return Column(
             children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(formattedDate,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )),
                ),
                ...groupedTasks[taskDay]!.map((task) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TaskView(task: task),
                );
              }).toList()               
             ],
           );
        }
      ),
      )
      );
  }
}