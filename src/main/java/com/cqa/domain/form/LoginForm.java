package com.cqa.domain.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
@Schema(description = "登陆表单类")
public class LoginForm {
    @NotBlank(message = "用户名不能为空")
    @Schema(description = "用户名")
    private String userName;

    @NotBlank(message = "密码不能为空")
    @Schema(description = "密码")
    private String password;

}

