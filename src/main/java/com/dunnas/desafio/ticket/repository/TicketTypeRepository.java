package com.dunnas.desafio.ticket.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.desafio.ticket.entity.TicketType;

import java.util.List;

public interface TicketTypeRepository extends JpaRepository<TicketType, Long> {
    boolean existsByTitle(String title);
    List<TicketType> findAllByActiveTrue();
}
