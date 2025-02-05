package com.taskly.taskly.task

import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service

@Service
class TaskService(private val db: TaskRepository) {
    fun findTasks(userId: String): List<Task> = db.findAll().filter { it.userId == userId }.toList()

    fun findTaskById(id: String): Task?  = db.findByIdOrNull(id)

    fun save(task: Task): Task = db.save(task)

    fun deleteTask(task: Task) = db.delete(task);
}