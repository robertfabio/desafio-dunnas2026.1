package com.dunnas.desafio.audit.service;

import com.dunnas.desafio.audit.entity.AuditLog;
import com.dunnas.desafio.audit.repository.AuditLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuditService {

    private final AuditLogRepository auditLogRepository;

    public void log(Long userId, String userEmail, String action, String entityType,
                    Long entityId, String details, String ipAddress) {
        AuditLog log = AuditLog.builder()
                .userId(userId)
                .userEmail(userEmail)
                .action(action)
                .entityType(entityType)
                .entityId(entityId)
                .details(details)
                .ipAddress(ipAddress)
                .build();
        auditLogRepository.save(log);
    }
}
