package com.dunnas.desafio.ticket.specification;

import com.dunnas.desafio.ticket.dto.TicketFilterDto;
import com.dunnas.desafio.ticket.entity.Ticket;

import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class TicketSpecification {

    public static Specification<Ticket> build(TicketFilterDto filter) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (filter.getStatusId() != null) {
                predicates.add(cb.equal(root.get("status").get("id"), filter.getStatusId()));
            }
            if (filter.getTypeId() != null) {
                predicates.add(cb.equal(root.get("type").get("id"), filter.getTypeId()));
            }
            if (filter.getUnitId() != null) {
                predicates.add(cb.equal(root.get("unit").get("id"), filter.getUnitId()));
            }
            if (filter.getKeyword() != null && !filter.getKeyword().isBlank()) {
                String like = "%" + filter.getKeyword().toLowerCase() + "%";
                predicates.add(cb.or(
                    cb.like(cb.lower(root.get("title")), like),
                    cb.like(cb.lower(root.get("description")), like)
                ));
            }
            if (filter.getStartDate() != null) {
                predicates.add(cb.greaterThanOrEqualTo(
                    root.get("createdAt").as(java.time.LocalDate.class),
                    filter.getStartDate()
                ));
            }
            if (filter.getEndDate() != null) {
                predicates.add(cb.lessThanOrEqualTo(
                    root.get("createdAt").as(java.time.LocalDate.class),
                    filter.getEndDate()
                ));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
