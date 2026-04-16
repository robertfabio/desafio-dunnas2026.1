package com.dunnas.desafio.block;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BlockRepository extends JpaRepository<Block, Long> {
    boolean existsByName(String name);
}
