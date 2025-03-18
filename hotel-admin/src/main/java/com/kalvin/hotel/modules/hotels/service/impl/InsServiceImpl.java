package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.modules.hotels.service.InsService;
import org.springframework.stereotype.Service;
import com.kalvin.hotel.modules.hotels.entity.Ins;
import com.kalvin.hotel.modules.hotels.mapper.InsMapper;

import java.util.List;

/**
 * <p>
 * 入住管理表：记录用户的实际入住和退房信息 服务实现类
 * </p>
 * @since 2024-10-21 22:06:56
 */
@Service
public class InsServiceImpl extends ServiceImpl<InsMapper, Ins> implements InsService {

    @Override
    public Page<Ins> listInsPage(Ins ins) {
        Page<Ins> page = new Page<>(ins.getCurrent(), ins.getSize());
        List<Ins> inss = baseMapper.selectInsList(ins, page);
        return page.setRecords(inss);
    }

}
