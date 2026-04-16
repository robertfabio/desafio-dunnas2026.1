package com.dunnas.desafio.comment.service;

import com.dunnas.desafio.comment.dto.CommentFormDto;
import com.dunnas.desafio.comment.entity.TicketComment;
import com.dunnas.desafio.comment.repository.TicketCommentRepository;
import com.dunnas.desafio.security.SecurityUser;
import com.dunnas.desafio.ticket.entity.Ticket;
import com.dunnas.desafio.ticket.repository.TicketRepository;
import com.dunnas.desafio.user.entity.Role;
import com.dunnas.desafio.user.entity.User;
import com.dunnas.desafio.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final TicketCommentRepository commentRepository;
    private final TicketRepository ticketRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public List<TicketComment> findByTicket(Long ticketId) {
        return commentRepository.findByTicketIdOrderByCreatedAtAsc(ticketId);
    }

    @Transactional
    public TicketComment addComment(Long ticketId, CommentFormDto dto, SecurityUser actor) {
        Ticket ticket = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new IllegalArgumentException("Chamado não encontrado: " + ticketId));

        User author = userRepository.findById(actor.getUser().getId())
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));

        validateCommentPermission(ticket, author);

        TicketComment comment = TicketComment.builder()
                .ticket(ticket)
                .author(author)
                .content(dto.getContent())
                .build();

        return commentRepository.save(comment);
    }

    private void validateCommentPermission(Ticket ticket, User author) {
        if (author.getRole() == Role.RESIDENT) {
            boolean isOwner = author.getUnits().stream()
                    .anyMatch(u -> u.getId().equals(ticket.getUnit().getId()));
            if (!isOwner) {
                throw new AccessDeniedException("Acesso negado: chamado não pertence às suas unidades.");
            }
        }
    }
}
