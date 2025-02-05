package com.taskly.taskly.task

import org.springframework.data.annotation.Id
import org.springframework.data.relational.core.mapping.Table
import java.time.LocalDate
import java.time.LocalTime

@Table("TASKS")
data class Task(@Id val id: String? = null,
                var title: String,
                var description: String,
                var taskHour: LocalTime,
                var taskDay: LocalDate,
                var userId: String
)

data class TaskEntity(
    val title: String,
    val description: String,
    val taskHour: LocalTime,
    val taskDay: LocalDate
)

