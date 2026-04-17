package com.dunnas.desafio.audit.aspect;

import com.dunnas.desafio.audit.service.AuditService;
import com.dunnas.desafio.security.SecurityUser;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Aspect
@Component
@RequiredArgsConstructor
@Slf4j
public class AuditAspect {

    private final AuditService auditService;

    @Around("@annotation(auditable)")
    public Object audit(ProceedingJoinPoint joinPoint, Auditable auditable) throws Throwable {
        Object result = joinPoint.proceed();

        try {
            Long userId = null;
            String userEmail = null;
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.getPrincipal() instanceof SecurityUser secUser) {
                userId = secUser.getUser().getId();
                userEmail = secUser.getUser().getEmail();
            }

            Long entityId = null;
            if (result instanceof org.springframework.data.domain.Persistable<?> p && p.getId() instanceof Long id) {
                entityId = id;
            } else if (result != null) {
                try {
                    var m = result.getClass().getMethod("getId");
                    Object idVal = m.invoke(result);
                    if (idVal instanceof Long l) entityId = l;
                } catch (Exception ignored) {
                }
            }

            String ipAddress = null;
            ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attrs != null) {
                HttpServletRequest request = attrs.getRequest();
                String forwarded = request.getHeader("X-Forwarded-For");
                ipAddress = (forwarded != null && !forwarded.isEmpty())
                        ? forwarded.split(",")[0].trim()
                        : request.getRemoteAddr();
            }

            auditService.log(userId, userEmail, auditable.action(), auditable.entityType(),
                    entityId, null, ipAddress);
        } catch (Exception e) {
            log.warn("Audit logging failed for action {}: {}", auditable.action(), e.getMessage());
        }

        return result;
    }
}
