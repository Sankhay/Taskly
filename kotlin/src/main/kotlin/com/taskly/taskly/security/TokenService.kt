package com.taskly.taskly.security

import com.taskly.taskly.user.User
import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.time.ZoneId
import java.util.*
import javax.crypto.spec.SecretKeySpec

@Service
class TokenService(
    //Eu sei que deveria ser uma variavel de ambiente, mas deixei assim para ficar mais facil de rodar a aplicação.
    private val secret: String = "dGFpbHRydWNrc2VsZG9tcm9ja2RvY3RvcndoZW5ldmVyZmVkZm91bmRuZWFyZXN0cHI="
) {
    private val signingKey: SecretKeySpec
        get() {
            val keyBytes: ByteArray = Base64.getDecoder().decode(secret)
            return SecretKeySpec(keyBytes, 0, keyBytes.size, "HmacSHA256")
        }

    fun generateToken(user: User): String {
        return Jwts.builder()
            .setSubject(user.email)
            .setIssuedAt(Date(System.currentTimeMillis()))
            .setExpiration(generateTokenExpiration())
            .signWith(signingKey)
            .compact()
    }

    fun generateTokenExpiration(): Date {
        return Date.from(LocalDateTime.now().plusHours(2)
            .atZone(ZoneId.systemDefault())
            .toInstant())
    }

    fun extractEmail(token: String): String {
        return extractAllClaims(token).subject
    }

    private fun extractAllClaims(token: String): Claims {
        return Jwts.parserBuilder()
            .setSigningKey(signingKey)
            .build()
            .parseClaimsJws(token)
            .body
    }

}
