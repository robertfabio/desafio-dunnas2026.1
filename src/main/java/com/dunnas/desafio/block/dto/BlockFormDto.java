package com.dunnas.desafio.block.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class BlockFormDto {

    @NotBlank
    private String name;

    @NotNull
    @Min(1)
    private Integer floors;

    @NotNull
    @Min(1)
    private Integer unitsPerFloor;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getFloors() { return floors; }
    public void setFloors(Integer floors) { this.floors = floors; }

    public Integer getUnitsPerFloor() { return unitsPerFloor; }
    public void setUnitsPerFloor(Integer unitsPerFloor) { this.unitsPerFloor = unitsPerFloor; }
}
