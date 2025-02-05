package com.taskly.taskly.user

import org.springframework.data.repository.CrudRepository
import org.springframework.security.core.userdetails.UserDetails

interface UserRepository : CrudRepository<User, String> {
    fun findByEmail(email: String) : UserDetails?
}