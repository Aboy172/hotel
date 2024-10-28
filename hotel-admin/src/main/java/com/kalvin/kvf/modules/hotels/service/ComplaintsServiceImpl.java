package com.kalvin.kvf.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import com.kalvin.kvf.modules.hotels.entity.Complaints;
import com.kalvin.kvf.modules.hotels.mapper.ComplaintsMapper;

import java.util.List;

/**
 * <p>
 * 投诉表：存储用户的投诉信息 服务实现类
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Service
public class ComplaintsServiceImpl extends ServiceImpl<ComplaintsMapper, Complaints> implements ComplaintsService {

    @Override
    public Page<Complaints> listComplaintsPage(Complaints complaints) {
        Page<Complaints> page = new Page<>(complaints.getCurrent(), complaints.getSize());
        List<Complaints> complaintss = baseMapper.selectComplaintsList(complaints, page);
        return page.setRecords(complaintss);
    }

}
