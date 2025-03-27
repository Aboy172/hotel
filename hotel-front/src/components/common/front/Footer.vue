<template>
  <footer class="front-footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-section">
          <h3><i class="el-icon-hotel"></i> 关于我们</h3>
          <p>我们致力于为您提供最优质的酒店住宿体验，精选全球顶级酒店，为您的旅行增添舒适与便利。</p>
          <div class="social-links">
            <a href="#"><i class="el-icon-s-platform"></i></a>
            <a href="#"><i class="el-icon-s-marketing"></i></a>
            <a href="#"><i class="el-icon-s-promotion"></i></a>
            <a href="#"><i class="el-icon-s-cooperation"></i></a>
          </div>
        </div>
        
        <div class="footer-section">
          <h3><i class="el-icon-s-help"></i> 快速链接</h3>
          <ul>
            <li><i class="el-icon-s-home"></i> <a href="/">首页</a></li>
            <li><i class="el-icon-s-shop"></i> <a href="/hotels">酒店列表</a></li>
            <li><i class="el-icon-s-order"></i> <a href="/orders">我的订单</a></li>
            <li><i class="el-icon-s-custom"></i> <a href="/profile">个人中心</a></li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h3><i class="el-icon-s-comment"></i> 联系我们</h3>
          <ul>
            <li><i class="el-icon-location-information"></i> 地址：北京市朝阳区建国路88号</li>
            <li><i class="el-icon-phone"></i> 电话：400-123-4567</li>
            <li><i class="el-icon-message"></i> 邮箱：contact@hotelmanager.com</li>
            <li><i class="el-icon-time"></i> 工作时间：周一至周日 9:00-21:00</li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h3><i class="el-icon-s-claim"></i> 订阅我们</h3>
          <p>订阅我们的电子邮件，获取最新的酒店信息和独家优惠。</p>
          <div class="subscribe-form">
            <el-input placeholder="请输入您的邮箱" v-model="email">
              <template #append>
                <el-button type="primary" @click="subscribe">订阅</el-button>
              </template>
            </el-input>
          </div>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>© 2023 酒店管理系统 版权所有 | 设计与开发：酒店管理团队</p>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'FrontFooter',
  data() {
    return {
      email: ''
    }
  },
  methods: {
    subscribe() {
      if (!this.email) {
        this.$message.warning('请输入您的邮箱地址');
        return;
      }
      
      // 验证邮箱格式
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(this.email)) {
        this.$message.error('请输入有效的邮箱地址');
        return;
      }
      
      // 这里可以添加订阅逻辑
      this.$message.success('订阅成功！感谢您的关注');
      this.email = '';
    }
  }
}
</script>

<style lang="scss">
.front-footer {
  width: 100%;
  margin-top: 30px;
  background-color: #2c3e50;
  color: #ecf0f1;
  
  .container {
    width: 100%;
    max-width: 1600px;
    margin: 0 auto;
    padding: 0 20px;
  }
  
  .footer-content {
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    padding: 40px 0;
  }
  
  .footer-section {
    flex: 1;
    min-width: 250px;
    padding: 0 15px;
    margin-bottom: 20px;
    
    h3 {
      font-size: 18px;
      margin-bottom: 15px;
      color: #3498db;
      
      i {
        margin-right: 8px;
      }
    }
    
    p, li {
      font-size: 14px;
      line-height: 1.6;
      margin-bottom: 10px;
      color: rgba(255, 255, 255, 0.8);
    }
    
    ul {
      list-style: none;
      padding: 0;
      
      li {
        margin-bottom: 10px;
        
        i {
          margin-right: 8px;
          color: #3498db;
          font-size: 16px;
        }
        
        a {
          color: rgba(255, 255, 255, 0.8);
          text-decoration: none;
          transition: color 0.3s;
          
          &:hover {
            color: #3498db;
          }
        }
      }
    }
    
    .social-links {
      display: flex;
      gap: 15px;
      margin-top: 15px;
      
      a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        color: #ecf0f1;
        transition: all 0.3s;
        
        i {
          font-size: 20px;
        }
        
        &:hover {
          background-color: #3498db;
          transform: translateY(-3px);
        }
      }
    }
    
    .subscribe-form {
      margin-top: 15px;
      
      .el-input {
        .el-input__inner {
          background-color: rgba(255, 255, 255, 0.1);
          border: 1px solid rgba(255, 255, 255, 0.2);
          color: white;
          
          &::placeholder {
            color: rgba(255, 255, 255, 0.5);
          }
        }
        
        .el-input-group__append {
          background-color: #3498db;
          border-color: #3498db;
          
          .el-button {
            background-color: transparent;
            border: none;
            color: white;
            
            &:hover {
              background-color: darken(#3498db, 10%);
            }
          }
        }
      }
    }
  }
  
  .footer-bottom {
    width: 100%;
    text-align: center;
    padding: 20px 0;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    
    p {
      margin: 0;
      font-size: 14px;
      color: rgba(255, 255, 255, 0.6);
    }
  }
}

@media (max-width: 768px) {
  .front-footer {
    .footer-section {
      flex: 100%;
      margin-bottom: 30px;
    }
  }
}
</style> 