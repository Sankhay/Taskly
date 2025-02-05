package com.taskly.taskly.user

import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service

@Service
class UserService(private val db: UserRepository) : UserDetailsService {

    fun save(user: User): User = db.save(user)

    override fun loadUserByUsername(email: String): UserDetails? {
        return db.findByEmail(email)
    }

}