package com.dunnas.desafio.block.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dunnas.desafio.block.entity.Block;

public interface BlockRepository extends JpaRepository<Block, Long> {
    boolean existsByName(String name);
}
