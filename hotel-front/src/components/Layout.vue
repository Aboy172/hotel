<template>
  <div class="layout-container">
    <header class="site-header">
      <div class="header-content">
        <div class="logo">
          <img src="path_to_logo.png" alt="Logo">
        </div>
        <div class="nav">
          <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal">
            <el-menu-item index="1">首页</el-menu-item>
            <el-menu-item index="2">房间</el-menu-item>
            <el-menu-item index="3">订单</el-menu-item>
            <el-menu-item index="4">新闻</el-menu-item>
            <el-menu-item index="5">投诉</el-menu-item>
          </el-menu>
        </div>
        <div class="user-actions">
          <el-dropdown @command="handleCommand">
            <span class="el-dropdown-link">
              <i class="el-icon-user"></i>
              {{ username }}
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="profile">
                <i class="el-icon-user"></i> 个人信息
              </el-dropdown-item>
              <el-dropdown-item command="orders">
                <i class="el-icon-document"></i> 我的订单
              </el-dropdown-item>
              <el-dropdown-item command="logout" divided>
                <i class="el-icon-switch-button"></i> 退出登录
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </header>

    <slot></slot>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3>关于我们</h3>
          <p>我们致力于为您提供最优质的酒店住宿体验，让您的旅途更加舒适愉快。</p>
        </div>
        <div class="footer-section">
          <h3>联系方式</h3>
          <p><i class="el-icon-location"></i> 地址：北京市海淀区中关村大街1号</p>
          <p><i class="el-icon-phone"></i> 电话：400-123-4567</p>
          <p><i class="el-icon-message"></i> 邮箱：contact@hotelmanagement.com</p>
        </div>
        <div class="footer-section">
          <h3>关注我们</h3>
          <div class="social-icons">
            <a href="#"><i class="fa fa-weixin"></i></a>
            <a href="#"><i class="fa fa-weibo"></i></a>
            <a href="#"><i class="fa fa-qq"></i></a>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2023 酒店管理系统 版权所有</p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'Layout',
  data() {
    return {
      activeIndex: '1',
      isLoggedIn: true, // 模拟登录状态
      username: 'dev' // 模拟用户名
    }
  },
  methods: {
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    handleCommand(command) {
      if (command === 'logout') {
        this.$message.success('退出登录成功');
        // 实际应该调用登出API
      } else if (command === 'profile') {
        this.$router.push('/profile');
      } else if (command === 'orders') {
        this.$router.push('/order');
      }
    }
  }
}
</script> 