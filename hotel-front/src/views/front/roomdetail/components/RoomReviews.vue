<template>
  <div class="room-reviews">
    <h2 class="section-title"><i class="el-icon-s-comment"></i> 住客评价</h2>
    <div class="review-stats">
      <div class="rating-overview">
        <div class="rating-score">4.8</div>
        <div class="rating-text">
          <div class="rating-label">非常好</div>
          <div class="rating-count">基于 {{ reviews.length }} 条评价</div>
        </div>
      </div>
      <div class="rating-bars">
        <div class="rating-bar-item">
          <span class="rating-name">位置</span>
          <el-progress :percentage="95" :show-text="false"></el-progress>
          <span class="rating-value">4.9</span>
        </div>
        <div class="rating-bar-item">
          <span class="rating-name">清洁度</span>
          <el-progress :percentage="90" :show-text="false"></el-progress>
          <span class="rating-value">4.8</span>
        </div>
        <div class="rating-bar-item">
          <span class="rating-name">服务</span>
          <el-progress :percentage="92" :show-text="false"></el-progress>
          <span class="rating-value">4.7</span>
        </div>
        <div class="rating-bar-item">
          <span class="rating-name">舒适度</span>
          <el-progress :percentage="88" :show-text="false"></el-progress>
          <span class="rating-value">4.6</span>
        </div>
      </div>
    </div>

    <div class="review-list">
      <div class="review-item" v-for="(review, index) in reviews" :key="index">
        <div class="review-header">
          <div class="reviewer-info">
            <div class="reviewer-avatar">
              <img :src="review.avatar" alt="用户头像" />
            </div>
            <div class="reviewer-meta">
              <div class="reviewer-name">{{ review.name }}</div>
              <div class="review-date">{{ review.date }}</div>
            </div>
          </div>
          <div class="review-rating">
            <i class="el-icon-star-on" v-for="i in 5" :key="i" :class="{ 'active': i <= review.rating }"></i>
            <span class="rating-value">{{ review.rating }}.0</span>
          </div>
        </div>
        <div class="review-content">
          <p>{{ review.content }}</p>
        </div>
      </div>
    </div>

    <div class="load-more">
      <el-button type="text" icon="el-icon-more">查看更多评价</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RoomReviews',
  props: {
    reviews: {
      type: Array,
      default: () => []
    }
  }
}
</script>

<style lang="scss">
@import '../styles/room-reviews.scss';
</style> 