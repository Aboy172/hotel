package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.Hotels;

import java.util.List;

/**
 * <p>
 * 酒店表：存储酒店的基本信息 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface HotelsMapper extends BaseMapper<Hotels> {

    /**
     * 查询列表(分页)
     * @param hotels 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Hotels> selectHotelsList(@Param("hotels") Hotels hotels, IPage page);

    List<Hotels> findAdvantageList();
}
