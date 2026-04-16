package com.dunnas.desafio.ticket.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.dunnas.desafio.ticket.entity.Ticket;

public interface TicketRepository extends JpaRepository<Ticket, Long>, JpaSpecificationExecutor<Ticket> {

    long countByStatusIsFinalFalse();

    long countByCreatorId(Long creatorId);

    long countByCreatorIdAndStatusIsFinalFalse(Long creatorId);
}
