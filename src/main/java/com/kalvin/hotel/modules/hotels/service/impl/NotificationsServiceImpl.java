package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.modules.hotels.entity.Notifications;
import com.kalvin.hotel.modules.hotels.mapper.HotelsMapper;
import com.kalvin.hotel.modules.hotels.mapper.NotificationsMapper;
import com.kalvin.hotel.modules.hotels.service.NotificationsService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 酒店通知表：存储酒店发布的通知信息 服务实现类
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Service
public class NotificationsServiceImpl extends ServiceImpl<NotificationsMapper, Notifications> implements NotificationsService {


    private  final HotelsMapper hotelsMapper;

    public NotificationsServiceImpl(HotelsMapper hotelsMapper) {
        this.hotelsMapper = hotelsMapper;
    }

    @Override
    public Page<Notifications> listNotificationsPage(Notifications notifications) {
        Page<Notifications> page = new Page<>(notifications.getCurrent(), notifications.getSize());
        List<Notifications> notificationss = baseMapper.selectNotificationsList(notifications, page);
        return page.setRecords(notificationss);
    }

}
