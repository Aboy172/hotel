package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.OutSettlements;

import java.util.List;

/**
 * <p>
 * 结算表：记录退房时的结算信息 Mapper 接口
 * </p>
 * @since 2024-10-21 22:06:57
 */
public interface OutSettlementsMapper extends BaseMapper<OutSettlements> {

    /**
     * 查询列表(分页)
     * @param outSettlements 查询参数
     * @param page 分页参数
     * @return list
     */
    List<OutSettlements> selectOutSettlementsList(@Param("outSettlements") OutSettlements outSettlements, IPage page);

}
