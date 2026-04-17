package com.dunnas.desafio.block;

import com.dunnas.desafio.block.dto.BlockFormDto;
import com.dunnas.desafio.block.entity.Block;
import com.dunnas.desafio.block.entity.Unit;
import com.dunnas.desafio.block.repository.BlockRepository;
import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.block.service.BlockService;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.transaction.annotation.Transactional;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
@Testcontainers
@Transactional
class BlockServiceIntegrationTest {

    @Container
    @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @Autowired
    private BlockService blockService;

    @Autowired
    private BlockRepository blockRepository;

    @Autowired
    private UnitRepository unitRepository;

    @Test
    void create_shouldPersistBlockAndGenerateUnitsInDatabase() {
        BlockFormDto dto = new BlockFormDto();
        dto.setName("IT-Bloco-A");
        dto.setFloors(3);
        dto.setUnitsPerFloor(4);

        Block created = blockService.create(dto);

        assertThat(blockRepository.findById(created.getId())).isPresent();

        List<Unit> units = unitRepository.findAll().stream()
                .filter(u -> u.getBlock().getId().equals(created.getId()))
                .toList();
        assertThat(units).hasSize(12);
        assertThat(units).extracting(Unit::getIdentifier)
                .contains("IT-Bloco-A-101", "IT-Bloco-A-204", "IT-Bloco-A-304");
    }

    @Test
    void create_shouldGenerateIdentifiersWithCorrectPattern() {
        BlockFormDto dto = new BlockFormDto();
        dto.setName("IT-Bloco-B");
        dto.setFloors(2);
        dto.setUnitsPerFloor(3);

        Block created = blockService.create(dto);

        List<String> identifiers = unitRepository.findAll().stream()
                .filter(u -> u.getBlock().getId().equals(created.getId()))
                .map(Unit::getIdentifier)
                .sorted()
                .toList();

        assertThat(identifiers).containsExactly(
                "IT-Bloco-B-101", "IT-Bloco-B-102", "IT-Bloco-B-103",
                "IT-Bloco-B-201", "IT-Bloco-B-202", "IT-Bloco-B-203"
        );
    }

    @Test
    void create_shouldThrowWhenBlockNameAlreadyExistsInDatabase() {
        BlockFormDto dto = new BlockFormDto();
        dto.setName("IT-Bloco-Duplicado");
        dto.setFloors(1);
        dto.setUnitsPerFloor(2);

        blockService.create(dto);

        assertThatThrownBy(() -> blockService.create(dto))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("IT-Bloco-Duplicado");
    }
}
