package com.dunnas.desafio.block.service;

import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.block.repository.BlockRepository;
import com.dunnas.desafio.block.entity.Unit;
import com.dunnas.desafio.block.dto.BlockFormDto;
import com.dunnas.desafio.block.entity.Block;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BlockService {

    private final BlockRepository blockRepository;
    private final UnitRepository unitRepository;

    @Transactional(readOnly = true)
    public List<Block> findAll() {
        return blockRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Block findById(Long id) {
        return blockRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Bloco não encontrado: " + id));
    }

    @Transactional
    public Block create(BlockFormDto dto) {
        if (blockRepository.existsByName(dto.getName())) {
            throw new IllegalArgumentException("Já existe um bloco com o nome: " + dto.getName());
        }
        Block block = Block.builder()
            .name(dto.getName())
            .floors(dto.getFloors())
            .unitsPerFloor(dto.getUnitsPerFloor())
            .build();
        block = blockRepository.save(block);
        generateUnits(block);
        return block;
    }

    @Transactional
    public Block update(Long id, BlockFormDto dto) {
        Block block = findById(id);
        block.setName(dto.getName());
        block.setFloors(dto.getFloors());
        block.setUnitsPerFloor(dto.getUnitsPerFloor());
        return blockRepository.save(block);
    }

    @Transactional
    public void delete(Long id) {
        Block block = findById(id);
        blockRepository.delete(block);
    }

    private void generateUnits(Block block) {
        List<Unit> units = new ArrayList<>();
        for (int floor = 1; floor <= block.getFloors(); floor++) {
            for (int num = 1; num <= block.getUnitsPerFloor(); num++) {
                Unit unit = new Unit();
                unit.setBlock(block);
                unit.setFloor(floor);
                unit.setNumber(num);
                unit.setIdentifier(
                    block.getName() + "-" + floor + String.format("%02d", num)
                );
                units.add(unit);
            }
        }
        unitRepository.saveAll(units);
    }
}
