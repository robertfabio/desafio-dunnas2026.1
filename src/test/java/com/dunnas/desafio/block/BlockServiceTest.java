package com.dunnas.desafio.block;

import com.dunnas.desafio.block.dto.BlockFormDto;
import com.dunnas.desafio.block.entity.Block;
import com.dunnas.desafio.block.entity.Unit;
import com.dunnas.desafio.block.repository.BlockRepository;
import com.dunnas.desafio.block.repository.UnitRepository;
import com.dunnas.desafio.block.service.BlockService;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BlockServiceTest {

    @Mock
    private BlockRepository blockRepository;

    @Mock
    private UnitRepository unitRepository;

    @InjectMocks
    private BlockService blockService;

    private BlockFormDto dto;

    @BeforeEach
    void setUp() {
        dto = new BlockFormDto();
        dto.setName("A");
        dto.setFloors(3);
        dto.setUnitsPerFloor(4);
    }

    @Test
    void create_shouldGenerateCorrectNumberOfUnits() {
        when(blockRepository.existsByName("A")).thenReturn(false);
        Block savedBlock = Block.builder().id(1L).name("A").floors(3).unitsPerFloor(4).build();
        when(blockRepository.save(any(Block.class))).thenReturn(savedBlock);
        when(unitRepository.saveAll(any())).thenReturn(List.of());

        blockService.create(dto);

        @SuppressWarnings("unchecked")
        ArgumentCaptor<List<Unit>> captor = ArgumentCaptor.forClass(List.class);
        verify(unitRepository).saveAll(captor.capture());
        assertThat(captor.getValue()).hasSize(12);
    }

    @Test
    void create_shouldGenerateCorrectIdentifiers() {
        when(blockRepository.existsByName("A")).thenReturn(false);
        Block savedBlock = Block.builder().id(1L).name("A").floors(2).unitsPerFloor(3).build();
        when(blockRepository.save(any(Block.class))).thenReturn(savedBlock);
        when(unitRepository.saveAll(any())).thenReturn(List.of());

        dto.setFloors(2);
        dto.setUnitsPerFloor(3);
        blockService.create(dto);

        @SuppressWarnings("unchecked")
        ArgumentCaptor<List<Unit>> captor = ArgumentCaptor.forClass(List.class);
        verify(unitRepository).saveAll(captor.capture());

        List<Unit> units = captor.getValue();
        List<String> identifiers = units.stream().map(Unit::getIdentifier).toList();
        assertThat(identifiers).containsExactly("A-101", "A-102", "A-103", "A-201", "A-202", "A-203");
    }

    @Test
    void create_shouldThrowWhenNameAlreadyExists() {
        when(blockRepository.existsByName("A")).thenReturn(true);

        assertThatThrownBy(() -> blockService.create(dto))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessageContaining("A");

        verify(blockRepository, never()).save(any());
        verify(unitRepository, never()).saveAll(any());
    }

    @Test
    void delete_shouldThrowWhenBlockNotFound() {
        when(blockRepository.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> blockService.delete(99L))
            .isInstanceOf(IllegalArgumentException.class);
    }
}
