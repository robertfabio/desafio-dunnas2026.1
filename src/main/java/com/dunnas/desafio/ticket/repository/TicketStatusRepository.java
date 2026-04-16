package com.dunnas.desafio.ticket.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.dunnas.desafio.ticket.entity.TicketStatus;

import java.util.List;
import java.util.Optional;

public interface TicketStatusRepository extends JpaRepository<TicketStatus, Long> {

    List<TicketStatus> findAllByOrderBySortOrderAsc();

    Optional<TicketStatus> findByIsDefaultTrue();

    @Modifying
    @Query("UPDATE TicketStatus s SET s.isDefault = false")
    void clearAllDefaults();
}
