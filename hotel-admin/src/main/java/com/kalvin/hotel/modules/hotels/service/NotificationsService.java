package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Notifications;

/**
 * <p>
 * 酒店通知表：存储酒店发布的通知信息 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface NotificationsService extends IService<Notifications> {

    /**
     * 获取列表。分页
     * @param notifications 查询参数
     * @return page
     */
    Page<Notifications> listNotificationsPage(Notifications notifications);

}
