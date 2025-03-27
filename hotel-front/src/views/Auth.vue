<template>
  <div class="auth-container">
    <a href="/" class="home-link">
      <b-icon icon="chevron-left" class="border rounded">返回主页</b-icon>
      返回主页
    </a>
    <div class="auth-content">
      <div class="auth-image"></div>
      <transition name="fade-slide">
        <div v-if="!showRegisterForm &&!showForgetFrom" class="auth-form">
          <form @submit.prevent="handleSubmit">
            <h1>用户登录</h1>
            <div class="input-group">
              <label for="username">用户名</label>
              <input type="text" id="username" v-model="username" required placeholder="请输入用户名"/>
            </div>
            <div class="input-group">
              <label for="password">密码</label>
              <input type="password" id="password" v-model="password" required placeholder="请输入密码"/>
            </div>
            <p style="font-size: 12px">还未注册？<a @click.prevent="showRegisterForm = true"
                                                   style="font-size: 12px">立即注册</a></p>
            <p style="font-size: 12px"><a @click.prevent="showForgetFrom = true"
                                                   style="font-size: 12px">重置密码</a></p>
            <button type="submit">登录</button>
          </form>
        </div>
      </transition>
      <transition name="fade-slide">
        <div v-if="showForgetFrom" class="auth-form">
          <form @submit.prevent="handleRest">
            <h1>重置密码</h1>
            <button
                type="button"
                @click="showForgetFrom = false; showRegisterForm = false; showLoginForm = true"
                class="am-btn am-btn-default"
            >
              返回登录 <i class="am-icon-chevron-left"></i>
            </button>
            <div class="input-group">
              <label for="register-username">用户名</label>
              <input
                  type="text"
                  id="register-username"
                  v-model="registerUsername"
                  required
              />
            </div>
            <div class="input-group">
              <label for="register-password">旧密码</label>
              <input
                  type="password"
                  id="register-password"
                  v-model="registerPassword"
                  required
              />
            </div>
            <div class="input-group">
              <label for="register-password">新密码</label>
              <input
                  type="password"
                  id="register-password"
                  v-model="newPassword"
                  required
              />
            </div>
            <button type="submit" class="am-btn am-btn-primary">立即修改</button>
          </form>
        </div>
      </transition>
      <transition name="fade-slide">
        <div v-if="showRegisterForm" class="auth-form">
          <form @submit.prevent="handleRegister">
            <h1>注册</h1>
            <button
                type="button"
                @click="showRegisterForm = false; showLoginForm = true"
                class="am-btn am-btn-default"
            >
              返回登录 <i class="am-icon-chevron-left"></i>
            </button>
            <div class="input-group">
              <label for="register-username">用户名</label>
              <input
                  type="text"
                  id="register-username"
                  v-model="registerUsername"
                  required
              />
            </div>
            <div class="input-group">
              <label for="register-password">密码</label>
              <input
                  type="password"
                  id="register-password"
                  v-model="registerPassword"
                  required
              />
            </div>
            <div class="input-group">
              <label for="register-password">确认密码</label>
              <input
                  type="password"
                  id="register-password"
                  v-model="confirmPassword"
                  required
              />
            </div>
            <button type="submit" class="am-btn am-btn-primary">立即注册</button>
          </form>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
import {mapActions} from 'vuex';

export default {
  name: "AuthPage",

  data() {
    return {
      showRegisterForm: false,
      username: '',
      password: '',
      registerUsername: '',
      registerEmail: '',
      registerPassword: '',
      showForgetFrom: false,
      newPassword: ''
    };
  },

  methods: {
    ...mapActions(['login']),
    getInfo() {
      this.getRequest("/user/info").then(resp => {
        if (resp.data.code === 200) {
          this.login(resp.data.data);
          this.$router.push({name: 'index'});

        } else {
          this.$notify.error(resp.data.msg);
        }
      })
    },
    handleRest() {
      this.getRequestPost(
          `/user/info/rest?username=${this.username}&password=${this.registerPassword}&confirmPassword=${this.newPassword}`).then(
          resp => {
            if (resp) {
              if (resp.data.code === 200) {
                this.$notify({
                  message: '修改成功',
                  type: 'success'
                });
                //this.getInfo()
              } else {
                this.$notify({
                  message: resp.data.msg,
                  type: 'error'
                });
              }
            }
          });
    },
    handleSubmit() {
      this.getRequestPost(`/login?username=${this.username}&password=${this.password}`).then(resp => {
        if (resp) {
          if (resp.data.code === 200) {
            //2秒提示
            this.$notify({
              message: '登录成功',
              type: 'success',
              duration: 500
            });
            this.getInfo()
          } else {
            this.$notify({
              message: resp.data.msg,
              type: 'error'
            });
          }
        }
      });
      console.log('登录:', this.username, this.password);

    },
    handleRegister() {

    }
  }
};
</script>

<style scoped>

.auth-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #f5f7fa;
}

.auth-content {
  display: flex;
  width: 80%;
  height: 80%;
}

.auth-image {
  flex: 6;
  width: 70vh;
  height: 70vh;
  background: url("../assets/images/product/bg.jpg") no-repeat center / cover;
  border-radius: 10px 0 0 10px;
  overflow: hidden;
  overflow: hidden;
}

.auth-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.auth-form {
  flex: 3;
  background-color: white;
  padding: 30px;
  border-radius: 0 10px 10px 0;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.auth-form h1 {
  margin-bottom: 20px;
  text-align: center;
}

.input-group {
  margin-bottom: 20px;
}

.input-group label {
  display: block;
  margin-bottom: 5px;
}

.input-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

button {
  background-color: #0055ff;
  color: white;
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0033cc;
}

.home-link {
  position: absolute;
  top: 20px;
  left: 20px;
  color: #0055ff;
  text-decoration: none;
}

.home-link:hover {
  text-decoration: underline;
}

.home-link:hover {
  text-decoration: none;
}


</style>
