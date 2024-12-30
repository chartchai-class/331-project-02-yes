package com.cqa.domain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.cqa.domain.dto.QueryDTO;
import lombok.Data;

@Data
@TableName(value = "sports")
public class Sports extends QueryDTO {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "country_id")
    private Integer countryId;

    @TableField(value = "sport_name")
    private String sportName;

    @TableField(value = "gold")
    private Integer gold;

    @TableField(value = "silver")
    private Integer silver;

    @TableField(value = "bronze")
    private Integer bronze;
}