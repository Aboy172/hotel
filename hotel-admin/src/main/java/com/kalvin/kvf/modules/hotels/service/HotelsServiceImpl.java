package com.kalvin.kvf.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.collections.list.LazyList;
import org.springframework.stereotype.Service;
import com.kalvin.kvf.modules.hotels.entity.Hotels;
import com.kalvin.kvf.modules.hotels.mapper.HotelsMapper;

import java.util.List;

/**
 * <p>
 * 酒店表：存储酒店的基本信息 服务实现类
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Service
public class HotelsServiceImpl extends ServiceImpl<HotelsMapper, Hotels> implements HotelsService {

    @Override
    public Page<Hotels> listHotelsPage(Hotels hotels) {
        Page<Hotels> page = new Page<>(hotels.getCurrent(), hotels.getSize());
        List<Hotels> hotelss = baseMapper.selectHotelsList(hotels, page);
        return page.setRecords(hotelss);
    }

    @Override
    public List<Hotels> findAdvantageList() {
        return baseMapper.findAdvantageList();
    }

}