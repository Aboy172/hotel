package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.modules.hotels.entity.Carousel;
import com.kalvin.hotel.modules.hotels.mapper.CarouselMapper;
import com.kalvin.hotel.modules.hotels.service.CarouselService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author cym
* @description 针对表【carousel】的数据库操作Service实现
* @createDate 2025-03-18 22:42:36
*/
@Service
public class CarouselServiceImpl extends ServiceImpl<CarouselMapper, Carousel>
    implements CarouselService {

    @Override
    public List<Carousel> listAll ( ) {
        QueryWrapper<Carousel> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("sort");

        List<Carousel> list = this.list(queryWrapper);
        return list;
    }
}




