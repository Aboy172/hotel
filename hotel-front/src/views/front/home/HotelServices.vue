<template>
  <div class="hotel-services" ref="hotelServices">
    <div class="section-header">
      <h2 :class="{ visible: isHeaderVisible }">酒店服务</h2>
      <div class="section-divider">
        <span :class="{ visible: isHeaderVisible }"></span>
      </div>
      <p class="section-description" :class="{ visible: isHeaderVisible }">我们提供全方位的优质服务，让您的住宿体验更加舒适愉快</p>
    </div>
    
    <div class="services-container">
      <div class="service-item" v-for="(service, index) in services" :key="service.id" :class="{ visible: isServiceVisible[index] }">
        <div class="service-icon">
          <i :class="service.icon"></i>
        </div>
        <h3>{{ service.title }}</h3>
        <p>{{ service.description }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import servicesMock from './mock/hotel-services.json';

export default {
  name: 'HotelServices',
  data() {
    return {
      services: [],
      isHeaderVisible: false,
      isServiceVisible: [],
      observer: null
    }
  },
  mounted() {
    // 从mock数据加载
    this.services = servicesMock.services;
    this.isServiceVisible = Array(this.services.length).fill(false);
    
    // 创建Intersection Observer来检测元素是否在视口中
    this.observer = new IntersectionObserver(this.handleIntersection, {
      root: null,
      rootMargin: '0px',
      threshold: 0.1
    });
    
    // 观察整个组件
    this.observer.observe(this.$refs.hotelServices);
    
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
      
      // 快速显示服务项，只有很短的延迟
      setTimeout(() => {
        this.isServiceVisible = this.isServiceVisible.map(() => true);
      }, 100);
    },
    checkScroll() {
      const element = this.$refs.hotelServices;
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
@import './styles/hotel-services.scss';
</style> 