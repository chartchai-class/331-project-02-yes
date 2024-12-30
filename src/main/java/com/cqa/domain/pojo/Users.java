package com.cqa.domain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;

import com.cqa.domain.dto.QueryDTO;
import lombok.Data;

@Data
@TableName(value = "users")
public class Users extends QueryDTO {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "user_name")
    private String userName;

    @TableField(value = "`password`")
    private String password;

    @TableField(value = "avatar")
    private String avatar;

    @TableField(value = "`type`")
    private String type;

    @TableField(value = "create_time")
    private Date createTime;
}