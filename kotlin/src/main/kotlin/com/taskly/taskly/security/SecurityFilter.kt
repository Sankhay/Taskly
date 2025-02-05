package com.taskly.taskly.security

import com.taskly.taskly.user.UserRepository
import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

@Component
class SecurityFilter : OncePerRequestFilter() {

    @Autowired
    lateinit var userRepository: UserRepository

    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        var token = this.recoverToken(request);
        if (token != null){
            var subjectEmail = TokenService().extractEmail(token)
            val user = userRepository.findByEmail(subjectEmail)

            val authorities = listOf(SimpleGrantedAuthority("ROLE_USER"))
            val authentication = UsernamePasswordAuthenticationToken(user, null, authorities)
            val context: SecurityContext = SecurityContextHolder.createEmptyContext()
            context.authentication = authentication
            request.setAttribute("user", user)

            SecurityContextHolder.setContext(context)
        }
        filterChain.doFilter(request, response);
    }

    private fun recoverToken(request: HttpServletRequest): String? {
        var authHeader = request.getHeader("Authorization");
        if(authHeader == null) return null;
        return authHeader.replace("Bearer ", "")
    }

}