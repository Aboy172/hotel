package com.kalvin.kvf.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import com.kalvin.kvf.modules.hotels.entity.Types;
import com.kalvin.kvf.modules.hotels.mapper.TypesMapper;

import java.util.List;

/**
 * <p>
 * 房间类型表：定义每个酒店的不同房间类型 服务实现类
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Service
public class TypesServiceImpl extends ServiceImpl<TypesMapper, Types> implements TypesService {

    @Override
    public Page<Types> listTypesPage(Types types) {
        Page<Types> page = new Page<>(types.getCurrent(), types.getSize());
        List<Types> typess = baseMapper.selectTypesList(types, page);
        return page.setRecords(typess);
    }

}