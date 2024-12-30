package com.cqa.domain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.cqa.domain.dto.QueryDTO;
import lombok.Data;

import java.util.List;

@Data
@TableName(value = "countries")
public class Countries extends QueryDTO {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "country")
    private String country;

    @TableField(value = "description")
    private String description;


    @TableField(value = "icon")
    private String icon;

    @TableField(exist = false)
    private List<Sports> sportsList;

    @TableField(exist = false)
    private Integer gold;

    @TableField(exist = false)
    private Integer silver;

    @TableField(exist = false)
    private Integer bronze;
}