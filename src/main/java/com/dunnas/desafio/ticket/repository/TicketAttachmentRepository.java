package com.dunnas.desafio.ticket.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.desafio.ticket.entity.TicketAttachment;

public interface TicketAttachmentRepository extends JpaRepository<TicketAttachment, Long> {
}
