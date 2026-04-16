package com.dunnas.desafio.audit.repository;

import com.dunnas.desafio.audit.entity.AuditLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {
}
