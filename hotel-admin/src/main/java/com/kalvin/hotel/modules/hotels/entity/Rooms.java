package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kalvin.hotel.common.entity.BaseEntity;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * <p>
 * 客房表：存储各个房间的具体信息及其状态
 * </p>
 *
 * @since 2024-10-21 22:11:26
 */
@Data
@Accessors(chain = true)
@TableName("rooms")
public class Rooms  extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 客房ID
     */
    @TableId(value = "room_id", type = IdType.AUTO)
    private Long roomId;

    /**
     * 房间号码
     */
    private String roomNumber;

    /**
     * 酒店ID
     */
    private Long hotelId;
    /**
     * 客房照片
     */
    private String cover;

    /**
     * 房间类型ID
     */
    private Long roomTypeId;

    /**
     * 房间状态
     */
    private Integer status;

    @TableField(exist = false)
    private Hotels hotels;
    @TableField(exist = false)
    private Types types;
    /**
     * 酒店名称
     */
    @TableField(exist = false)
    private String hotelName;

}
