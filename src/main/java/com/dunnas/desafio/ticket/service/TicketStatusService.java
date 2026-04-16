package com.dunnas.desafio.ticket.service;

import com.dunnas.desafio.ticket.repository.TicketStatusRepository;
import com.dunnas.desafio.ticket.dto.TicketStatusFormDto;
import com.dunnas.desafio.ticket.entity.TicketStatus;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TicketStatusService {

    private final TicketStatusRepository ticketStatusRepository;

    @Transactional(readOnly = true)
    public List<TicketStatus> findAll() {
        return ticketStatusRepository.findAllByOrderBySortOrderAsc();
    }

    @Transactional(readOnly = true)
    public TicketStatus findById(Long id) {
        return ticketStatusRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Status não encontrado: " + id));
    }

    @Transactional(readOnly = true)
    public TicketStatus findDefault() {
        return ticketStatusRepository.findByIsDefaultTrue()
            .orElseThrow(() -> new IllegalStateException("Nenhum status padrão configurado."));
    }

    @Transactional
    public TicketStatus create(TicketStatusFormDto dto) {
        if (dto.isDefault()) {
            ticketStatusRepository.clearAllDefaults();
        }
        TicketStatus status = TicketStatus.builder()
            .name(dto.getName())
            .color(dto.getColor())
            .isDefault(dto.isDefault())
            .isFinal(dto.isFinal())
            .sortOrder(dto.getSortOrder())
            .build();
        return ticketStatusRepository.save(status);
    }

    @Transactional
    public TicketStatus update(Long id, TicketStatusFormDto dto) {
        TicketStatus status = findById(id);
        if (dto.isDefault() && !status.isDefault()) {
            ticketStatusRepository.clearAllDefaults();
        }
        status.setName(dto.getName());
        status.setColor(dto.getColor());
        status.setDefault(dto.isDefault());
        status.setFinal(dto.isFinal());
        status.setSortOrder(dto.getSortOrder());
        return ticketStatusRepository.save(status);
    }
}
