import Vue from 'vue'
import Vuex from 'vuex';
import App from './App.vue'
import router from './router'
import './assets/css/style.css'
import {getRequest, getRequestPost} from "@/api/api";
import AmazeVue from 'amaze-vue';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import store from "./store";
Vue.prototype.getRequest = getRequest;
Vue.config.productionTip = false;
Vue.use(ElementUI)

Vue.use(Vuex);
Vue.use(IconsPlugin)
Vue.use(BootstrapVue)
Vue.prototype.getRequestPost = getRequestPost
Vue.config.productionTip = false
Vue.use(AmazeVue);
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
