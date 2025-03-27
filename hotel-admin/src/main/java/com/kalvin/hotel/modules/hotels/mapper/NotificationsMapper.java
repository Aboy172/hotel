package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.Notifications;

import java.util.List;

/**
 * <p>
 * 酒店通知表：存储酒店发布的通知信息 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface NotificationsMapper extends BaseMapper<Notifications> {

    /**
     * 查询列表(分页)
     * @param notifications 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Notifications> selectNotificationsList(@Param("notifications") Notifications notifications, IPage page);

}
