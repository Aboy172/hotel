<template>
  <div class="search-filter-section">
    <div class="search-box">
      <input 
        type="text" 
        placeholder="请输入客房号" 
        :value="query"
        @input="$emit('update:query', $event.target.value)"
      >
      <el-button type="primary" @click="$emit('search')">
        <i class="am-icon-search"></i> 搜索
      </el-button>
    </div>

    <div class="filter-box">
      <!-- 房型选择 -->
      <div class="filter-item">
        <span class="filter-label">房间类型：</span>
        <el-select 
          :value="roomType"
          @change="$emit('update:roomType', $event)"
          placeholder="请选择房型"
        >
          <el-option
            v-for="type in roomTypeList"
            :key="type.roomTypeId"
            :label="type.typeName"
            :value="type.roomTypeId"
          />
        </el-select>
      </div>

      <!-- 状态选择 -->
      <div class="filter-item">
        <span class="filter-label">入住状态：</span>
        <el-radio-group 
          :value="status"
          @change="$emit('update:status', $event)"
        >
          <el-radio label="0">可入住</el-radio>
          <el-radio label="1">已被他人入住</el-radio>
        </el-radio-group>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    query: String,
    roomType: [String, Number],
    status: String,
    roomTypeList: Array
  },
  emits: ['update:query', 'update:roomType', 'update:status', 'search']
}
</script>

<style scoped>
/* 保持原有样式 */
</style> 