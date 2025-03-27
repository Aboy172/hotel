<template>
  <el-dialog
    title="酒店用户须知"
    :visible.sync="dialogVisible"
    width="50%"
    :before-close="handleClose"
    class="user-guide-dialog"
  >

    <div class="notice-section">
      <h2 class="notice-title"><i class="el-icon-bell"></i> 写在前面</h2>
      <div class="notice-content">
        <p>目前正在重构整个项目，前台部分将会在近期完成，目前处于假数据状态。</p>
        <p>如果有需要做毕设和大作业的同学，可以联系我，付费定制，<strong>400元起</strong>。</p>
        <p>只有<code>admin</code>用户能够进入后台，请以admin身份登录后台。</p>
        <p>同时后台部分也会重新设计和开发。</p>
      </div>
    </div>
    <div class="divider"></div>

    <div class="user-guide-content">
      <h3>尊敬的客户，欢迎使用我们的酒店预订系统</h3>

      <div class="guide-section">
        <h4><i class="el-icon-time"></i> 预订须知</h4>
        <ul>
          <li>预订时请提供真实、准确的个人信息，以便我们能够为您提供更好的服务。</li>
          <li>标准入住时间为下午14:00后，退房时间为中午12:00前。</li>
          <li>如需提前入住或延迟退房，请提前与酒店前台联系。</li>
          <li>预订成功后，系统会自动发送预订确认信息到您的手机或邮箱。</li>
        </ul>
      </div>

      <div class="guide-section">
        <h4><i class="el-icon-money"></i> 支付与取消政策</h4>
        <ul>
          <li>预订确认后，需在24小时内完成支付，否则订单将自动取消。</li>
          <li>入住前24小时取消预订，可获得全额退款。</li>
          <li>入住当天取消预订，将收取首晚房费作为取消费用。</li>
          <li>未按时入住且未提前通知（No-Show），将收取全额房费。</li>
        </ul>
      </div>

      <div class="guide-section">
        <h4><i class="el-icon-house"></i> 入住规定</h4>
        <ul>
          <li>入住时请出示有效身份证件（身份证、护照等）。</li>
          <li>未满18岁客人需由成年人陪同入住。</li>
          <li>请爱护酒店设施，如有损坏需照价赔偿。</li>
          <li>酒店内禁止吸烟，违者将被处以罚款。</li>
        </ul>
      </div>

      <div class="guide-section">
        <h4><i class="el-icon-warning"></i> 特别提示</h4>
        <ul>
          <li>贵重物品请存放在房间保险箱内，酒店对客人的个人财物不承担保管责任。</li>
          <li>如有任何问题或需求，请随时联系酒店前台或拨打客服电话。</li>
          <li>为了您和其他客人的安全与舒适，请遵守酒店的各项规定。</li>
        </ul>
      </div>

      <div class="guide-footer">
        <p>感谢您选择我们的酒店，祝您入住愉快！</p>
      </div>
    </div>

    <span slot="footer" class="dialog-footer">
      <el-checkbox v-model="doNotShowAgain">不再显示</el-checkbox>
      <el-button type="primary" @click="closeDialog">我已了解</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: 'UserGuide',
  props: {
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      dialogVisible: false,
      doNotShowAgain: false
    };
  },
  watch: {
    visible(newVal) {
      this.dialogVisible = newVal;
    }
  },
  methods: {
    handleClose(done) {
      this.closeDialog();
      done();
    },
    closeDialog() {
      if (this.doNotShowAgain) {
        localStorage.setItem('userGuideShown', 'true');
      }
      this.$emit('close');
      this.dialogVisible = false;
    }
  }
};
</script>

<style scoped>
.user-guide-dialog {
  font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
}

.user-guide-content {
  max-height: 60vh;
  overflow-y: auto;
  padding: 0 10px;
}

.user-guide-content h3 {
  text-align: center;
  margin-bottom: 20px;
  color: #409EFF;
  font-size: 20px;
}

.guide-section {
  margin-bottom: 20px;
  border-bottom: 1px solid #eee;
  padding-bottom: 15px;
}

.guide-section h4 {
  color: #333;
  font-size: 18px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
}

.guide-section h4 i {
  margin-right: 10px;
  color: #409EFF;
}

.guide-section ul {
  padding-left: 20px;
}

.guide-section li {
  margin-bottom: 8px;
  line-height: 1.5;
  color: #666;
}

.guide-footer {
  text-align: center;
  margin-top: 20px;
  font-style: italic;
  color: #666;
}

.dialog-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 写在前面部分的样式 */
.notice-section {
  background-color: #f8f9fa;
  border-radius: 8px;
  padding: 15px 20px;
  margin-bottom: 20px;
  border-left: 4px solid #E6A23C;
}

.notice-title {
  color: #E6A23C;
  font-size: 22px;
  margin-bottom: 15px;
  display: flex;
  align-items: center;
}

.notice-title i {
  margin-right: 10px;
}

.notice-content {
  color: #606266;
  line-height: 1.6;
}

.notice-content p {
  margin-bottom: 8px;
}

.notice-content strong {
  color: #F56C6C;
  font-weight: 600;
}

.notice-content code {
  background-color: #f0f0f0;
  padding: 2px 6px;
  border-radius: 4px;
  color: #409EFF;
  font-family: monospace;
}

.divider {
  height: 1px;
  background-color: #EBEEF5;
  margin: 20px 0;
}
</style>
