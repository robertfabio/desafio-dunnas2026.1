package com.dunnas.desafio.block;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UnitRepository extends JpaRepository<Unit, Long> {
    List<Unit> findAllByBlockId(Long blockId);

    @Query("SELECT u FROM Unit u JOIN FETCH u.block ORDER BY u.block.name, u.identifier")
    List<Unit> findAllWithBlock();
}
