package com.dunnas.desafio.ticket.controller;

import com.dunnas.desafio.ticket.service.TicketTypeService;
import com.dunnas.desafio.ticket.dto.TicketTypeFormDto;
import com.dunnas.desafio.ticket.entity.TicketType;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/ticket-types")
@RequiredArgsConstructor
public class TicketTypeController {

    private final TicketTypeService ticketTypeService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("types", ticketTypeService.findAll());
        model.addAttribute("pageTitle", "Tipos de Chamado");
        return "admin/ticket-types/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("typeForm", new TicketTypeFormDto());
        model.addAttribute("pageTitle", "Novo Tipo de Chamado");
        return "admin/ticket-types/form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("typeForm") TicketTypeFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("pageTitle", "Novo Tipo de Chamado");
            return "admin/ticket-types/form";
        }
        try {
            ticketTypeService.create(dto);
            redirect.addFlashAttribute("successMessage", "Tipo criado com sucesso.");
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("pageTitle", "Novo Tipo de Chamado");
            return "admin/ticket-types/form";
        }
        return "redirect:/admin/ticket-types";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        TicketType type = ticketTypeService.findById(id);
        TicketTypeFormDto dto = new TicketTypeFormDto();
        dto.setTitle(type.getTitle());
        dto.setSlaHours(type.getSlaHours());
        model.addAttribute("typeForm", dto);
        model.addAttribute("typeId", id);
        model.addAttribute("pageTitle", "Editar Tipo de Chamado");
        return "admin/ticket-types/form";
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("typeForm") TicketTypeFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("typeId", id);
            model.addAttribute("pageTitle", "Editar Tipo de Chamado");
            return "admin/ticket-types/form";
        }
        ticketTypeService.update(id, dto);
        redirect.addFlashAttribute("successMessage", "Tipo atualizado com sucesso.");
        return "redirect:/admin/ticket-types";
    }

    @PostMapping("/{id}/toggle-active")
    public String toggleActive(@PathVariable Long id, RedirectAttributes redirect) {
        ticketTypeService.toggleActive(id);
        redirect.addFlashAttribute("successMessage", "Status do tipo alterado.");
        return "redirect:/admin/ticket-types";
    }
}
