package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.OutSettlements;
import com.kalvin.hotel.modules.hotels.service.OutSettlementsService;

import java.util.List;


/**
 * <p>
 * 结算表：记录退房时的结算信息 前端控制器
 * </p>
 * @since 2024-10-21 22:06:57
 */
@RestController
@RequestMapping("check/outSettlements")
public class OutSettlementsController extends BaseController {

    @Autowired
    private OutSettlementsService outSettlementsService;

    @RequiresPermissions("check:outSettlements:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("check/outSettlements");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long settlementId) {
        ModelAndView mv = new ModelAndView("check/outSettlements_edit");
        OutSettlements outSettlements;
        if (settlementId == null) {
            outSettlements = new OutSettlements();
        } else {
            outSettlements = outSettlementsService.getById(settlementId);
        }
        mv.addObject("editInfo", outSettlements);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(OutSettlements outSettlements) {
        Page<OutSettlements> page = outSettlementsService.listOutSettlementsPage(outSettlements);
        return R.ok(page);
    }

    @RequiresPermissions("check:outSettlements:add")
    @PostMapping(value = "add")
    public R add(OutSettlements outSettlements) {
        outSettlementsService.save(outSettlements);
        return R.ok();
    }

    @RequiresPermissions("check:outSettlements:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("settlementIds") List<Long> settlementIds) {
        outSettlementsService.removeByIds(settlementIds);
        return R.ok();
    }

    @RequiresPermissions("check:outSettlements:edit")
    @PostMapping(value = "edit")
    public R edit(OutSettlements outSettlements) {
        outSettlementsService.updateById(outSettlements);
        return R.ok();
    }

    @RequiresPermissions("check:outSettlements:del")
    @PostMapping(value = "del/{settlementId}")
    public R del(@PathVariable Long settlementId) {
        outSettlementsService.removeById(settlementId);
        return R.ok();
    }

    @GetMapping(value = "get/{settlementId}")
    public R get(@PathVariable Long settlementId) {
        return R.ok(outSettlementsService.getById(settlementId));
    }

}

