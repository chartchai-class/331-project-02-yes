package com.cqa.domain.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
@Schema(description = "注册表单")
public class RegisterForm {
    @NotBlank(message = "用户名不能为空")
    @Schema(description = "姓名")
    private String userName;

    @NotBlank(message = "密码不能为空")
    @Schema(description = "密码")
    private String password;

    @NotBlank(message = "头像不能为空")
    @Schema(description = "头像")
    private String avatar;

}
