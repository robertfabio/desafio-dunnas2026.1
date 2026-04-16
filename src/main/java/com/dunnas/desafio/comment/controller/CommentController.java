package com.dunnas.desafio.comment.controller;

import com.dunnas.desafio.comment.dto.CommentFormDto;
import com.dunnas.desafio.comment.service.CommentService;
import com.dunnas.desafio.security.SecurityUser;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @PostMapping({"/resident/tickets/{id}/comments", "/staff/tickets/{id}/comments"})
    public String addComment(@PathVariable Long id,
                             @Valid @ModelAttribute CommentFormDto dto,
                             @AuthenticationPrincipal SecurityUser actor,
                             RedirectAttributes redirect) {
        try {
            commentService.addComment(id, dto, actor);
            redirect.addFlashAttribute("successMessage", "Comentário adicionado.");
        } catch (AccessDeniedException e) {
            redirect.addFlashAttribute("errorMessage", e.getMessage());
        }

        String referer = actor.getUser().getRole().name().equals("RESIDENT")
                ? "/resident/tickets/" + id
                : "/staff/tickets/" + id;
        return "redirect:" + referer;
    }
}
