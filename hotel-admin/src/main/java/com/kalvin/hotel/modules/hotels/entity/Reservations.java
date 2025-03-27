package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kalvin.hotel.common.entity.BaseEntity;
import com.kalvin.hotel.modules.hotels.enums.SettlementEnum;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * <p>
 * 预定表：存储用户的房间预定信息
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("reservations")
public class Reservations extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 预定ID
     */
    @TableId(value = "reservation_id", type = IdType.AUTO)
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
     * 入住日期
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkInDate;

    /**
     * 退房日期
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOutDate;

    /**
     * 预定状态
     */
    private SettlementEnum status;

    /**
     * 预定总金额
     */
    private BigDecimal totalPrice;

    @TableField(exist = false)
    private String hotelName;

    @TableField(exist = false)
    private String typeName;
    @TableField(exist = false)
    private  Integer days;
    @TableField(exist = false)
    private  Long hotelId;



    /**
     * 预定创建时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

}
