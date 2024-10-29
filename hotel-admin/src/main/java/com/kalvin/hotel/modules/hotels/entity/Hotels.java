package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.kalvin.hotel.common.entity.BaseEntity;
import java.math.BigDecimal;

/**
 * <p>
 * 酒店表：存储酒店的基本信息
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("hotels")
public class Hotels extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 酒店ID
     */
    @TableId(value = "hotel_id", type = IdType.AUTO)
    private Long hotelId;

    /**
     * 酒店名称
     */
    private String hotelName;
    /**
     * 酒店图片
     */
    private String cover;

    /**
     * 酒店地址
     */
    private String location;

    /**
     * 平均评分
     */
    private BigDecimal rating;

    /**
     * 酒店描述
     */
    private String description;

}
