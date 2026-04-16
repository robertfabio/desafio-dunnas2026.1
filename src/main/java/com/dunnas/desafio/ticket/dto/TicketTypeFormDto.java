package com.dunnas.desafio.ticket.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class TicketTypeFormDto {

    @NotBlank
    private String title;

    @NotNull
    @Min(1)
    private Integer slaHours;

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Integer getSlaHours() { return slaHours; }
    public void setSlaHours(Integer slaHours) { this.slaHours = slaHours; }
}
