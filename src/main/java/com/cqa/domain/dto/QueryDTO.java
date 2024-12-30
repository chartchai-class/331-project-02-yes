package com.cqa.domain.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class QueryDTO {
    @TableField(exist = false)
    private Long pageNum;
    @TableField(exist = false)
    private Long pageSize;
    @TableField(exist = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date queryStartTime;
    @TableField(exist = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date queryEndTime;
}
