package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Ins;
import com.kalvin.hotel.modules.hotels.service.InsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 * <p>
 * 入住管理表：记录用户的实际入住和退房信息 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("check_ins/ins")
public class InsController extends BaseController {

    @Autowired
    private InsService insService;

    @RequiresPermissions("check_ins:ins:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("check_ins/ins");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long checkInId) {
        ModelAndView mv = new ModelAndView("check_ins/ins_edit");
        Ins ins;
        if (checkInId == null) {
            ins = new Ins();
        } else {
            ins = insService.getById(checkInId);
        }
        mv.addObject("editInfo", ins);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Ins ins) {
        Page<Ins> page = insService.listInsPage(ins);
        return R.ok(page);
    }

    @RequiresPermissions("check_ins:ins:add")
    @PostMapping(value = "add")
    public R add(Ins ins) {
        insService.save(ins);
        return R.ok();
    }

    @RequiresPermissions("check_ins:ins:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("checkInIds") List<Long> checkInIds) {
        insService.removeByIds(checkInIds);
        return R.ok();
    }

    @RequiresPermissions("check_ins:ins:edit")
    @PostMapping(value = "edit")
    public R edit(Ins ins) {
        insService.updateById(ins);
        return R.ok();
    }

    @RequiresPermissions("check_ins:ins:del")
    @PostMapping(value = "del/{checkInId}")
    public R del(@PathVariable Long checkInId) {
        insService.removeById(checkInId);
        return R.ok();
    }

    @GetMapping(value = "get/{checkInId}")
    public R get(@PathVariable Long checkInId) {
        return R.ok(insService.getById(checkInId));
    }

}

