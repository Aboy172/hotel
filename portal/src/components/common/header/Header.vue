<template>
  <div class="header-wrapper">
    <b-navbar toggleable="lg" class="custom-navbar" :class="{'navbar-scrolled': isScrolled}">
      <div class="container">
        <b-navbar-brand href="/" class="brand">
          <i class="am-icon-hotel"></i> 酒店前台
        </b-navbar-brand>
        
        <b-navbar-toggle target="nav-collapse">
          <span class="navbar-toggler-icon"></span>
        </b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="main-nav">
            <router-link class="nav-link" to="/" active-class="active">
              <i class="am-icon-home"></i> 首页
            </router-link>
            <router-link class="nav-link" to="/room" active-class="active">
              <i class="am-icon-bed"></i> 客房信息
            </router-link>
            <router-link class="nav-link" to="/news" active-class="active">
              <i class="am-icon-newspaper-o"></i> 公告信息
            </router-link>
            <router-link class="nav-link" to="/about" active-class="active">
              <i class="am-icon-comments"></i> 用户投诉
            </router-link>
          </b-navbar-nav>

          <b-navbar-nav class="ml-auto">
            <template v-if="user">
              <b-nav-item-dropdown right>
                <template v-slot:button-content>
                  <i class="am-icon-user"></i>
                  <span class="username">{{user.username}}</span>
                </template>
                <b-dropdown-item href="http://localhost">
                  <i class="am-icon-dashboard"></i> 后台管理
                </b-dropdown-item>
                <router-link class="dropdown-item" to="/profile">
                  <i class="am-icon-user-circle"></i> 个人信息
                </router-link>
                <router-link class="dropdown-item" to="/order">
                  <i class="am-icon-list"></i> 我的订单
                </router-link>
                <b-dropdown-item @click="logoutAction">
                  <i class="am-icon-sign-out"></i> 退出
                </b-dropdown-item>
              </b-nav-item-dropdown>
            </template>
            <router-link v-else class="nav-link login-btn" to="/login">
              <i class="am-icon-sign-in"></i> 登录
            </router-link>
          </b-navbar-nav>
        </b-collapse>
      </div>
    </b-navbar>
  </div>
</template>

<script>
import AppFunctions from "@/utils/AppFunctions";
import Cookies from 'js-cookie';
import {mapActions} from "vuex";
import { mapGetters } from 'vuex';
export default {
  name: "Header",
  components: {},
  computed: {

  },
  data() {
    return {
      AppFunctions,
      isLoggedIn: false,
      showLoginForm: false,
      showRegisterForm: false,
      ...mapGetters(['getUserInfo']),
      // 也可以 alias 为 userInfo
      user: null,
      dropdownOpen: false,
      isScrolled: false
    };
  },
  methods: {
    ...mapActions(['logout']),
    logoutAction() {
      this.getRequest("/user/info/logout").then(resp => {
        if (resp.data.code === 200) {
          this.logout().then(() => {
            // 根据实际需要可能还需要更进一步的路由重定向
            this.$router.push({name: "index"});
            window.location.reload();
          });
        }
      }).catch(error => {
        console.error('Logout request failed:', error);
      });
    },
    handleScroll() {
      this.isScrolled = window.scrollY > 50;
    },
  },
  created() {
    this.user = JSON.parse(Cookies.get("userInfo"));
  },
  mounted() {
    // 等待DOM完全加载
    this.$nextTick(() => {
      // 确保元素存在
      const header = document.querySelector('.header');
      if (header) {
        this.toggleStickyHeader();
        // 添加滚动监听
        window.addEventListener('scroll', this.handleScroll);
      }
    });
  },
  beforeDestroy() {
    // 清理滚动监听
    window.removeEventListener('scroll', this.handleScroll);
  }
};
</script>

<style scoped>
.header-wrapper {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
}

.custom-navbar {
  background: rgba(255, 255, 255, 0.95);
  padding: 15px 0;
  transition: all 0.3s ease;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.navbar-scrolled {
  padding: 10px 0;
  background: rgba(255, 255, 255, 0.98);
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
}

.brand {
  font-size: 1.5rem;
  font-weight: 600;
  color: #2c3e50 !important;
  display: flex;
  align-items: center;
  gap: 10px;
}

.brand i {
  color: #7c6aa6;
}

.main-nav {
  margin-left: 30px;
}

.nav-link {
  color: #2c3e50 !important;
  font-weight: 500;
  padding: 8px 16px !important;
  margin: 0 5px;
  border-radius: 20px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 6px;
}

.nav-link i {
  font-size: 1.1em;
  color: #7c6aa6;
}

.nav-link:hover, .nav-link.active {
  background: #7c6aa6;
  color: white !important;
}

.nav-link:hover i, .nav-link.active i {
  color: white;
}

.login-btn {
  background: #7c6aa6;
  color: white !important;
  padding: 8px 20px !important;
  border-radius: 20px;
}

.login-btn:hover {
  background: #9b89c9;
  transform: translateY(-2px);
}

.username {
  margin-left: 5px;
}

.dropdown-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 20px;
  color: #2c3e50;
  transition: all 0.2s ease;
}

.dropdown-item i {
  color: #7c6aa6;
}

.dropdown-item:hover {
  background: #f8f9fa;
  color: #7c6aa6;
  text-decoration: none;
}

/* 动画效果 */
@keyframes slideDown {
  from {
    transform: translateY(-100%);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.custom-navbar {
  animation: slideDown 0.5s ease-out;
}

/* 响应式调整 */
@media (max-width: 991px) {
  .main-nav {
    margin-left: 0;
    margin-top: 10px;
  }
  
  .nav-link {
    padding: 10px !important;
    margin: 5px 0;
  }
  
  .navbar-collapse {
    background: white;
    padding: 15px;
    border-radius: 10px;
    margin-top: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }
}
</style>
