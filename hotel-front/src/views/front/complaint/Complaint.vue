<template>
  <Layout>
    <!-- 搜索横幅 -->
    <div class="search-banner">
      <div class="banner-content">
        <h1>用户投诉与反馈</h1>
        <p>我们重视您的每一条意见，竭诚为您提供更好的服务</p>
      </div>
    </div>

    <div class="main-container">
      <!-- 左侧说明区域 -->
      <div class="info-section">
        <div class="info-card">
          <div class="info-header">
            <i class="el-icon-info"></i>
            <span>投诉须知</span>
          </div>
          <div class="info-content">
            <p>尊敬的客户，感谢您选择我们的酒店。如果您在入住过程中遇到任何问题或有任何建议，请通过此页面提交您的投诉或反馈。</p>
            <p>我们承诺：</p>
            <ul>
              <li>24小时内响应您的投诉</li>
              <li>48小时内给予解决方案</li>
              <li>对您的个人信息严格保密</li>
            </ul>
            <div class="contact-info">
              <p><i class="el-icon-phone"></i> 客服热线：400-123-4567</p>
              <p><i class="el-icon-message"></i> 客服邮箱：service@hotel.com</p>
            </div>
          </div>
        </div>
        
        <div class="faq-card">
          <div class="faq-header">
            <i class="el-icon-question"></i>
            <span>常见问题</span>
          </div>
          <div class="faq-content">
            <el-collapse>
              <el-collapse-item title="如何查询我的投诉处理进度？" name="1">
                <div>您可以通过登录账户，在"个人中心"查看您提交的投诉记录及处理状态。</div>
              </el-collapse-item>
              <el-collapse-item title="投诉后多久能得到回复？" name="2">
                <div>我们会在24小时内对您的投诉进行初步回复，并在48小时内给予解决方案。</div>
              </el-collapse-item>
              <el-collapse-item title="我可以匿名投诉吗？" name="3">
                <div>可以，但匿名投诉我们将无法与您取得联系，建议您留下联系方式以便我们及时回复。</div>
              </el-collapse-item>
              <el-collapse-item title="如何取消已提交的投诉？" name="4">
                <div>投诉一旦提交无法取消，但您可以联系客服说明情况。</div>
              </el-collapse-item>
            </el-collapse>
          </div>
        </div>
      </div>
      
      <!-- 右侧表单区域 -->
      <div class="form-section">
        <div class="form-card">
          <div class="form-header">
            <i class="el-icon-edit"></i>
            <span>提交投诉</span>
          </div>
          <div class="form-content">
            <el-form :model="complaintForm" :rules="rules" ref="complaintForm" label-width="100px">
              <el-form-item label="投诉酒店" prop="hotelId">
                <el-select v-model="complaintForm.hotelId" placeholder="请选择酒店" style="width: 100%">
                  <el-option
                    v-for="hotel in hotelList"
                    :key="hotel.hotelId"
                    :label="hotel.hotelName"
                    :value="hotel.hotelId">
                  </el-option>
                </el-select>
              </el-form-item>
              
              <el-form-item label="投诉类型" prop="type">
                <el-select v-model="complaintForm.type" placeholder="请选择投诉类型" style="width: 100%">
                  <el-option label="服务态度" value="service"></el-option>
                  <el-option label="设施问题" value="facility"></el-option>
                  <el-option label="卫生问题" value="hygiene"></el-option>
                  <el-option label="噪音问题" value="noise"></el-option>
                  <el-option label="收费问题" value="billing"></el-option>
                  <el-option label="其他" value="other"></el-option>
                </el-select>
              </el-form-item>
              
              <el-form-item label="投诉主题" prop="subject">
                <el-input v-model="complaintForm.subject" placeholder="请简要描述您的问题"></el-input>
              </el-form-item>
              
              <el-form-item label="详细描述" prop="description">
                <el-input
                  type="textarea"
                  v-model="complaintForm.description"
                  :rows="6"
                  placeholder="请详细描述您遇到的问题，以便我们更好地为您解决">
                </el-input>
              </el-form-item>
              
              <el-form-item label="联系方式" prop="contact">
                <el-input v-model="complaintForm.contact" placeholder="电话或邮箱，方便我们与您联系"></el-input>
              </el-form-item>
              
              <el-form-item label="上传图片">
                <el-upload
                  action="#"
                  list-type="picture-card"
                  :auto-upload="false"
                  :limit="3"
                  :file-list="fileList"
                  :on-change="handleFileChange">
                  <i class="el-icon-plus"></i>
                </el-upload>
                <div class="upload-tip">可上传问题相关图片（最多3张）</div>
              </el-form-item>
              
              <el-form-item>
                <el-button type="primary" @click="submitComplaint" :loading="submitting">提交投诉</el-button>
                <el-button @click="resetForm">重置</el-button>
              </el-form-item>
            </el-form>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
import mockData from './mock.json';

export default {
  name: "Complaint",
  components: {Layout},
  data() {
    return {
      hotelList: [],
      complaintForm: {
        hotelId: '',
        type: '',
        subject: '',
        description: '',
        contact: ''
      },
      rules: {
        hotelId: [
          { required: true, message: '请选择投诉酒店', trigger: 'change' }
        ],
        type: [
          { required: true, message: '请选择投诉类型', trigger: 'change' }
        ],
        subject: [
          { required: true, message: '请输入投诉主题', trigger: 'blur' },
          { min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur' }
        ],
        description: [
          { required: true, message: '请输入详细描述', trigger: 'blur' },
          { min: 10, max: 500, message: '长度在 10 到 500 个字符', trigger: 'blur' }
        ],
        contact: [
          { required: true, message: '请输入联系方式', trigger: 'blur' }
        ]
      },
      fileList: [],
      submitting: false
    };
  },
  mounted() {
    this.getHotels();
  },
  methods: {
    // 获取酒店列表
    getHotels() {
      this.getRequest("/hotels/hotels/list/data").then(resp => {
        if (resp && resp.data && resp.data.code === 200) {
          this.hotelList = resp.data.data || [];
        } else {
          // 使用模拟数据
          this.hotelList = mockData.hotels || [];
        }
      }).catch(error => {
        console.error('获取酒店列表失败:', error);
        // 使用模拟数据
        this.hotelList = mockData.hotels || [];
      });
    },
    
    // 处理文件变化
    handleFileChange(file, fileList) {
      this.fileList = fileList;
    },
    
    // 提交投诉
    submitComplaint() {
      this.$refs.complaintForm.validate(valid => {
        if (!valid) {
          this.$message.warning('请完善表单信息');
          return;
        }
        
        this.submitting = true;
        
        // 构建请求参数
        const params = `?hotelId=${this.complaintForm.hotelId}&description=${this.complaintForm.description}&type=${this.complaintForm.type}&subject=${this.complaintForm.subject}&contact=${this.complaintForm.contact}`;
        
        this.getRequestPost(`/user/hotels/complaint${params}`).then(resp => {
          if (resp && resp.data && resp.data.code === 200) {
            this.$notify({
              title: '提交成功',
              message: '您的投诉已提交，我们会尽快处理',
              type: 'success'
            });
            this.resetForm();
          } else {
            this.$message.error(resp?.data?.msg || '提交失败，请稍后重试');
          }
        }).catch(error => {
          console.error('提交投诉失败:', error);
          this.$message.error('提交失败，请稍后重试');
        }).finally(() => {
          this.submitting = false;
        });
      });
    },
    
    // 重置表单
    resetForm() {
      this.$refs.complaintForm.resetFields();
      this.fileList = [];
    }
  }
};
</script>

<style lang="scss" scoped>
@import './styles/complaint.scss';
</style> 