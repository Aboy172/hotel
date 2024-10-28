<template>
  <Layout>
    <div class="layout-container" style="width: 100%">
      <div class="page-header">
        <div class="am-container">
          <h1 class="page-header-title">个人信息</h1>
        </div>
      </div>
      <div class="breadcrumb-box">
        <div class="am-container">
          <ol class="am-breadcrumb">
            <li>
              <router-link to="/">首页</router-link>
            </li>
            <li class="am-active">个人信息</li>
          </ol>
        </div>
      </div>
    </div>
    <b-container class="mt-4">
      <b-row>
        <b-col md="4" class="text-center">
          <b-img :src="user.avatar" alt="Avatar" class="rounded-circle" width="200"></b-img>
          <h1 class="mb-2 mt-1">{{ user.username }}</h1>
        </b-col>
        <b-col md="8">
          <b-card header="个人信息" class="mt-5 mb-5" >
            <b-card-body >
              <b-form-group label="性别" label-cols-md="6" >
                <b-form-input :value="user.sex === 1 ? '男':'女'" readonly size="lg"></b-form-input>
              </b-form-group>
              <b-form-group label="邮箱" label-cols-md="6">
                <b-form-input :value="user.email" readonly size="lg"></b-form-input>
              </b-form-group>
              <b-form-group label="手机" label-cols-md="6">
                <b-form-input :value="user.phone" readonly size="lg"></b-form-input>
              </b-form-group>
              <b-form-group label="身份" label-cols-md="6">
                <b-form-input :value="user.jobTitle" readonly size="lg"></b-form-input>
              </b-form-group>
              <b-form-group label="注册时间" label-cols-md="6">
                <b-form-input :value="user.createTime" readonly size="lg"></b-form-input>
              </b-form-group>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout.vue";
import Cookies from "js-cookie";

export default {
  name: "Profile",
  components: {Layout},
  data() {
    return {
      user: Cookies.get("userInfo").length > 0 ? JSON.parse(Cookies.get("userInfo")) : {
        username: 'John Doe',
        avatar: 'https://via.placeholder.com/150',
        email: 'john.doe@example.com',
        phone: '+1 123-456-7890',
        jobTitle: 'Software Engineer'
      }
    };
  }, computed: {
    formattedCreateTime() {
      return this.formatDate(this.user.createTime);
    }
  },
  methods: {
    formatDate(date) {
      const dateTimeOptions = { year: 'numeric', month: '2-digit', day: '2-digit', hour12: false, hour: '2-digit', minute: '2-digit', second: '2-digit' };
      return new Date(date).toLocaleDateString(window.navigator.language, dateTimeOptions) + ' ' + new Date(date).toLocaleTimeString(window.navigator.language, dateTimeOptions);
    }
  }
}
</script>

<style scoped>


.page-header {
  border-bottom: 1px solid #eaeaea;
  margin-bottom: 1rem;
}



.breadcrumb-box {
  padding: 10px 0;
}

.am-breadcrumb {
  background-color: transparent;
  padding: 0;
}

.am-breadcrumb li {
  font-size: 2rem;
}

.am-active {
  color: #007bff;
}

.card {
  border-radius: 1rem;
  box-shadow: 0 6px 6px rgba(0,0,0,0.25);
  border: none;
}

.card-body {
  padding: 2rem;
}

.rounded-circle {
  width: 250px;
  height: 250px;
  margin-top: 80px;
  object-fit: cover;
}
</style>
