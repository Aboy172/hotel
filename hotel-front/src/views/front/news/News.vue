<template>
  <Layout>
    <!-- 搜索横幅 -->
    <div class="search-banner">
      <div class="banner-content">
        <h1>酒店公告信息</h1>
        <p>了解我们最新的活动与服务信息</p>
        <div class="search-box">
          <el-input
            v-model="searchQuery"
            placeholder="搜索公告内容"
            prefix-icon="el-icon-search"
            clearable
            @keyup.enter.native="handleSearch"
          />
          <el-button type="primary" @click="handleSearch">
            搜索
          </el-button>
        </div>
      </div>
    </div>

    <div class="main-container">
      <!-- 筛选条件 -->
      <div class="filter-section">
        <div class="filter-title">筛选条件</div>
        <el-button type="text" class="reset-btn" @click="resetFilters">重置</el-button>
        
        <div class="filter-row">
          <div class="filter-label">酒店选择</div>
          <el-select v-model="selectedHotel" placeholder="选择酒店" class="filter-select">
            <el-option label="全部酒店" value=""></el-option>
            <el-option v-for="hotel in hotels" :key="hotel.id" :label="hotel.name" :value="hotel.id"></el-option>
          </el-select>
        </div>
        
        <div class="filter-row">
          <div class="filter-label">公告类型</div>
          <el-select v-model="announcementType" placeholder="选择类型" class="filter-select">
            <el-option label="全部类型" value=""></el-option>
            <el-option label="活动通知" value="activity"></el-option>
            <el-option label="服务调整" value="service"></el-option>
            <el-option label="设施维护" value="maintenance"></el-option>
            <el-option label="特别优惠" value="promotion"></el-option>
          </el-select>
        </div>
        
        <div class="filter-row">
          <div class="filter-label">发布日期</div>
          <el-date-picker
            v-model="dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            format="yyyy-MM-dd"
            value-format="yyyy-MM-dd"
            class="filter-date"
          ></el-date-picker>
        </div>
      </div>
      
      <div class="result-area">
        <!-- 结果统计和排序 -->
        <div class="result-header">
          <div class="result-count">共找到 <span>{{ total }}</span> 条公告</div>
          <div class="sort-options">
            <span>排序：</span>
            <el-radio-group v-model="sortBy" size="small">
              <el-radio-button label="newest">最新发布</el-radio-button>
              <el-radio-button label="oldest">最早发布</el-radio-button>
            </el-radio-group>
          </div>
        </div>
        
        <!-- 公告列表 -->
        <div v-if="announcements.length === 0" class="empty-state">
          <i class="el-icon-info"></i>
          <p>暂无公告信息</p>
          <el-button type="primary" @click="handleSearch">刷新</el-button>
        </div>
        
        <div v-else class="announcement-list">
          <div v-for="item in announcements" :key="item.id" class="announcement-item">
            <div class="hotel-name">{{ item.hotels?.hotelName }}</div>
            <div class="date">{{ formatDate(item.createdAt) }}</div>
            <div class="announcement-content">
              <i class="el-icon-bell"></i>
              {{ item.message || item.text }}
            </div>
            <div class="action">
              <el-button type="text" size="small">查看详情</el-button>
            </div>
          </div>
        </div>
        
        <!-- 分页 -->
        <div class="pagination-container" v-if="announcements.length > 0">
          <el-pagination
            @current-change="handleCurrentChange"
            :current-page="pageIndex.current"
            :page-size="pageIndex.size"
            layout="prev, pager, next"
            :total="total"
          ></el-pagination>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
import { formatDate } from '@/utils/dateUtil';
import mockData from './mock.json';

export default {
  name: "News",
  components: {Layout},
  data() {
    return {
      announcements: [],
      hotels: [],
      selectedHotel: '',
      sortBy: 'newest',
      searchQuery: '',
      announcementType: '',
      dateRange: null,
      total: 0,
      pageIndex: {
        current: 1,
        size: 10
      },
      loading: false
    };
  },
  mounted() {
    this.handleSearch();
    this.getHotels();
  },
  methods: {
    // 获取公告列表
    async getAnnouncements(params) {
      this.loading = true;
      try {
        // 尝试从API获取数据
        const resp = await this.getRequest('/hotel_notifications/notifications/list/data', params);
        if (resp && resp.data) {
          this.announcements = resp.data.data || [];
          this.total = resp.data.total || 0;
        } else {
          // 如果API请求失败，使用模拟数据
          this.announcements = mockData.announcements;
          this.total = mockData.announcements.length;
        }
      } catch (error) {
        console.error('获取公告列表失败:', error);
        // 使用模拟数据
        this.announcements = mockData.announcements;
        this.total = mockData.announcements.length;
      } finally {
        this.loading = false;
      }
    },
    
    // 获取酒店列表
    async getHotels() {
      try {
        const resp = await this.getRequest('/hotel/list');
        if (resp && resp.data) {
          this.hotels = resp.data.data || [];
        } else {
          this.hotels = mockData.hotels || [];
        }
      } catch (error) {
        console.error('获取酒店列表失败:', error);
        this.hotels = mockData.hotels || [];
      }
    },
    
    // 处理搜索
    handleSearch() {
      this.pageIndex.current = 1;
      
      // 构建查询参数
      const params = {
        ...this.pageIndex,
        keyword: this.searchQuery,
        hotelId: this.selectedHotel,
        type: this.announcementType,
        sortBy: this.sortBy,
        startDate: this.dateRange ? this.dateRange[0] : null,
        endDate: this.dateRange ? this.dateRange[1] : null
      };
      
      this.getAnnouncements(params);
    },
    
    // 重置筛选条件
    resetFilters() {
      this.selectedHotel = '';
      this.announcementType = '';
      this.dateRange = null;
      this.searchQuery = '';
      this.sortBy = 'newest';
      this.handleSearch();
    },
    
    // 处理分页变化
    handleCurrentChange(page) {
      this.pageIndex.current = page;
      this.handleSearch();
    },
    
    // 格式化日期
    formatDate(dateString) {
      if (!dateString) return '';
      return formatDate(dateString, 'YYYY-MM-DD');
    },
    
    // 获取公告标题
    getAnnouncementTitle(item) {
      // 从消息内容中提取标题，取前20个字符
      const message = item.message || item.text || '';
      const title = message.split('。')[0]; // 取第一句话作为标题
      return title.length > 30 ? title.substring(0, 30) + '...' : title;
    },
    
    // 根据公告类型获取对应图标
    getAnnouncementIcon(type) {
      const iconMap = {
        activity: 'el-icon-star-on',
        service: 'el-icon-s-tools',
        maintenance: 'el-icon-warning',
        promotion: 'el-icon-shopping-cart-full'
      };
      return iconMap[type] || 'el-icon-bell';
    }
  },
  watch: {
    // 监听筛选条件变化
    sortBy() {
      this.handleSearch();
    }
  }
};
</script>

<style lang="scss" scoped>
@import './styles/news.scss';
</style>
