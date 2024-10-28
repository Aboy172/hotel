module.exports = {
  pages:{
    index:{
      entry:'src/main.js',
    }
  },
  lintOnSave: false, // 关闭语法检查

  devServer: {
    port: 8087,
    proxy: {
      '/api': {
        target: 'http://localhost:80', // 注意！此处为后端提供的真实接口
        changeOrigin: true, // 允许跨域
        pathRewrite: {
          // 如果接口中是没有api的，那就直接置空，'^/api': ''，
          // 如果接口中有api，那就得写成{'^/api':'/api'}
          '^/api': ''
        }
      }

    }
  }
}

