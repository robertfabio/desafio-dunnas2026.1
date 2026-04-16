package com.dunnas.desafio.ticket;

import com.dunnas.desafio.block.Unit;
import com.dunnas.desafio.block.UnitRepository;
import com.dunnas.desafio.security.SecurityUser;
import com.dunnas.desafio.ticket.dto.TicketFilterDto;
import com.dunnas.desafio.ticket.dto.TicketFormDto;
import com.dunnas.desafio.ticket.specification.TicketSpecification;
import com.dunnas.desafio.user.User;
import com.dunnas.desafio.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TicketService {

    private final TicketRepository ticketRepository;
    private final TicketStatusRepository ticketStatusRepository;
    private final TicketTypeRepository ticketTypeRepository;
    private final UnitRepository unitRepository;
    private final UserRepository userRepository;
    private final TicketAttachmentRepository ticketAttachmentRepository;
    private final FileStorageService fileStorageService;

    @Transactional(readOnly = true)
    public List<Ticket> findAll() {
        return ticketRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Ticket> findAll(TicketFilterDto filter) {
        return ticketRepository.findAll(TicketSpecification.build(filter));
    }

    @Transactional(readOnly = true)
    public List<Ticket> findByCreator(Long creatorId) {
        return ticketRepository.findAll().stream()
            .filter(t -> t.getCreator().getId().equals(creatorId))
            .toList();
    }

    @Transactional(readOnly = true)
    public Ticket findById(Long id) {
        return ticketRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Chamado não encontrado: " + id));
    }

    @Transactional
    public Ticket create(TicketFormDto dto, SecurityUser actor) {
        TicketStatus defaultStatus = ticketStatusRepository.findByIsDefaultTrue()
            .orElseThrow(() -> new IllegalStateException("Nenhum status padrão configurado."));

        Unit unit = unitRepository.findById(dto.getUnitId())
            .orElseThrow(() -> new IllegalArgumentException("Unidade não encontrada: " + dto.getUnitId()));

        TicketType type = ticketTypeRepository.findById(dto.getTypeId())
            .orElseThrow(() -> new IllegalArgumentException("Tipo não encontrado: " + dto.getTypeId()));

        User creator = userRepository.findById(actor.getUser().getId())
            .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));

        Ticket ticket = Ticket.builder()
            .title(dto.getTitle())
            .description(dto.getDescription())
            .unit(unit)
            .type(type)
            .status(defaultStatus)
            .creator(creator)
            .build();

        ticket = ticketRepository.save(ticket);

        if (dto.getAttachments() != null) {
            for (MultipartFile file : dto.getAttachments()) {
                if (!file.isEmpty()) {
                    String storedFilename = fileStorageService.store(file);
                    TicketAttachment attachment = TicketAttachment.builder()
                        .ticket(ticket)
                        .originalFilename(file.getOriginalFilename())
                        .storedFilename(storedFilename)
                        .contentType(file.getContentType())
                        .fileSize(file.getSize())
                        .build();
                    ticketAttachmentRepository.save(attachment);
                }
            }
        }

        return ticket;
    }

    @Transactional
    public Ticket updateStatus(Long ticketId, Long newStatusId) {
        Ticket ticket = findById(ticketId);
        TicketStatus newStatus = ticketStatusRepository.findById(newStatusId)
            .orElseThrow(() -> new IllegalArgumentException("Status não encontrado: " + newStatusId));

        ticket.setStatus(newStatus);

        if (newStatus.isFinal()) {
            ticket.setConcludedAt(LocalDateTime.now());
        } else {
            ticket.setConcludedAt(null);
        }

        return ticketRepository.save(ticket);
    }
}
