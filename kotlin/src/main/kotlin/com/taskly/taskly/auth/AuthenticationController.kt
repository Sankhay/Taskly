package com.taskly.taskly.auth

import com.taskly.taskly.security.TokenService
import com.taskly.taskly.user.User
import com.taskly.taskly.user.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpHeaders
import org.springframework.http.ResponseEntity
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/auth")
class AuthenticationController(
    @Autowired private val authenticationManager: AuthenticationManager,
    @Autowired private val repository: UserRepository
) {

    @PostMapping("/login")
    fun login(@RequestBody data: AuthenticationDTD): ResponseEntity<String> {
        val userNamePassword = UsernamePasswordAuthenticationToken(data.email, data.password)
        val auth = authenticationManager.authenticate(userNamePassword)
        var token = TokenService().generateToken(auth.principal as User)
        val headers = HttpHeaders()
        headers.set("Authorization", "Bearer $token")
        return ResponseEntity.ok().headers(headers).body("Success")
    }

    @PostMapping("/register")
    fun register(@RequestBody data: RegisterDTD): ResponseEntity<String> {
        if (this.repository.findByEmail(data.email) != null) return ResponseEntity.badRequest().build();

        val encryptedPassword : String = BCryptPasswordEncoder().encode(data.password);
        val newUser = User(name = data.name, email = data.email, userpassword = encryptedPassword)

        this.repository.save(newUser);

        return ResponseEntity.ok().build();
    }
}

data class AuthenticationDTD(val email: String, val password: String)

data class RegisterDTD(val name: String, val email: String, val password: String)