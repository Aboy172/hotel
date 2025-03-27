package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Hotels;
import com.kalvin.hotel.modules.hotels.service.HotelsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 * <p>
 * 酒店表：存储酒店的基本信息 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("hotels/hotels")
public class HotelsController extends BaseController {

    @Autowired
    private HotelsService hotelsService;

    @RequiresPermissions("hotels:hotels:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("hotels/hotels");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long hotelId) {
        ModelAndView mv = new ModelAndView("hotels/hotels_edit");
        Hotels hotels;
        if (hotelId == null) {
            hotels = new Hotels();
        } else {
            hotels = hotelsService.getById(hotelId);
        }
        mv.addObject("editInfo", hotels);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Hotels hotels) {
        Page<Hotels> page = hotelsService.listHotelsPage(hotels);
        return R.ok(page);
    }

    @RequiresPermissions("hotels:hotels:add")
    @PostMapping(value = "add")
    public R add(Hotels hotels) {
        hotelsService.save(hotels);
        return R.ok();
    }

    @RequiresPermissions("hotels:hotels:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("hotelIds") List<Long> hotelIds) {
        hotelsService.removeByIds(hotelIds);
        return R.ok();
    }

    @RequiresPermissions("hotels:hotels:edit")
    @PostMapping(value = "edit")
    public R edit(Hotels hotels) {
        hotelsService.updateById(hotels);
        return R.ok();
    }

    @RequiresPermissions("hotels:hotels:del")
    @PostMapping(value = "del/{hotelId}")
    public R del(@PathVariable Long hotelId) {
        hotelsService.removeById(hotelId);
        return R.ok();
    }

    @GetMapping(value = "get/{hotelId}")
    public R get(@PathVariable Long hotelId) {
        return R.ok(hotelsService.getById(hotelId));
    }

}

