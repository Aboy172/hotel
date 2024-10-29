package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Reviews;
import com.kalvin.hotel.modules.hotels.service.ReviewsService;

import java.util.List;


/**
 * <p>
 * 评价表：存储用户对酒店的评价 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("reviews/reviews")
public class ReviewsController extends BaseController {

    @Autowired
    private ReviewsService reviewsService;

    @RequiresPermissions("reviews:reviews:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("reviews/reviews");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long reviewId) {
        ModelAndView mv = new ModelAndView("reviews/reviews_edit");
        Reviews reviews;
        if (reviewId == null) {
            reviews = new Reviews();
        } else {
            reviews = reviewsService.getById(reviewId);
        }
        mv.addObject("editInfo", reviews);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Reviews reviews) {
        Page<Reviews> page = reviewsService.listReviewsPage(reviews);
        return R.ok(page);
    }

    @RequiresPermissions("reviews:reviews:add")
    @PostMapping(value = "add")
    public R add(Reviews reviews) {
        reviewsService.save(reviews);
        return R.ok();
    }

    @RequiresPermissions("reviews:reviews:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("reviewIds") List<Long> reviewIds) {
        reviewsService.removeByIds(reviewIds);
        return R.ok();
    }

    @RequiresPermissions("reviews:reviews:edit")
    @PostMapping(value = "edit")
    public R edit(Reviews reviews) {
        reviewsService.updateById(reviews);
        return R.ok();
    }

    @RequiresPermissions("reviews:reviews:del")
    @PostMapping(value = "del/{reviewId}")
    public R del(@PathVariable Long reviewId) {
        reviewsService.removeById(reviewId);
        return R.ok();
    }

    @GetMapping(value = "get/{reviewId}")
    public R get(@PathVariable Long reviewId) {
        return R.ok(reviewsService.getById(reviewId));
    }

}

