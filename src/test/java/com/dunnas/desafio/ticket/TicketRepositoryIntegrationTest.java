package com.dunnas.desafio.ticket;

import com.dunnas.desafio.block.entity.Block;
import com.dunnas.desafio.block.entity.Unit;
import com.dunnas.desafio.block.repository.BlockRepository;
import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.ticket.entity.Ticket;
import com.dunnas.desafio.ticket.entity.TicketStatus;
import com.dunnas.desafio.ticket.entity.TicketType;
import com.dunnas.desafio.ticket.repository.TicketRepository;
import com.dunnas.desafio.ticket.repository.TicketStatusRepository;
import com.dunnas.desafio.ticket.repository.TicketTypeRepository;
import com.dunnas.desafio.user.entity.Role;
import com.dunnas.desafio.user.entity.User;
import com.dunnas.desafio.user.repository.UserRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.transaction.annotation.Transactional;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
@Testcontainers
@Transactional
class TicketRepositoryIntegrationTest {

    @Container
    @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private TicketStatusRepository ticketStatusRepository;

    @Autowired
    private TicketTypeRepository ticketTypeRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlockRepository blockRepository;

    @Autowired
    private UnitRepository unitRepository;

    private User creator;
    private User otherUser;
    private TicketStatus openStatus;
    private TicketStatus finalStatus;
    private TicketType type;
    private Unit unit;

    @BeforeEach
    void setUp() {
        openStatus = ticketStatusRepository.findByIsDefaultTrue().orElseThrow();
        finalStatus = ticketStatusRepository.findAll().stream()
                .filter(TicketStatus::isFinal)
                .findFirst()
                .orElseThrow();
        type = ticketTypeRepository.findAll().getFirst();

        Block block = blockRepository.save(Block.builder()
                .name("IT-Bloco-Tickets").floors(1).unitsPerFloor(2).build());
        unit = unitRepository.save(Unit.builder()
                .identifier("IT-TK-101").floor(1).number(1).block(block).build());

        creator = userRepository.save(User.builder()
                .name("IT Creator").email("it-creator@dunnas.test")
                .passwordHash("$2a$10$placeholder").role(Role.RESIDENT).build());
        otherUser = userRepository.save(User.builder()
                .name("IT Other").email("it-other@dunnas.test")
                .passwordHash("$2a$10$placeholder").role(Role.RESIDENT).build());
    }

    @Test
    void findByCreatorId_shouldReturnOnlyTicketsBelongingToThatCreator() {
        ticketRepository.save(Ticket.builder()
                .title("Ticket do criador").unit(unit).type(type)
                .status(openStatus).creator(creator).build());
        ticketRepository.save(Ticket.builder()
                .title("Ticket do outro usuário").unit(unit).type(type)
                .status(openStatus).creator(otherUser).build());

        List<Ticket> result = ticketRepository.findByCreatorId(creator.getId());

        assertThat(result).hasSize(1);
        assertThat(result.getFirst().getCreator().getId()).isEqualTo(creator.getId());
        assertThat(result.getFirst().getTitle()).isEqualTo("Ticket do criador");
    }

    @Test
    void findByCreatorId_shouldReturnEmptyListWhenCreatorHasNoTickets() {
        ticketRepository.save(Ticket.builder()
                .title("Ticket do outro").unit(unit).type(type)
                .status(openStatus).creator(otherUser).build());

        List<Ticket> result = ticketRepository.findByCreatorId(creator.getId());

        assertThat(result).isEmpty();
    }

    @Test
    void countByStatusIsFinalFalse_shouldCountOnlyNonFinalTickets() {
        long baseCount = ticketRepository.countByStatusIsFinalFalse();

        ticketRepository.save(Ticket.builder()
                .title("Ticket em aberto").unit(unit).type(type)
                .status(openStatus).creator(creator).build());
        ticketRepository.save(Ticket.builder()
                .title("Ticket concluído").unit(unit).type(type)
                .status(finalStatus).creator(creator).build());

        long newCount = ticketRepository.countByStatusIsFinalFalse();
        assertThat(newCount).isEqualTo(baseCount + 1);
    }

    @Test
    void countByCreatorId_shouldReturnTotalTicketsForCreator() {
        ticketRepository.save(Ticket.builder()
                .title("Ticket 1 do criador").unit(unit).type(type)
                .status(openStatus).creator(creator).build());
        ticketRepository.save(Ticket.builder()
                .title("Ticket 2 do criador").unit(unit).type(type)
                .status(finalStatus).creator(creator).build());
        ticketRepository.save(Ticket.builder()
                .title("Ticket do outro").unit(unit).type(type)
                .status(openStatus).creator(otherUser).build());

        assertThat(ticketRepository.countByCreatorId(creator.getId())).isEqualTo(2L);
        assertThat(ticketRepository.countByCreatorId(otherUser.getId())).isEqualTo(1L);
    }

    @Test
    void countByCreatorIdAndStatusIsFinalFalse_shouldCountOnlyOpenTicketsForCreator() {
        ticketRepository.save(Ticket.builder()
                .title("Aberto do criador").unit(unit).type(type)
                .status(openStatus).creator(creator).build());
        ticketRepository.save(Ticket.builder()
                .title("Concluído do criador").unit(unit).type(type)
                .status(finalStatus).creator(creator).build());

        long openCount = ticketRepository.countByCreatorIdAndStatusIsFinalFalse(creator.getId());

        assertThat(openCount).isEqualTo(1L);
    }
}
