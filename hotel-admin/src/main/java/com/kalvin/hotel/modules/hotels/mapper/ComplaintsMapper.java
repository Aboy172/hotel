package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.Complaints;

import java.util.List;

/**
 * <p>
 * 投诉表：存储用户的投诉信息 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface ComplaintsMapper extends BaseMapper<Complaints> {

    /**
     * 查询列表(分页)
     * @param complaints 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Complaints> selectComplaintsList(@Param("complaints") Complaints complaints, IPage page);

}
