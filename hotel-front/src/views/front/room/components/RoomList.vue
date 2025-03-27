<template>
  <div class="room-list">
    <el-row :gutter="20">
      <el-col 
        v-for="room in roomList" 
        :key="room.roomId"
        :xs="24" 
        :sm="12" 
        :md="8" 
        :lg="6"
      >
        <div class="room-card">
          <div class="room-image">
            <img :src="room.cover" :alt="room.roomTypeName">
            <div 
              class="room-status" 
              :class="room.status == 0 ? 'available' : 'occupied'"
            >
              {{ room.status == 0 ? '可入住' : '已被他人入住' }}
            </div>
          </div>
          <div class="room-info">
            <h3>{{ room.roomTypeName }}</h3>
            <p class="room-number">房间号：{{ room.roomNumber }}</p>
            <p class="hotel-name">{{ room.hotelId }}</p>
            <el-button 
              type="primary" 
              @click="$emit('view-details', room.roomId)"
            >
              查看详情
            </el-button>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  props: {
    roomList: {
      type: Array,
      default: () => []
    }
  }
}
</script>

<style scoped>
/* 保持原有样式 */
</style> 