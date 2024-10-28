<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <router-link class="router" to="/">
            <b-nav-item  href="/">首页</b-nav-item>
          </router-link>
          <router-link class="router" to="/room">
            <b-nav-item href="/product">客房信息</b-nav-item>
          </router-link>
          <router-link class="router" to="/news">

            <b-nav-item href="news">公告信息</b-nav-item>
          </router-link>
          <router-link class="router" to="/about">
            <b-nav-item href="about">用户投诉</b-nav-item>
          </router-link>
        </b-navbar-nav>
        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item-dropdown right v-if="user">
            <!-- Using 'button-content' slot -->
            <template v-slot:button-content>
           <em>   用户：{{user.username}}</em>
            </template>
            <b-dropdown-item href="http://localhost">后台管理</b-dropdown-item>
            <router-link class="router" to="/profile">
            <b-dropdown-item href="/profile">个人信息</b-dropdown-item>
            </router-link>
            <router-link class="router" to="/order">
            <b-dropdown-item href="/order">我的订单</b-dropdown-item>
            </router-link>
            <b-dropdown-item href="#" @click="logoutAction" >退出</b-dropdown-item>
          </b-nav-item-dropdown>
          <router-link class="router" to="/login">
          <b-nav-item href="/login" v-if="!user">用户登录</b-nav-item>
          </router-link>
        </b-navbar-nav>
      </b-collapse>
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
      dropdownOpen: false
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
    //logout() {
    //  this.getRequest("/user/info/logout").then(resp => {
    //    if (resp.data.code === 200) {
    //      this.logout();
    //      this.$router.push({name: "index"});
    //      window.location.reload();
    //    }
    //  }).catch(error => {
    //    console.error('Logout request failed:', error);
    //  });
    //},

    toggleStickyHeader() {
      const scrolled = document.documentElement.scrollTop;
      if (scrolled > 100) {
        AppFunctions.addClass('.header-default', 'ticky');
      } else if (scrolled <= 100) {
        AppFunctions.removeClass('.header-default', 'ticky');
      }
    },


  },
  created() {
    this.user = JSON.parse(Cookies.get("userInfo"));
  },
  mounted() {
    this.toggleStickyHeader();
    this.startChecking();
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.toggleStickyHeader);
    clearInterval(this.interval);
  }
};
</script>

<style scoped>

</style>
