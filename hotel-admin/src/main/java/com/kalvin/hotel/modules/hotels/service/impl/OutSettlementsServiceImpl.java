package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.modules.hotels.service.OutSettlementsService;
import org.springframework.stereotype.Service;
import com.kalvin.hotel.modules.hotels.entity.OutSettlements;
import com.kalvin.hotel.modules.hotels.mapper.OutSettlementsMapper;

import java.util.List;

/**
 * <p>
 * 结算表：记录退房时的结算信息 服务实现类
 * </p>
 * @since 2024-10-21 22:06:57
 */
@Service
public class OutSettlementsServiceImpl extends ServiceImpl<OutSettlementsMapper, OutSettlements> implements OutSettlementsService {

    @Override
    public Page<OutSettlements> listOutSettlementsPage(OutSettlements outSettlements) {
        Page<OutSettlements> page = new Page<>(outSettlements.getCurrent(), outSettlements.getSize());
        List<OutSettlements> outSettlementss = baseMapper.selectOutSettlementsList(outSettlements, page);
        return page.setRecords(outSettlementss);
    }

}
