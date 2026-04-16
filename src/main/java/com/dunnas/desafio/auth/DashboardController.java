package com.dunnas.desafio.auth;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dunnas.desafio.block.repository.BlockRepository;
import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.security.SecurityUser;
import com.dunnas.desafio.ticket.repository.TicketRepository;
import com.dunnas.desafio.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final UserRepository userRepository;
    private final BlockRepository blockRepository;
    private final UnitRepository unitRepository;
    private final TicketRepository ticketRepository;

    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        model.addAttribute("pageTitle", "Dashboard");
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalBlocks", blockRepository.count());
        model.addAttribute("totalUnits", unitRepository.count());
        model.addAttribute("totalTickets", ticketRepository.count());
        model.addAttribute("openTickets", ticketRepository.countByStatusIsFinalFalse());
        return "admin/dashboard";
    }

    @GetMapping("/staff/dashboard")
    public String staffDashboard(Model model) {
        model.addAttribute("pageTitle", "Dashboard");
        model.addAttribute("totalTickets", ticketRepository.count());
        model.addAttribute("openTickets", ticketRepository.countByStatusIsFinalFalse());
        return "staff/dashboard";
    }

    @GetMapping("/resident/dashboard")
    public String residentDashboard(@AuthenticationPrincipal SecurityUser actor, Model model) {
        Long userId = actor.getUser().getId();
        model.addAttribute("pageTitle", "Dashboard");
        model.addAttribute("userName", actor.getUser().getName());
        model.addAttribute("myTickets", ticketRepository.countByCreatorId(userId));
        model.addAttribute("myOpenTickets", ticketRepository.countByCreatorIdAndStatusIsFinalFalse(userId));
        return "resident/dashboard";
    }
}
