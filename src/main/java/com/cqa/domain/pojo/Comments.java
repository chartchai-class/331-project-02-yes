package com.cqa.domain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import lombok.Data;

@Data
@TableName(value = "comments")
public class Comments {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "user_id")
    private Integer userId;

    @TableField(value = "country_id")
    private Integer countryId;

    @TableField(value = "content")
    private String content;

    @TableField(value = "create_time")
    private Date createTime;

    @TableField(exist = false)
    private Users user;;
}