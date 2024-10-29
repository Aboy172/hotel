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
 * 房间类型表：定义每个酒店的不同房间类型
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("room_types")
public class Types extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 房间类型ID
     */
    @TableId(value = "room_type_id", type = IdType.AUTO)
    private Long roomTypeId;

    /**
     * 酒店ID
     */
    private Long hotelId;

    /**
     * 房间类型名称
     */
    private String typeName;

    /**
     * 房间类型描述
     */
    private String description;

    /**
     * 每晚价格
     */
    private BigDecimal price;

    /**
     * 房间容纳人数
     */
    private Integer capacity;

}
