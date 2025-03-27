package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.OutSettlements;

/**
 * <p>
 * 结算表：记录退房时的结算信息 服务类
 * </p>
 * @since 2024-10-21 22:06:57
 */
public interface OutSettlementsService extends IService<OutSettlements> {

    /**
     * 获取列表。分页
     * @param outSettlements 查询参数
     * @return page
     */
    Page<OutSettlements> listOutSettlementsPage(OutSettlements outSettlements);

}
