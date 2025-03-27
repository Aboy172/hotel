package com.kalvin.hotel.modules.hotels.api;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.common.utils.ShiroKit;
import com.kalvin.hotel.modules.hotels.entity.*;
import com.kalvin.hotel.modules.hotels.service.*;
import com.kalvin.hotel.modules.hotels.vo.CheckOutVo;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * @author: cym
 * @create: 2024-10-27 00:10
 * @description:
 * @version: 0.0.1
 **/
@RestController
@RequestMapping("/user/order")
public class OrderApiController extends BaseController {

    private final ReservationsService reservationsService;

    private final RoomsService roomsService;

    private final InsService insService;

    private final OutSettlementsService outSettlementsService;

    private final ReviewsService reviewsService;

    private final HotelsService hotelsService;


    public OrderApiController(ReservationsService reservationsService, RoomsService roomsService, InsService insService, OutSettlementsService outSettlementsService, ReviewsService reviewsService, HotelsService hotelsService) {
        this.reservationsService = reservationsService;
        this.roomsService = roomsService;
        this.insService = insService;
        this.outSettlementsService = outSettlementsService;
        this.reviewsService = reviewsService;
        this.hotelsService = hotelsService;
    }

    @RequestMapping("getList")
    public R getList(Reservations reservations) {
        Page<Reservations> reservationsPage = reservationsService.getList(reservations);
        return R.ok(reservationsPage);
    }

    @PostMapping("/reservation")
    public R reservation(@RequestBody  Reservations reservations) {

        roomsService.reservation(reservations);


        return R.ok();
    }

    @PostMapping("/checkOut")
    public R checkOut(@RequestBody CheckOutVo outVo) {
        Long userId = ShiroKit.getUserId();
        Ins ins = new Ins();
        ins.setReservationId(outVo.getReservationId());
        ins.setUserId(userId);
        ins.setRoomId(outVo.getRoomId());
        ins.setCheckInDate(outVo.getCheckInDate().atStartOfDay());
        ins.setCheckOutDate(outVo.getCheckOutDate().atStartOfDay());
        ins.setTotalCost(outVo.getTotalPrice());
        ins.setStatus(2);
        insService.save(ins);
        OutSettlements outSettlements = new OutSettlements();
        outSettlements.setUserId(userId);
        outSettlements.setReservationId(outVo.getReservationId());
        outSettlements.setTotalAmount(outVo.getTotalPrice());
        outSettlements.setPaid(2);
        outSettlements.setCreatedAt(LocalDateTime.now());

        outSettlementsService.save(outSettlements);
        LambdaUpdateWrapper<Reservations> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Reservations::getReservationId, outVo.getReservationId());
        wrapper.set(Reservations::getStatus, 2);
        reservationsService.update(wrapper);
        LambdaUpdateWrapper<Rooms> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(Rooms::getRoomId, outVo.getRoomId());
        updateWrapper.set(Rooms::getStatus, 0);
        roomsService.update(updateWrapper);
        return R.ok();

    }

    @PostMapping("/evaluate")
    public R checkOut(Reviews reviews) {
        Long userId = ShiroKit.getUserId();
        reviews.setUserId(userId);
        reviewsService.save(reviews);
        LambdaUpdateWrapper<Ins> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Ins::getRoomId, reviews.getRoomId());
        wrapper.eq(Ins::getUserId, userId);
        wrapper.eq(Ins::getReservationId, reviews.getReservationId());
        wrapper.set(Ins::getStatus, 3);
        insService.update(wrapper);
        LambdaUpdateWrapper<Reservations> wrapper1 = new LambdaUpdateWrapper<>();
        wrapper1.eq(Reservations::getReservationId, reviews.getReservationId());
        wrapper1.eq(Reservations::getUserId, userId);
        wrapper1.eq(Reservations::getRoomId, reviews.getRoomId());
        wrapper1.set(Reservations::getStatus, 3);
        reservationsService.update(wrapper1);
        //重新分配酒店评分
        List<Reviews> list = reviewsService.list(new LambdaQueryWrapper<Reviews>().eq(Reviews::getHotelId, reviews.getHotelId()));
        Optional<BigDecimal> optionalBigDecimal = list.stream().map(Reviews::getRating).reduce(BigDecimal::add);
        if (optionalBigDecimal.isPresent()) {
            BigDecimal allRating = optionalBigDecimal.get();
            BigDecimal averageRating = allRating.divide(
                    new BigDecimal(list.size()), 2, RoundingMode.HALF_UP
            );
            hotelsService.update(new LambdaUpdateWrapper<Hotels>().eq(Hotels::getHotelId, reviews.getHotelId()).set(Hotels::getRating, averageRating));
        }
        return R.ok();
    }


}
