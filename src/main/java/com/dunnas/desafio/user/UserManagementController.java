package com.dunnas.desafio.user;

import com.dunnas.desafio.user.dto.AssignUnitsFormDto;
import com.dunnas.desafio.user.dto.UserFormDto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/users")
@RequiredArgsConstructor
public class UserManagementController {

    private final UserService userService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("users", userService.findAll());
        model.addAttribute("pageTitle", "Usuários");
        return "admin/users/list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("userForm", new UserFormDto());
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageTitle", "Novo Usuário");
        return "admin/users/form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("userForm") UserFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("roles", Role.values());
            model.addAttribute("pageTitle", "Novo Usuário");
            return "admin/users/form";
        }
        try {
            userService.create(dto);
            redirect.addFlashAttribute("successMessage", "Usuário criado com sucesso.");
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("roles", Role.values());
            model.addAttribute("pageTitle", "Novo Usuário");
            return "admin/users/form";
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        User user = userService.findById(id);
        UserFormDto dto = new UserFormDto();
        dto.setName(user.getName());
        dto.setEmail(user.getEmail());
        dto.setRole(user.getRole());
        model.addAttribute("userForm", dto);
        model.addAttribute("userId", id);
        model.addAttribute("roles", Role.values());
        model.addAttribute("pageTitle", "Editar Usuário");
        return "admin/users/form";
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("userForm") UserFormDto dto,
                         BindingResult binding,
                         Model model,
                         RedirectAttributes redirect) {
        if (binding.hasErrors()) {
            model.addAttribute("userId", id);
            model.addAttribute("roles", Role.values());
            model.addAttribute("pageTitle", "Editar Usuário");
            return "admin/users/form";
        }
        userService.update(id, dto);
        redirect.addFlashAttribute("successMessage", "Usuário atualizado com sucesso.");
        return "redirect:/admin/users";
    }

    @PostMapping("/{id}/toggle-active")
    public String toggleActive(@PathVariable Long id, RedirectAttributes redirect) {
        userService.toggleActive(id);
        redirect.addFlashAttribute("successMessage", "Status do usuário alterado.");
        return "redirect:/admin/users";
    }

    @GetMapping("/{id}/assign-units")
    public String assignUnitsForm(@PathVariable Long id, Model model) {
        User user = userService.findById(id);
        AssignUnitsFormDto form = new AssignUnitsFormDto();
        form.setUnitIds(user.getUnits().stream()
            .map(u -> u.getId()).collect(java.util.stream.Collectors.toList()));
        model.addAttribute("assignForm", form);
        model.addAttribute("user", user);
        model.addAttribute("allUnits", userService.findAllUnits());
        model.addAttribute("pageTitle", "Unidades do Morador");
        return "admin/users/assign-units";
    }

    @PostMapping("/{id}/assign-units")
    public String assignUnits(@PathVariable Long id,
                              @ModelAttribute("assignForm") AssignUnitsFormDto form,
                              RedirectAttributes redirect) {
        userService.assignUnits(id, form.getUnitIds());
        redirect.addFlashAttribute("successMessage", "Unidades atualizadas com sucesso.");
        return "redirect:/admin/users";
    }
}
