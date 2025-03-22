package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.common.exception.HotelException;
import com.kalvin.hotel.common.utils.ShiroKit;
import com.kalvin.hotel.modules.hotels.entity.Reservations;
import com.kalvin.hotel.modules.hotels.entity.Rooms;
import com.kalvin.hotel.modules.hotels.enums.SettlementEnum;
import com.kalvin.hotel.modules.hotels.mapper.RoomsMapper;
import com.kalvin.hotel.modules.hotels.service.ReservationsService;
import com.kalvin.hotel.modules.hotels.service.RoomsService;
import com.kalvin.hotel.modules.hotels.vo.RoomsVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 客房表：存储各个房间的具体信息及其状态 服务实现类
 * </p>
 *
 * @since 2024-10-21 22:11:26
 */
@Service
public class RoomsServiceImpl extends ServiceImpl<RoomsMapper, Rooms> implements RoomsService {

    @Resource
    private ReservationsService reservationsService;


    @Override
    public Page<Rooms> listRoomsPage(Rooms rooms) {
        Page<Rooms> page = new Page<>(rooms.getCurrent(), rooms.getSize());
        List<Rooms> roomss = baseMapper.selectRoomsList(rooms, page);
        return page.setRecords(roomss);
    }

    @Override
    public RoomsVo getRoomDetails(Integer roomId) {
        return baseMapper.getRoomDetails(roomId);



    }

    @Override
    public Page<Rooms> query(Rooms rooms) {
        Page<Rooms> page = new Page<>(rooms.getCurrent(), rooms.getSize());
        List<Rooms> roomList = baseMapper.selectRoomsList(rooms, page);
        return page.setRecords(roomList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reservation (Reservations reservations) {
        //修改房间入住状态
        Long roomId = reservations.getRoomId();
        Rooms rooms = this.getById(roomId);
        if (Objects.isNull(rooms)){
            throw new HotelException("房间不存在");
        }
        rooms.setStatus(SettlementEnum.ADD.getCode());
        this.updateById(rooms);
        //新增预定记录
        Long userId = ShiroKit.getUserId();
        reservations.setUserId(userId);
        reservations.setStatus(SettlementEnum.ADD);
        Integer days = reservations.getDays();
        BigDecimal totalPrice = reservations.getTotalPrice();
        BigDecimal daysBigDecimal = BigDecimal.valueOf(days);
        BigDecimal resultPrice = daysBigDecimal.multiply(totalPrice);
        reservations.setTotalPrice(resultPrice);
        reservationsService.save(reservations);
    }

}
