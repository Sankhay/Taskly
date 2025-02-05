package com.taskly.taskly.task

import com.taskly.taskly.user.User
import jakarta.servlet.http.HttpServletRequest
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.net.URI

@RestController
@RequestMapping("/")
class TaskController(private val service: TaskService) {
    @GetMapping("/task")
    fun listTasks(request: HttpServletRequest): ResponseEntity<List<Task>> {
        val user = request.getAttribute("user") as User
        var tasks = service.findTasks(user.id.toString());
        return ResponseEntity.ok().body(tasks);
    }

    @PostMapping("/task")
    fun post(@RequestBody taskEntity: TaskEntity, request: HttpServletRequest): ResponseEntity<Task> {
        val user = request.getAttribute("user") as User
        val task = Task(title = taskEntity.title, description = taskEntity.description,
            taskHour = taskEntity.taskHour, taskDay = taskEntity.taskDay, userId = user.id.toString())
        val savedTask = service.save(task)
        return ResponseEntity.created(URI("/${savedTask.id}")).body(savedTask)
    }

    @GetMapping("/task/{id}")
    fun getTask(@PathVariable id: String): ResponseEntity<Task> {
        val task = service.findTaskById(id)
        return if (task != null) {
            ResponseEntity.ok(task)
        } else {
            ResponseEntity.notFound().build()
        }
    }

    @PutMapping("/task/{id}")
    fun updateTask(@PathVariable id: String, @RequestBody taskEntity: TaskEntity, request: HttpServletRequest): ResponseEntity<Task> {
        val user = request.getAttribute("user") as User
        var existingTask = service.findTaskById(id)
        return if (existingTask != null) {
            if (existingTask.userId == user.id.toString()) {
                existingTask.title = taskEntity.title
                existingTask.description = taskEntity.description
                existingTask.taskHour = taskEntity.taskHour
                existingTask.taskDay = taskEntity.taskDay
                val updatedTask = service.save(existingTask)
                ResponseEntity.ok(updatedTask)
            } else {
                ResponseEntity.badRequest().build()
            }
        } else {
            ResponseEntity.notFound().build()
        }
    }

    @DeleteMapping("/task/{id}")
    fun deleteTask(@PathVariable id: String, request: HttpServletRequest): ResponseEntity<Void> {
        val user = request.getAttribute("user") as User
        val existingTask = service.findTaskById(id)

        return if (existingTask != null) {
            if (existingTask.userId == user.id.toString()) {
                service.deleteTask(existingTask)
                ResponseEntity.ok().build()
            } else {
                ResponseEntity.badRequest().build()
            }
        } else {
            ResponseEntity.notFound().build()
        }
    }

}
