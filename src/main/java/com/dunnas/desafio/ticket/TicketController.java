package com.dunnas.desafio.ticket;

import com.dunnas.desafio.block.UnitRepository;
import com.dunnas.desafio.security.SecurityUser;
import com.dunnas.desafio.ticket.dto.TicketFilterDto;
import com.dunnas.desafio.ticket.dto.TicketFormDto;
import com.dunnas.desafio.ticket.dto.UpdateStatusFormDto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class TicketController {

    private final TicketService ticketService;
    private final TicketTypeService ticketTypeService;
    private final TicketStatusService ticketStatusService;
    private final UnitRepository unitRepository;

    @GetMapping("/resident/tickets")
    public String residentList(@AuthenticationPrincipal SecurityUser actor, Model model) {
        model.addAttribute("tickets", ticketService.findByCreator(actor.getUser().getId()));
        model.addAttribute("pageTitle", "Meus Chamados");
        return "resident/tickets/list";
    }

    @GetMapping("/resident/tickets/new")
    public String newForm(@AuthenticationPrincipal SecurityUser actor, Model model) {
        model.addAttribute("ticketForm", new TicketFormDto());
        model.addAttribute("units", actor.getUser().getUnits());
        model.addAttribute("types", ticketTypeService.findAllActive());
        model.addAttribute("pageTitle", "Abrir Chamado");
        return "resident/tickets/new";
    }

    @PostMapping("/resident/tickets")
    public String create(@Valid @ModelAttribute("ticketForm") TicketFormDto dto,
                         BindingResult binding,
                         @AuthenticationPrincipal SecurityUser actor,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("units", actor.getUser().getUnits());
            model.addAttribute("types", ticketTypeService.findAllActive());
            model.addAttribute("pageTitle", "Abrir Chamado");
            return "resident/tickets/new";
        }
        try {
            ticketService.create(dto, actor);
            redirect.addFlashAttribute("successMessage", "Chamado aberto com sucesso.");
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("units", actor.getUser().getUnits());
            model.addAttribute("types", ticketTypeService.findAllActive());
            model.addAttribute("pageTitle", "Abrir Chamado");
            return "resident/tickets/new";
        }
        return "redirect:/resident/tickets";
    }

    @GetMapping("/resident/tickets/{id}")
    public String residentDetail(@PathVariable Long id,
                                 @AuthenticationPrincipal SecurityUser actor,
                                 Model model) {
        Ticket ticket = ticketService.findById(id);
        model.addAttribute("ticket", ticket);
        model.addAttribute("pageTitle", "Chamado #" + id);
        return "resident/tickets/detail";
    }

    @GetMapping("/staff/tickets")
    public String staffList(@ModelAttribute TicketFilterDto filter, Model model) {
        model.addAttribute("tickets", ticketService.findAll(filter));
        model.addAttribute("filter", filter);
        model.addAttribute("statuses", ticketStatusService.findAll());
        model.addAttribute("types", ticketTypeService.findAll());
        model.addAttribute("pageTitle", "Fila de Chamados");
        return "staff/tickets/list";
    }

    @GetMapping("/staff/tickets/{id}")
    public String staffDetail(@PathVariable Long id, Model model) {
        Ticket ticket = ticketService.findById(id);
        model.addAttribute("ticket", ticket);
        model.addAttribute("statuses", ticketStatusService.findAll());
        model.addAttribute("updateStatusForm", new UpdateStatusFormDto());
        model.addAttribute("pageTitle", "Chamado #" + id);
        return "staff/tickets/detail";
    }

    @PostMapping("/staff/tickets/{id}/status")
    public String updateStatus(@PathVariable Long id,
                               @ModelAttribute UpdateStatusFormDto dto,
                               RedirectAttributes redirect) {
        ticketService.updateStatus(id, dto.getStatusId());
        redirect.addFlashAttribute("successMessage", "Status atualizado com sucesso.");
        return "redirect:/staff/tickets/" + id;
    }
}
