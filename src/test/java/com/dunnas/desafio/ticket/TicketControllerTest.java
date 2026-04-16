package com.dunnas.desafio.ticket;

import com.dunnas.desafio.security.SecurityUser;
import com.dunnas.desafio.ticket.controller.TicketController;
import com.dunnas.desafio.ticket.entity.Ticket;
import com.dunnas.desafio.ticket.entity.TicketStatus;
import com.dunnas.desafio.ticket.entity.TicketType;
import com.dunnas.desafio.ticket.service.TicketService;
import com.dunnas.desafio.ticket.service.TicketStatusService;
import com.dunnas.desafio.ticket.service.TicketTypeService;
import com.dunnas.desafio.block.entity.Unit;
import com.dunnas.desafio.block.entity.Block;
import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.user.entity.Role;
import com.dunnas.desafio.user.entity.User;

import com.dunnas.desafio.config.SecurityConfig;
import com.dunnas.desafio.security.RoleBasedSuccessHandler;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(TicketController.class)
@Import(SecurityConfig.class)
class TicketControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean private TicketService ticketService;
    @MockBean private TicketTypeService ticketTypeService;
    @MockBean private TicketStatusService ticketStatusService;
    @MockBean private UnitRepository unitRepository;
    @MockBean private RoleBasedSuccessHandler roleBasedSuccessHandler;

    private User residentUser;
    private User collaboratorUser;
    private SecurityUser residentPrincipal;
    private SecurityUser collaboratorPrincipal;
    private Unit unit;
    private TicketType ticketType;
    private TicketStatus openStatus;
    private Ticket ticket;

    @BeforeEach
    void setUp() {
        Block block = Block.builder().id(1L).name("A").floors(3).unitsPerFloor(4).build();
        unit = Unit.builder().id(1L).identifier("A-101").floor(1).number(1).block(block).build();

        residentUser = User.builder()
                .id(1L).name("Morador").email("morador@test.com")
                .passwordHash("hash").role(Role.RESIDENT).active(true)
                .units(new HashSet<>(Set.of(unit))).build();

        collaboratorUser = User.builder()
                .id(2L).name("Colaborador").email("colab@test.com")
                .passwordHash("hash").role(Role.COLLABORATOR).active(true).build();

        residentPrincipal = new SecurityUser(residentUser);
        collaboratorPrincipal = new SecurityUser(collaboratorUser);

        ticketType = TicketType.builder().id(1L).title("Manutenção").slaHours(48).build();
        openStatus = TicketStatus.builder().id(1L).name("Aberto").isDefault(true).isFinal(false).build();

        ticket = Ticket.builder()
                .id(1L).title("Torneira").unit(unit).type(ticketType)
                .status(openStatus).creator(residentUser).build();
    }

    @Test
    void postNewTicket_asResident_shouldRedirectToList() throws Exception {
        when(ticketTypeService.findAllActive()).thenReturn(Collections.emptyList());
        when(ticketService.create(any(), any())).thenReturn(ticket);

        mockMvc.perform(post("/resident/tickets")
                        .with(SecurityMockMvcRequestPostProcessors.user(residentPrincipal))
                        .with(csrf())
                        .param("title", "Torneira com vazamento")
                        .param("description", "Cozinha")
                        .param("unitId", "1")
                        .param("typeId", "1"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/resident/tickets"));

        verify(ticketService).create(any(), any());
    }

    @Test
    void postUpdateStatus_asCollaborator_shouldRedirectToDetail() throws Exception {
        doReturn(ticket).when(ticketService).updateStatus(anyLong(), anyLong());

        mockMvc.perform(post("/staff/tickets/1/status")
                        .with(SecurityMockMvcRequestPostProcessors.user(collaboratorPrincipal))
                        .with(csrf())
                        .param("statusId", "4"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/staff/tickets/1"));

        verify(ticketService).updateStatus(1L, 4L);
    }

    @Test
    void postUpdateStatus_asResident_shouldBeRejected() throws Exception {
        mockMvc.perform(post("/staff/tickets/1/status")
                        .with(SecurityMockMvcRequestPostProcessors.user(residentPrincipal))
                        .with(csrf())
                        .param("statusId", "4"))
                .andExpect(status().isForbidden());

        verify(ticketService, never()).updateStatus(anyLong(), anyLong());
    }
}
