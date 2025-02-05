package com.taskly.taskly.task

import org.springframework.data.repository.CrudRepository


interface TaskRepository : CrudRepository<Task, String>