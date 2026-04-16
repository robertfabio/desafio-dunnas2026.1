package com.dunnas.desafio.ticket;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TicketTypeRepository extends JpaRepository<TicketType, Long> {
    boolean existsByTitle(String title);
    List<TicketType> findAllByActiveTrue();
}
