package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
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
 * 酒店通知表：存储酒店发布的通知信息
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("hotel_notifications")
public class Notifications extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 通知ID
     */
    @TableId(value = "notification_id", type = IdType.AUTO)
    private Long notificationId;

    /**
     * 酒店ID
     */
    private Long hotelId;

    /**
     * 通知内容
     */
    private String message;

    @TableField(exist = false)
    private Hotels hotels;

    /**
     * 通知发布时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

}
