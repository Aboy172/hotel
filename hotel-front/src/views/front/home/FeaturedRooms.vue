<template>
  <div class="featured-rooms" ref="featuredRooms">
    <div class="section-header">
      <h2 :class="{ visible: isHeaderVisible }">热门房型</h2>
      <div class="section-divider">
        <span :class="{ visible: isHeaderVisible }"></span>
      </div>
      <p class="section-description" :class="{ visible: isHeaderVisible }">为您精选全球顶级酒店客房，尊享豪华住宿体验</p>
    </div>
    
    <div class="room-cards">
      <div class="room-card" v-for="(room, index) in featuredRooms" :key="room.id" :class="{ visible: isCardVisible[index] }">
        <div class="room-image">
          <img :src="room.image" :alt="room.name">
          <div class="room-price">
            <span>¥{{ room.price }}</span>/晚
          </div>
        </div>
        <div class="room-info">
          <h3>{{ room.name }}</h3>
          <p>{{ room.description }}</p>
          <div class="room-features">
            <span><i class="el-icon-user"></i> {{ room.capacity }}人</span>
            <span><i class="el-icon-house"></i> {{ room.size }}m²</span>
            <span><i class="el-icon-s-home"></i> {{ room.bedType }}</span>
          </div>
          <el-button type="primary" @click="goToDetail(room.id)">查看详情</el-button>
        </div>
      </div>
    </div>
    
    <div class="view-more" :class="{ visible: isViewMoreVisible }">
      <el-button type="text" @click="goToRoomList">查看全部房型 <i class="el-icon-arrow-right"></i></el-button>
    </div>
  </div>
</template>

<script>
import featuredRoomsMock from './mock/featured-rooms.json';
export default {
  name: 'FeaturedRooms',
  data() {
    return {
      featuredRooms: [],
      isHeaderVisible: false,
      isCardVisible: [false, false, false],
      isViewMoreVisible: false,
      observer: null
    }
  },
  mounted() {
    // 从mock数据加载
    this.featuredRooms = featuredRoomsMock.rooms;
    
    // 创建Intersection Observer来检测元素是否在视口中
    this.observer = new IntersectionObserver(this.handleIntersection, {
      root: null,
      rootMargin: '0px',
      threshold: 0.1
    });
    
    // 观察整个组件
    this.observer.observe(this.$refs.featuredRooms);
    
    // 监听滚动事件来触发动画
    window.addEventListener('scroll', this.checkScroll);
    
    // 初始检查
    this.checkScroll();
  },
  beforeDestroy() {
    // 清理观察器和事件监听
    if (this.observer) {
      this.observer.disconnect();
    }
    window.removeEventListener('scroll', this.checkScroll);
  },
  methods: {
    goToDetail(roomId) {
      this.$router.push(`/room/roomId/${roomId}`);
    },
    goToRoomList() {
      this.$router.push('/room');
    },
    handleIntersection(entries) {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          // 当组件进入视口时，立即触发动画
          this.showContent();
        }
      });
    },
    showContent() {
      // 立即显示标题
      this.isHeaderVisible = true;
      
      // 快速显示卡片，只有很短的延迟
      setTimeout(() => {
        this.isCardVisible = this.isCardVisible.map(() => true);
      }, 100);
      
      // 快速显示"查看更多"按钮
      setTimeout(() => {
        this.isViewMoreVisible = true;
      }, 200);
    },
    checkScroll() {
      const element = this.$refs.featuredRooms;
      if (!element) return;
      
      const rect = element.getBoundingClientRect();
      const windowHeight = window.innerHeight;
      
      // 检查各部分是否应该显示，提高触发位置
      if (rect.top < windowHeight * 0.95) {
        this.showContent();
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import './styles/featured-rooms.scss';
</style> 