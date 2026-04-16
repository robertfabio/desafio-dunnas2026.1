package com.dunnas.desafio.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        model.addAttribute("pageTitle", "Dashboard");
        return "admin/dashboard";
    }

    @GetMapping("/staff/dashboard")
    public String staffDashboard(Model model) {
        model.addAttribute("pageTitle", "Dashboard");
        return "staff/dashboard";
    }

    @GetMapping("/resident/dashboard")
    public String residentDashboard(Model model) {
        model.addAttribute("pageTitle", "Dashboard");
        return "resident/dashboard";
    }
}
