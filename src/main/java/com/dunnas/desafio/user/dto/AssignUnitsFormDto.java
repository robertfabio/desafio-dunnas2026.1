package com.dunnas.desafio.user.dto;

import java.util.ArrayList;
import java.util.List;

public class AssignUnitsFormDto {

    private List<Long> unitIds = new ArrayList<>();

    public List<Long> getUnitIds() {
        return unitIds;
    }

    public void setUnitIds(List<Long> unitIds) {
        this.unitIds = unitIds;
    }
}
