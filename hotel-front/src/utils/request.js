import axios from 'axios'

const request = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: 5000
})

// ... 其他配置

export default request 