package com.dunnas.desafio.ticket;

import com.dunnas.desafio.ticket.dto.TicketTypeFormDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TicketTypeService {

    private final TicketTypeRepository ticketTypeRepository;

    @Transactional(readOnly = true)
    public List<TicketType> findAll() {
        return ticketTypeRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<TicketType> findAllActive() {
        return ticketTypeRepository.findAllByActiveTrue();
    }

    @Transactional(readOnly = true)
    public TicketType findById(Long id) {
        return ticketTypeRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Tipo de chamado não encontrado: " + id));
    }

    @Transactional
    public TicketType create(TicketTypeFormDto dto) {
        if (ticketTypeRepository.existsByTitle(dto.getTitle())) {
            throw new IllegalArgumentException("Já existe um tipo com o título: " + dto.getTitle());
        }
        TicketType type = TicketType.builder()
            .title(dto.getTitle())
            .slaHours(dto.getSlaHours())
            .build();
        return ticketTypeRepository.save(type);
    }

    @Transactional
    public TicketType update(Long id, TicketTypeFormDto dto) {
        TicketType type = findById(id);
        type.setTitle(dto.getTitle());
        type.setSlaHours(dto.getSlaHours());
        return ticketTypeRepository.save(type);
    }

    @Transactional
    public void toggleActive(Long id) {
        TicketType type = findById(id);
        type.setActive(!type.isActive());
        ticketTypeRepository.save(type);
    }
}
