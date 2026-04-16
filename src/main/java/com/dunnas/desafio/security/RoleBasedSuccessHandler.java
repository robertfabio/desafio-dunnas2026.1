package com.dunnas.desafio.security;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class RoleBasedSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        String role = authentication.getAuthorities().stream()
            .map(GrantedAuthority::getAuthority)
            .findFirst()
            .orElse("");

        String redirect = switch (role) {
            case "ROLE_ADMIN"        -> "/admin/dashboard";
            case "ROLE_COLLABORATOR" -> "/staff/dashboard";
            case "ROLE_RESIDENT"     -> "/resident/dashboard";
            default                  -> "/login?error";
        };

        response.sendRedirect(request.getContextPath() + redirect);
    }
}
