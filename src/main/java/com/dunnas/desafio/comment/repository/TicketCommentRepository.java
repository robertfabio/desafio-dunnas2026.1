package com.dunnas.desafio.comment.repository;

import com.dunnas.desafio.comment.entity.TicketComment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TicketCommentRepository extends JpaRepository<TicketComment, Long> {

    List<TicketComment> findByTicketIdOrderByCreatedAtAsc(Long ticketId);
}
