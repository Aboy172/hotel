<template>
  <Layout>
    <!-- 搜索横幅 -->
    <div class="search-banner">
      <div class="banner-content">
        <h1>尊享豪华住宿体验</h1>
        <p>为您精选全球顶级酒店客房</p>
        <div class="search-box">
          <el-input
            v-model="query"
            placeholder="搜索酒店名称、房型或房间号"
            prefix-icon="el-icon-search"
            clearable
          />
          <el-button type="primary" @click="handleSearch">
            搜索
          </el-button>
        </div>
      </div>
    </div>

    <div class="filter-result-container">
      <!-- 筛选区域 -->
      <div class="filter-area">
        <div class="filter-card">
          <div class="filter-header">
            <span class="title">筛选条件</span>
            <el-button type="text" @click="resetFilters">重置</el-button>
          </div>

          <div class="filter-content">
            <div class="filter-item">
              <div class="label">酒店选择</div>
              <el-select v-model="filterForm.hotelId" placeholder="选择酒店" class="filter-select">
                <el-option
                  v-for="hotel in hotels"
                  :key="hotel.id"
                  :label="hotel.name"
                  :value="hotel.id"
                />
              </el-select>
            </div>

            <div class="filter-item">
              <div class="label">房间类型</div>
              <el-select v-model="filterForm.roomType" placeholder="选择房型" class="filter-select">
                <el-option
                  v-for="type in roomTypes"
                  :key="type.id"
                  :label="type.name"
                  :value="type.id"
                />
              </el-select>
            </div>

            <div class="filter-item">
              <div class="label">价格区间</div>
              <div class="price-slider">
                <div class="price-range">
                  <span>¥{{ filterForm.priceRange[0] }}</span>
                  <span>¥{{ filterForm.priceRange[1] }}</span>
                </div>
                <el-slider
                  v-model="filterForm.priceRange"
                  range
                  :min="0"
                  :max="3000"
                />
              </div>
            </div>

            <div class="filter-item">
              <div class="label">入住状态</div>
              <div class="radio-group">
                <el-radio v-model="filterForm.status" label="">全部</el-radio>
                <el-radio v-model="filterForm.status" label="0">可入住</el-radio>
                <el-radio v-model="filterForm.status" label="1">已入住</el-radio>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 结果区域 -->
      <div class="result-area">
        <div class="result-header">
          <div class="result-count">
            为您找到 <span class="count">{{ total }}</span> 间客房
          </div>
          <div class="sort-options">
            <el-button :class="{'active': sortBy === 'default'}" @click="sortBy = 'default'">推荐</el-button>
            <el-button :class="{'active': sortBy === 'priceAsc'}" @click="sortBy = 'priceAsc'">价格从低到高</el-button>
            <el-button :class="{'active': sortBy === 'priceDesc'}" @click="sortBy = 'priceDesc'">价格从高到低</el-button>
          </div>
        </div>

        <div class="room-list">
          <div v-for="room in roomList" :key="room.id" class="room-item">
            <div class="room-card">
              <div class="room-image">
                <img :src="room.image" :alt="room.type">
                <div class="status-tag" :class="room.status === 0 ? 'available' : 'occupied'">
                  {{ room.status === 0 ? '可预订' : '已预订' }}
                </div>
                <div v-if="room.isHot" class="hot-tag">热门</div>
              </div>

              <div class="room-info">
                <div class="hotel-name">{{ room.hotelName }}</div>
                <h3 class="room-name">{{ room.type }}</h3>
                <div class="room-number">房间号: {{ room.number }}</div>

                <div class="room-tags">
                  <el-tag v-for="(tag, index) in room.tags" :key="index" size="small">{{ tag }}</el-tag>
                </div>

                <div class="room-price">
                  <span class="price">¥{{ room.price }}</span>
                  <span class="unit">/晚</span>
                </div>

                <div class="room-actions">
                  <el-button @click="handleViewDetails(room.id)">查看详情</el-button>
                  <el-button type="primary" @click="handleBooking(room.id)" :disabled="room.status !== 0">
                    {{ room.status === 0 ? '预订' : '已预订' }}
                  </el-button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="pagination">
          <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[9, 18, 36]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total"
          />
        </div>
      </div>
    </div>

  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout"
import FrontFooter from "@/components/common/front/Footer"
import mockData from './mock.json'

export default {
  name: "RoomView",
  components: {
    Layout,
    FrontFooter
  },

  data() {
    return {
      // 搜索和筛选表单
      filterForm: {
        hotelId: '',
        roomType: '',
        priceRange: [0, 3000],
        status: ''
      },

      // 排序
      sortBy: 'default',

      // 分页
      currentPage: 1,
      pageSize: 9,
      total: 0,

      // 搜索
      query: '',

      // 数据列表
      hotels: mockData.hotels,
      roomTypes: mockData.roomTypes,
      roomList: [],

      // 价格区间标记
      priceMarks: {
        0: '￥0',
        1000: '￥1000',
        2000: '￥2000',
        3000: '￥3000'
      }
    }
  },

  methods: {
    // 重置筛选条件
    resetFilters() {
      this.filterForm = {
        hotelId: '',
        roomType: '',
        priceRange: [0, 3000],
        status: ''
      }
      this.handleSearch()
    },

    // 处理搜索
    handleSearch() {
      // 根据筛选条件过滤房间列表
      let filteredRooms = [...mockData.rooms]

      // 搜索关键词过滤
      if (this.query) {
        const keyword = this.query.toLowerCase()
        filteredRooms = filteredRooms.filter(room =>
          room.number.toLowerCase().includes(keyword) ||
          room.type.toLowerCase().includes(keyword) ||
          room.hotelName.toLowerCase().includes(keyword)
        )
      }

      // 酒店过滤
      if (this.filterForm.hotelId) {
        filteredRooms = filteredRooms.filter(room =>
          room.hotelId === this.filterForm.hotelId
        )
      }

      // 房型过滤
      if (this.filterForm.roomType) {
        filteredRooms = filteredRooms.filter(room =>
          room.typeId === this.filterForm.roomType
        )
      }

      // 价格区间过滤
      filteredRooms = filteredRooms.filter(room =>
        room.price >= this.filterForm.priceRange[0] &&
        room.price <= this.filterForm.priceRange[1]
      )

      // 入住状态过滤
      if (this.filterForm.status !== '') {
        filteredRooms = filteredRooms.filter(room =>
          room.status === parseInt(this.filterForm.status)
        )
      }

      // 排序
      switch (this.sortBy) {
        case 'priceAsc':
          filteredRooms.sort((a, b) => a.price - b.price)
          break
        case 'priceDesc':
          filteredRooms.sort((a, b) => b.price - a.price)
          break
        default:
          // 默认排序，可以按照推荐度或其他规则
          break
      }

      // 更新总数
      this.total = filteredRooms.length

      // 分页处理
      const start = (this.currentPage - 1) * this.pageSize
      const end = start + this.pageSize
      this.roomList = filteredRooms.slice(start, end)
    },

    // 分页大小改变
    handleSizeChange(val) {
      this.pageSize = val
      this.handleSearch()
    },

    // 当前页改变
    handleCurrentChange(val) {
      this.currentPage = val
      this.handleSearch()
    },

    // 查看详情
    handleViewDetails(roomId) {
      this.$router.push(`/room/roomId/${roomId}`)
    },

    // 预订房间
    handleBooking(roomId) {
      this.$message.success(`开始预订房间 ${roomId}`)
      // 跳转到预订页面或打开预订对话框
    }
  },

  created() {
    this.handleSearch() // 初始化加载数据
  },

  watch: {
    // 监听筛选条件变化，自动搜索
    filterForm: {
      deep: true,
      handler() {
        this.currentPage = 1 // 重置页码
        this.handleSearch()
      }
    },
    sortBy() {
      this.handleSearch()
    }
  }
}
</script>

<style lang="scss" scoped>
@import './styles/room.scss';
@import './styles/room-animations.scss';
</style>
