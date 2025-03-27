package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.api.R;
import com.kalvin.hotel.modules.hotels.entity.Carousel;
import com.kalvin.hotel.modules.hotels.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author: cym
 * @create: 2025-03-18 22:44
 * @description:
 * @version: 0.0.1
 **/
@RestController
@RequestMapping("/carousel")
public class CarouselController {

    @Autowired
    private CarouselService carouselService;

    @RequestMapping("/list")
    public R<List<Carousel>> list ( ) {
        List<Carousel> carousels = carouselService.listAll();

        return R.ok(carousels);
    }

    @PostMapping("/add")
    public R<Boolean> add (@RequestBody Carousel carousel) {
        return R.ok(carouselService.save(carousel));
    }

    @PostMapping("/delete")
    public R<Boolean> delete (@RequestParam("id") Long id) {
        return R.ok(carouselService.removeById(id));
    }

    @PostMapping("/update")
    public R<Boolean> update (@RequestBody Carousel carousel) {
        return R.ok(carouselService.updateById(carousel));

    }
}
