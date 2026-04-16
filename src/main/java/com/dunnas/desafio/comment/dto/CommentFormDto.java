package com.dunnas.desafio.comment.dto;

import jakarta.validation.constraints.NotBlank;

public class CommentFormDto {

    @NotBlank(message = "O comentário não pode ser vazio.")
    private String content;

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
}
