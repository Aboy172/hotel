package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Reservations;
import com.kalvin.hotel.modules.hotels.service.ReservationsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 * <p>
 * 预定表：存储用户的房间预定信息 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("reservations/reservations")
public class ReservationsController extends BaseController {

    @Autowired
    private ReservationsService reservationsService;

    @RequiresPermissions("reservations:reservations:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("reservations/reservations");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long reservationId) {
        ModelAndView mv = new ModelAndView("reservations/reservations_edit");
        Reservations reservations;
        if (reservationId == null) {
            reservations = new Reservations();
        } else {
            reservations = reservationsService.getById(reservationId);
        }
        mv.addObject("editInfo", reservations);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Reservations reservations) {
        Page<Reservations> page = reservationsService.listReservationsPage(reservations);
        return R.ok(page);
    }

    @RequiresPermissions("reservations:reservations:add")
    @PostMapping(value = "add")
    public R add(Reservations reservations) {
        reservationsService.save(reservations);
        return R.ok();
    }

    @RequiresPermissions("reservations:reservations:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("reservationIds") List<Long> reservationIds) {
        reservationsService.removeByIds(reservationIds);
        return R.ok();
    }

    @RequiresPermissions("reservations:reservations:edit")
    @PostMapping(value = "edit")
    public R edit(Reservations reservations) {
        reservationsService.updateById(reservations);
        return R.ok();
    }

    @RequiresPermissions("reservations:reservations:del")
    @PostMapping(value = "del/{reservationId}")
    public R del(@PathVariable Long reservationId) {
        reservationsService.removeById(reservationId);
        return R.ok();
    }

    @GetMapping(value = "get/{reservationId}")
    public R get(@PathVariable Long reservationId) {
        return R.ok(reservationsService.getById(reservationId));
    }

}

