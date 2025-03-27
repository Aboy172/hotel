package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.kalvin.hotel.common.entity.BaseEntity;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

/**
 * <p>
 * 投诉表：存储用户的投诉信息
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("complaints")
public class Complaints extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 投诉ID
     */
    @TableId(value = "complaint_id", type = IdType.AUTO)
    private Long complaintId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 酒店ID
     */
    private Long hotelId;

    /**
     * 投诉内容
     */
    private String description;

    /**
     * 投诉状态
     */
    private Integer status;

    /**
     * 投诉提交时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

}
