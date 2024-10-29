package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.Types;

import java.util.List;

/**
 * <p>
 * 房间类型表：定义每个酒店的不同房间类型 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface TypesMapper extends BaseMapper<Types> {

    /**
     * 查询列表(分页)
     * @param types 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Types> selectTypesList(@Param("types") Types types, IPage page);

}
