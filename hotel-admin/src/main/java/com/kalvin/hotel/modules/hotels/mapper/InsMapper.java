package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.Ins;

import java.util.List;

/**
 * <p>
 * 入住管理表：记录用户的实际入住和退房信息 Mapper 接口
 * </p>
 * @since 2024-10-21 22:06:56
 */
public interface InsMapper extends BaseMapper<Ins> {

    /**
     * 查询列表(分页)
     * @param ins 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Ins> selectInsList(@Param("ins") Ins ins, IPage page);

}
