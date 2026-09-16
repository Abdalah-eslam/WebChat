package utils ;

import java.nio.charset.StandardCharsets;
import java.nio.file.attribute.UserDefinedFileAttributeView;
import java.util.Date;

import javax.crypto.SecretKey;

import Models.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

public class JWT {
	
	private static final String SECRET_STRING = "your-very-secure-and-ultra-long-secret-key-123456";
	private static final long EXPIRATION_TIME = 86_400_000;
	private static final SecretKey SECRET_KEY = Keys.hmacShaKeyFor(SECRET_STRING.getBytes(StandardCharsets.UTF_8));
	
	public static String GenrateJwt(String username , long id,String role) 
	{
		return Jwts.builder()
                .subject(username)
                .claim("role", role)
                .claim("id", id)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SECRET_KEY)
                .compact();
		
	}
	
	public static Claims validateToken(String token) {
		if (token == null || token.isEmpty())
		{
			return null;
		}
		
        return Jwts.parser()
                .verifyWith(SECRET_KEY)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
	
	
	
}