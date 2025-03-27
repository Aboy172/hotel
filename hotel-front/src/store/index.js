// src/store/index.js
import Vue from 'vue';
import Vuex from 'vuex';
import Cookies from "js-cookie";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    userInfo: null // 用于存储用户信息
  },
  mutations: {
    setUserInfo(state, userInfo) {
      state.userInfo = userInfo;
    },
    clearUserInfo(state) {
      state.userInfo = null;
    }
  },
  getters: {
    getUserInfo: (state) => {
      return JSON.parse(state.userInfo);
    }
  },

  actions: {
    login({ commit }, userInfo) {
      // 登录操作，设置用户信息和 cookie
      commit('setUserInfo', JSON.stringify(userInfo));
      localStorage.setItem("userInfo", JSON.stringify(userInfo))
      // 假设登录成功后返回的用户信息中包含 token
      Cookies.set('userInfo',  JSON.stringify(userInfo),{expires:3}); // 设置
      // cookie

    },
    logout({ commit }) {
      // 退出登录，清除用户信息和 cookie
      commit('clearUserInfo');
      Cookies.remove('userInfo'); // 设置 cookie
      localStorage.removeItem("userInfo")
    }
  }
});
