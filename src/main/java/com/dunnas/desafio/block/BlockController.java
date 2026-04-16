package com.dunnas.desafio.block;

import com.dunnas.desafio.block.dto.BlockFormDto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/blocks")
@RequiredArgsConstructor
public class BlockController {

    private final BlockService blockService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("blocks", blockService.findAll());
        model.addAttribute("pageTitle", "Blocos");
        return "admin/blocks/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("blockForm", new BlockFormDto());
        model.addAttribute("pageTitle", "Novo Bloco");
        return "admin/blocks/form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("blockForm") BlockFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("pageTitle", "Novo Bloco");
            return "admin/blocks/form";
        }
        try {
            blockService.create(dto);
            redirect.addFlashAttribute("successMessage", "Bloco criado com sucesso.");
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("pageTitle", "Novo Bloco");
            return "admin/blocks/form";
        }
        return "redirect:/admin/blocks";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Block block = blockService.findById(id);
        BlockFormDto dto = new BlockFormDto();
        dto.setName(block.getName());
        dto.setFloors(block.getFloors());
        dto.setUnitsPerFloor(block.getUnitsPerFloor());
        model.addAttribute("blockForm", dto);
        model.addAttribute("blockId", id);
        model.addAttribute("pageTitle", "Editar Bloco");
        return "admin/blocks/form";
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("blockForm") BlockFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("blockId", id);
            model.addAttribute("pageTitle", "Editar Bloco");
            return "admin/blocks/form";
        }
        blockService.update(id, dto);
        redirect.addFlashAttribute("successMessage", "Bloco atualizado com sucesso.");
        return "redirect:/admin/blocks";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            blockService.delete(id);
            redirect.addFlashAttribute("successMessage", "Bloco removido com sucesso.");
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Não foi possível remover o bloco: " + e.getMessage());
        }
        return "redirect:/admin/blocks";
    }
}
