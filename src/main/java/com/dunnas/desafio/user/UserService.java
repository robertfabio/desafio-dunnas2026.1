package com.dunnas.desafio.user;

import com.dunnas.desafio.block.Unit;
import com.dunnas.desafio.block.UnitRepository;
import com.dunnas.desafio.user.dto.UserFormDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UnitRepository unitRepository;
    private final PasswordEncoder passwordEncoder;

    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Transactional(readOnly = true)
    public User findById(Long id) {
        return userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado: " + id));
    }

    @Transactional
    public User create(UserFormDto dto) {
        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new IllegalArgumentException("E-mail já cadastrado: " + dto.getEmail());
        }
        User user = User.builder()
            .name(dto.getName())
            .email(dto.getEmail())
            .passwordHash(passwordEncoder.encode(dto.getPassword()))
            .role(dto.getRole())
            .build();
        return userRepository.save(user);
    }

    @Transactional
    public User update(Long id, UserFormDto dto) {
        User user = findById(id);
        user.setName(dto.getName());
        user.setRole(dto.getRole());
        if (dto.getPassword() != null && !dto.getPassword().isBlank()) {
            user.setPasswordHash(passwordEncoder.encode(dto.getPassword()));
        }
        return userRepository.save(user);
    }

    @Transactional
    public void toggleActive(Long id) {
        User user = findById(id);
        user.setActive(!user.isActive());
        userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public List<Unit> findAllUnits() {
        return unitRepository.findAllWithBlock();
    }

    @Transactional
    public void assignUnits(Long userId, List<Long> unitIds) {
        User user = findById(userId);
        List<Unit> selected = unitIds == null || unitIds.isEmpty()
            ? List.of()
            : unitRepository.findAllById(unitIds);
        user.setUnits(new HashSet<>(selected));
        userRepository.save(user);
    }
}
