package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.common.utils.ShiroKit;
import com.kalvin.hotel.modules.hotels.entity.Reservations;
import com.kalvin.hotel.modules.hotels.mapper.ReservationsMapper;
import com.kalvin.hotel.modules.hotels.service.ReservationsService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 预定表：存储用户的房间预定信息 服务实现类
 * </p>
 *
 * @since 2024-10-21 22:11:26
 */
@Service
public class ReservationsServiceImpl extends ServiceImpl<ReservationsMapper, Reservations> implements ReservationsService {

    @Override
    public Page<Reservations> listReservationsPage(Reservations reservations) {
        Page<Reservations> page = new Page<>(reservations.getCurrent(), reservations.getSize());
        List<Reservations> reservationss = baseMapper.selectReservationsList(reservations, page);
        return page.setRecords(reservationss);
    }

    @Override
    public Page<Reservations> getList(Reservations reservations) {
        Long userId = ShiroKit.getUser().getId();
        Page<Reservations> page = new Page<>(reservations.getCurrent(), reservations.getSize());
        List<Reservations> reservationList = baseMapper.selectOrderList(userId,page);
        return page.setRecords(reservationList);
    }

}
