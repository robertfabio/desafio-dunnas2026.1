package com.dunnas.desafio.ticket.controller;

import com.dunnas.desafio.ticket.service.TicketStatusService;
import com.dunnas.desafio.ticket.dto.TicketStatusFormDto;
import com.dunnas.desafio.ticket.entity.TicketStatus;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/ticket-statuses")
@RequiredArgsConstructor
public class TicketStatusController {

    private final TicketStatusService ticketStatusService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("statuses", ticketStatusService.findAll());
        model.addAttribute("pageTitle", "Status de Chamado");
        return "admin/ticket-statuses/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("statusForm", new TicketStatusFormDto());
        model.addAttribute("pageTitle", "Novo Status");
        return "admin/ticket-statuses/form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("statusForm") TicketStatusFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("pageTitle", "Novo Status");
            return "admin/ticket-statuses/form";
        }
        ticketStatusService.create(dto);
        redirect.addFlashAttribute("successMessage", "Status criado com sucesso.");
        return "redirect:/admin/ticket-statuses";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        TicketStatus status = ticketStatusService.findById(id);
        TicketStatusFormDto dto = new TicketStatusFormDto();
        dto.setName(status.getName());
        dto.setColor(status.getColor());
        dto.setDefault(status.isDefault());
        dto.setFinal(status.isFinal());
        dto.setSortOrder(status.getSortOrder());
        model.addAttribute("statusForm", dto);
        model.addAttribute("statusId", id);
        model.addAttribute("pageTitle", "Editar Status");
        return "admin/ticket-statuses/form";
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("statusForm") TicketStatusFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("statusId", id);
            model.addAttribute("pageTitle", "Editar Status");
            return "admin/ticket-statuses/form";
        }
        ticketStatusService.update(id, dto);
        redirect.addFlashAttribute("successMessage", "Status atualizado com sucesso.");
        return "redirect:/admin/ticket-statuses";
    }
}
