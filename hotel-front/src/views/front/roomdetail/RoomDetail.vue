<template>
  <Layout>
    <div class="room-detail">
      <!-- 房间基本信息 -->
      <div class="room-header">
        <!-- 返回按钮 - 集成到标题区域 -->
        <div class="header-top">
          <router-link to="/room" class="back-link">
            <i class="el-icon-arrow-left"></i> 返回客房列表
          </router-link>
        </div>
        <h1>{{ room.typeName || '豪华套房' }}</h1>
        <div class="room-info">
          <span><i class="el-icon-office-building"></i> {{ room.hotelName || '皇冠假日酒店' }}</span>
          <span><i class="el-icon-location"></i> {{ room.location || '北京市朝阳区建国路88号' }}</span>
          <span><i class="el-icon-document"></i> 房间号: {{ room.roomNumber || '1201' }}</span>
        </div>
      </div>
      
      <!-- 房间内容区 -->
      <div class="room-content">
        <!-- 左侧图片 -->
        <div class="room-image">
          <img :src="roomImages[currentImageIndex]" alt="房间图片">
          <div class="room-status" :class="room.status === 0 ? 'available' : 'booked'">
            {{ room.status === 0 ? '可预订' : '已预订' }}
          </div>
          <div class="image-nav">
            <button @click="prevImage"><i class="el-icon-arrow-left"></i></button>
            <button @click="nextImage"><i class="el-icon-arrow-right"></i></button>
          </div>
          <div class="thumbnails">
            <img 
              v-for="(img, index) in roomImages" 
              :key="index" 
              :src="img" 
              :class="{active: currentImageIndex === index}"
              @click="currentImageIndex = index"
            >
          </div>
        </div>
        
        <!-- 右侧信息 -->
        <div class="room-sidebar">
          <div class="price-box">
            <div class="price">¥{{ room.price || 1299 }}<span>/晚</span></div>
            <div class="tags">
              <el-tag>大床</el-tag>
              <el-tag type="info">窗景</el-tag>
              <el-tag type="warning">免费早餐</el-tag>
              <el-tag type="primary">WiFi</el-tag>
              <el-tag type="success">独立卫浴</el-tag>
            </div>
          </div>
          
          <div class="booking-box">
            <el-date-picker
              v-model="dateRange"
              type="daterange"
              range-separator="至"
              start-placeholder="入住日期"
              end-placeholder="退房日期"
              style="width: 100%"
            ></el-date-picker>
            <div class="booking-btns">
              <el-button type="primary" @click="handleBooking">立即预订</el-button>
              <el-button 
                type="info" 
                @click="handleAddToFavorite"
                :icon="isFavorite ? 'el-icon-star-on' : 'el-icon-star-off'"
              >
                {{ isFavorite ? '已收藏' : '收藏' }}
              </el-button>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 房间描述 -->
      <div class="room-desc">
        <h3>房间介绍</h3>
        <p>这是一间豪华套房，配备特大号床和高档家具。房间宽敞明亮，拥有城市美景。配有高速WiFi、平板电视、迷你吧和24小时客房服务。浴室配有浴缸和淋浴，提供高品质洗浴用品。</p>
      </div>
      
      <!-- 房间设施 -->
      <div class="room-facilities">
        <h3>房间设施</h3>
        <ul>
          <li><i class="el-icon-s-home"></i> 面积: 45平方米</li>
          <li><i class="el-icon-user"></i> 可住: 2人</li>
          <li><i class="el-icon-monitor"></i> 50寸智能电视</li>
          <li><i class="el-icon-s-platform"></i> 高速WiFi</li>
          <li><i class="el-icon-s-cooperation"></i> 24小时热水</li>
          <li><i class="el-icon-s-shop"></i> 迷你吧台</li>
          <li><i class="el-icon-s-claim"></i> 空调</li>
          <li><i class="el-icon-s-finance"></i> 保险箱</li>
        </ul>
      </div>
      
      <!-- 评价和推荐 -->
      <room-reviews :reviews="reviews" />
      <similar-rooms :rooms="similarRooms" @view-details="handleViewDetails" />
    </div>
  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout.vue";
import RoomReviews from './components/RoomReviews.vue';
import SimilarRooms from './components/SimilarRooms.vue';
import { roomApi } from '@/api/front/room/api';
import mockData from './mock.json';

export default {
  name: "RoomDetail",
  components: {
    Layout,
    RoomReviews,
    SimilarRooms
  },
  data() {
    return {
      room: {},
      dateRange: null,
      currentImageIndex: 0,
      isFavorite: false,
      roomImages: mockData.roomImages,
      reviews: mockData.reviews,
      similarRooms: mockData.similarRooms
    };
  },
  computed: {
    roomId() {
      return this.$route.params.roomId;
    }
  },
  created() {
    this.fetchRoomDetail();
  },
  methods: {
    // 切换图片
    nextImage() {
      if (this.currentImageIndex < this.roomImages.length - 1) {
        this.currentImageIndex++;
      }
    },
    prevImage() {
      if (this.currentImageIndex > 0) {
        this.currentImageIndex--;
      }
    },
    
    // 获取房间详情
    async fetchRoomDetail() {
      try {
        const res = await roomApi.getRoomDetail(this.roomId);
        if (res.data && res.data.code === 0) {
          this.room = res.data.data || {};
          // 如果有真实数据，更新图片数组
          if (this.room.cover) {
            this.roomImages = [this.room.cover];
            if (this.room.images && this.room.images.length) {
              this.roomImages = [...this.roomImages, ...this.room.images];
            }
          }
          this.fetchSimilarRooms();
          this.fetchReviews();
        }
      } catch (error) {
        console.error('获取房间详情失败:', error);
        this.$message.error('获取房间详情失败，请稍后重试');
      }
    },
    
    // 获取相似房间
    async fetchSimilarRooms() {
      if (!this.room.roomTypeId) return;
      
      try {
        const res = await roomApi.getSimilarRooms(this.room.roomTypeId, this.roomId);
        if (res.data && res.data.code === 0) {
          this.similarRooms = res.data.data || this.similarRooms;
        }
      } catch (error) {
        console.error('获取相似房间失败:', error);
      }
    },
    
    // 获取评价
    async fetchReviews() {
      try {
        const res = await roomApi.getRoomReviews(this.roomId);
        if (res.data && res.data.code === 0) {
          this.reviews = res.data.data || this.reviews;
        }
      } catch (error) {
        console.error('获取房间评价失败:', error);
      }
    },
    
    // 处理预订
    handleBooking() {
      if (!this.dateRange || this.dateRange.length !== 2) {
        this.$message.warning('请选择入住和退房日期');
        return;
      }
      
      const [checkInDate, checkOutDate] = this.dateRange;
      const days = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));
      
      if (days < 1) {
        this.$message.warning('入住时间必须早于退房时间');
        return;
      }
      
      this.$router.push({
        path: '/order/confirm',
        query: {
          roomId: this.roomId,
          checkIn: this.formatDate(checkInDate),
          checkOut: this.formatDate(checkOutDate),
          days: days,
          price: this.room.price || 1299
        }
      });
    },
    
    // 添加收藏
    async handleAddToFavorite() {
      try {
        const res = await roomApi.addToFavorite(this.roomId);
        if (res.data && res.data.code === 0) {
          this.isFavorite = true;
          this.$message.success('已添加到收藏！');
        } else {
          this.$message.error(res.data.msg || '添加收藏失败，请稍后重试');
        }
      } catch (error) {
        console.error('添加收藏失败:', error);
        this.$message.error('添加收藏失败，请稍后重试');
      }
    },
    
    // 查看相似房间详情
    handleViewDetails(roomId) {
      this.$router.push(`/room/roomId/${roomId}`);
    },
    
    // 格式化日期
    formatDate(date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      return `${year}-${month}-${day}`;
    },
    
    // 返回上一页
    goBack() {
      this.$router.push('/room');
    }
  }
};
</script>

<style lang="scss" scoped>
@import './styles/roomdetail.scss';
</style>
