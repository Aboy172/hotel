<template>
	<!-- :key="$route.fullPath" 解决了路由前缀相同时跳转不刷新 -->
  <div id="app">
    <UserGuide :visible="showUserGuide" @close="closeUserGuide" />
    <router-view :key="$route.fullPath"/>
  </div>
</template>
<style>
* {  font-size: 2rem;
}


</style>

<script>
import UserGuide from '@/components/common/UserGuide.vue';

export default {
  name: 'App',
  components: {
    UserGuide
  },
  data() {
    return {
      showUserGuide: false
    };
  },
  mounted() {
    // 检查是否是首页，且用户之前没有选择"不再显示"
    if (this.$route.path === '/' && !localStorage.getItem('userGuideShown')) {
      // 延迟显示，让页面先加载完
      setTimeout(() => {
        this.showUserGuide = true;
      }, 1000);
    }
    
    // 监听从Header发出的事件
    this.$root.$on('show-user-guide', this.openUserGuide);
  },
  beforeDestroy() {
    // 清理事件监听
    this.$root.$off('show-user-guide', this.openUserGuide);
  },
  methods: {
    openUserGuide() {
      this.showUserGuide = true;
    },
    closeUserGuide() {
      this.showUserGuide = false;
    }
  }
};
</script>
