<template>
  <div class="similar-rooms">
    <h2 class="section-title"><i class="el-icon-s-grid"></i> 相似房间推荐</h2>
    <div class="similar-room-list">
      <div class="similar-room-item" v-for="(room, index) in rooms" :key="index">
        <div class="similar-room-image">
          <img :src="room.image" alt="相似房间图片" />
          <div class="similar-room-status" :class="room.status === 0 ? 'available' : 'occupied'">
            {{ room.status === 0 ? '可预订' : '已预订' }}
          </div>
        </div>
        <div class="similar-room-info">
          <h3 class="similar-room-title">{{ room.title }}</h3>
          <div class="similar-room-meta">
            <div class="similar-room-number">房间号: {{ room.number }}</div>
            <div class="similar-room-price">¥{{ room.price }}</div>
          </div>
          <div class="similar-room-actions">
            <el-button 
              type="primary" 
              size="small" 
              @click="$emit('view-details', room.id)"
            >
              查看详情
            </el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SimilarRooms',
  props: {
    rooms: {
      type: Array,
      default: () => []
    }
  },
  emits: ['view-details']
}
</script>

<style lang="scss">
@import '../styles/similar-rooms.scss';
</style> 