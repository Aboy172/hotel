package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kalvin.hotel.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 入住管理表：记录用户的实际入住和退房信息
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("check_ins")
public class Ins extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 入住ID
     */
    @TableId(value = "check_in_id", type = IdType.AUTO)
    private Long checkInId;

    /**
     * 预定ID
     */
    private Long reservationId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 客房ID
     */
    private Long roomId;

    /**
     * 实际入住时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime checkInDate;

    /**
     * 实际退房时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime checkOutDate;

    /**
     * 总费用
     */
    private BigDecimal totalCost;

    /**
     * 入住状态
     */
    private Integer status;

}
