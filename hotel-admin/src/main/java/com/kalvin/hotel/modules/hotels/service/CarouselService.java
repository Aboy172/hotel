package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Carousel;

import java.util.List;

/**
* @author cym
* @description 针对表【carousel】的数据库操作Service
* @createDate 2025-03-18 22:42:36
*/
public interface CarouselService extends IService<Carousel> {
    List<Carousel> listAll ( );
}
