package com.dunnas.desafio.ticket;

import com.dunnas.desafio.block.entity.Unit;
import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.security.SecurityUser;
import com.dunnas.desafio.ticket.dto.TicketFormDto;
import com.dunnas.desafio.ticket.entity.Ticket;
import com.dunnas.desafio.ticket.entity.TicketStatus;
import com.dunnas.desafio.ticket.entity.TicketType;
import com.dunnas.desafio.ticket.repository.TicketAttachmentRepository;
import com.dunnas.desafio.ticket.repository.TicketRepository;
import com.dunnas.desafio.ticket.repository.TicketStatusRepository;
import com.dunnas.desafio.ticket.repository.TicketTypeRepository;
import com.dunnas.desafio.ticket.service.FileStorageService;
import com.dunnas.desafio.ticket.service.TicketService;
import com.dunnas.desafio.user.entity.Role;
import com.dunnas.desafio.user.entity.User;
import com.dunnas.desafio.user.repository.UserRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TicketServiceTest {

    @Mock private TicketRepository ticketRepository;
    @Mock private TicketStatusRepository ticketStatusRepository;
    @Mock private TicketTypeRepository ticketTypeRepository;
    @Mock private UnitRepository unitRepository;
    @Mock private UserRepository userRepository;
    @Mock private TicketAttachmentRepository ticketAttachmentRepository;
    @Mock private FileStorageService fileStorageService;

    @InjectMocks
    private TicketService ticketService;

    private TicketStatus openStatus;
    private TicketStatus finalStatus;
    private TicketStatus nonFinalStatus;
    private TicketType ticketType;
    private Unit unit;
    private User creator;
    private SecurityUser actor;

    @BeforeEach
    void setUp() {
        openStatus = TicketStatus.builder()
                .id(1L).name("Aberto").isDefault(true).isFinal(false).build();
        finalStatus = TicketStatus.builder()
                .id(4L).name("Concluído").isDefault(false).isFinal(true).build();
        nonFinalStatus = TicketStatus.builder()
                .id(2L).name("Em Andamento").isDefault(false).isFinal(false).build();

        ticketType = TicketType.builder().id(1L).title("Manutenção").slaHours(48).build();
        unit = Unit.builder().id(1L).identifier("A-101").floor(1).number(1).build();

        creator = User.builder()
                .id(1L).name("Morador").email("morador@test.com")
                .passwordHash("hash").role(Role.RESIDENT).build();

        actor = new SecurityUser(creator);
    }

    @Test
    void create_shouldAssignDefaultStatusToNewTicket() {
        TicketFormDto dto = new TicketFormDto();
        dto.setTitle("Torneira com vazamento");
        dto.setDescription("Cozinha");
        dto.setUnitId(1L);
        dto.setTypeId(1L);

        when(ticketStatusRepository.findByIsDefaultTrue()).thenReturn(Optional.of(openStatus));
        when(unitRepository.findById(1L)).thenReturn(Optional.of(unit));
        when(ticketTypeRepository.findById(1L)).thenReturn(Optional.of(ticketType));
        when(userRepository.findById(1L)).thenReturn(Optional.of(creator));
        when(ticketRepository.save(any(Ticket.class))).thenAnswer(inv -> inv.getArgument(0));

        Ticket created = ticketService.create(dto, actor);

        assertThat(created.getStatus()).isEqualTo(openStatus);
        assertThat(created.getConcludedAt()).isNull();
    }

    @Test
    void updateStatus_toFinalStatus_shouldSetConcludedAt() {
        Ticket ticket = Ticket.builder()
                .id(1L).title("Título").unit(unit).type(ticketType)
                .status(openStatus).creator(creator).build();

        when(ticketRepository.findById(1L)).thenReturn(Optional.of(ticket));
        when(ticketStatusRepository.findById(4L)).thenReturn(Optional.of(finalStatus));
        when(ticketRepository.save(any(Ticket.class))).thenAnswer(inv -> inv.getArgument(0));

        Ticket updated = ticketService.updateStatus(1L, 4L);

        assertThat(updated.getStatus()).isEqualTo(finalStatus);
        assertThat(updated.getConcludedAt()).isNotNull();
        assertThat(updated.getConcludedAt()).isBefore(LocalDateTime.now().plusSeconds(1));
    }

    @Test
    void updateStatus_fromFinalToNonFinal_shouldClearConcludedAt() {
        Ticket ticket = Ticket.builder()
                .id(1L).title("Título").unit(unit).type(ticketType)
                .status(finalStatus).creator(creator)
                .concludedAt(LocalDateTime.now().minusHours(1)).build();

        when(ticketRepository.findById(1L)).thenReturn(Optional.of(ticket));
        when(ticketStatusRepository.findById(2L)).thenReturn(Optional.of(nonFinalStatus));
        when(ticketRepository.save(any(Ticket.class))).thenAnswer(inv -> inv.getArgument(0));

        Ticket updated = ticketService.updateStatus(1L, 2L);

        assertThat(updated.getStatus()).isEqualTo(nonFinalStatus);
        assertThat(updated.getConcludedAt()).isNull();
    }
}
