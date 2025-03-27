<template>
  <Layout>
    <!-- 页面标题横幅 -->
    <div class="page-banner">
      <h1>个人信息管理</h1>
    </div>

    <div class="main-container">
      <div class="profile-container">
        <!-- 左侧导航 -->
        <div class="profile-sidebar">
          <div class="user-info">
            <div class="avatar-container">
              <img :src="userInfo.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" alt="用户头像" class="avatar">
              <div class="avatar-upload">
                <i class="fa fa-camera"></i>
                <input type="file" @change="handleAvatarUpload" accept="image/*" class="avatar-input">
              </div>
            </div>
            <h3 class="username">{{ userInfo.username }}</h3>
            <p class="user-level">
              <i class="fa fa-diamond"></i> {{ userInfo.level }}
            </p>
          </div>
          <ul class="nav-menu">
            <li 
              v-for="(item, index) in navItems" 
              :key="index"
              :class="{ active: activeTab === item.key }"
              @click="activeTab = item.key"
            >
              <i :class="item.icon"></i>
              <span>{{ item.label }}</span>
            </li>
          </ul>
        </div>

        <!-- 右侧内容区 -->
        <div class="profile-content">
          <!-- 基本信息 -->
          <div v-if="activeTab === 'basic'" class="tab-content">
            <h2 class="section-title">
              <i class="fa fa-user"></i> 基本信息
            </h2>
            <el-form :model="userInfo" label-width="100px" class="profile-form">
              <el-form-item label="用户名">
                <el-input v-model="userInfo.username" disabled></el-input>
              </el-form-item>
              <el-form-item label="真实姓名">
                <el-input v-model="userInfo.realName"></el-input>
              </el-form-item>
              <el-form-item label="手机号码">
                <el-input v-model="userInfo.phone"></el-input>
              </el-form-item>
              <el-form-item label="电子邮箱">
                <el-input v-model="userInfo.email"></el-input>
              </el-form-item>
              <el-form-item label="性别">
                <el-radio-group v-model="userInfo.gender">
                  <el-radio :label="1">男</el-radio>
                  <el-radio :label="2">女</el-radio>
                  <el-radio :label="0">保密</el-radio>
                </el-radio-group>
              </el-form-item>
              <el-form-item label="生日">
                <el-date-picker
                  v-model="userInfo.birthday"
                  type="date"
                  placeholder="选择日期"
                  format="yyyy-MM-dd"
                  value-format="yyyy-MM-dd">
                </el-date-picker>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="saveBasicInfo">保存修改</el-button>
              </el-form-item>
            </el-form>
          </div>

          <!-- 安全设置 -->
          <div v-if="activeTab === 'security'" class="tab-content">
            <h2 class="section-title">
              <i class="fa fa-lock"></i> 安全设置
            </h2>
            <el-form label-width="100px" class="profile-form">
              <el-form-item label="修改密码">
                <el-button type="primary" @click="showPasswordDialog">修改密码</el-button>
              </el-form-item>
              <el-form-item label="绑定手机">
                <div class="bind-info">
                  <span>{{ userInfo.phone || '未绑定' }}</span>
                  <el-button type="text" @click="showPhoneDialog">{{ userInfo.phone ? '修改' : '绑定' }}</el-button>
                </div>
              </el-form-item>
              <el-form-item label="绑定邮箱">
                <div class="bind-info">
                  <span>{{ userInfo.email || '未绑定' }}</span>
                  <el-button type="text" @click="showEmailDialog">{{ userInfo.email ? '修改' : '绑定' }}</el-button>
                </div>
              </el-form-item>
            </el-form>
          </div>
        </div>
      </div>
    </div>

    <!-- 修改密码对话框 -->
    <el-dialog title="修改密码" :visible.sync="passwordDialogVisible" width="500px">
      <el-form :model="passwordForm" :rules="passwordRules" ref="passwordForm" label-width="100px">
        <el-form-item label="原密码" prop="oldPassword">
          <el-input type="password" v-model="passwordForm.oldPassword" show-password></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input type="password" v-model="passwordForm.newPassword" show-password></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input type="password" v-model="passwordForm.confirmPassword" show-password></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="passwordDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="changePassword">确认修改</el-button>
      </div>
    </el-dialog>

    <!-- 联系人对话框 -->
    <el-dialog :title="currentContact.id ? '编辑联系人' : '添加联系人'" :visible.sync="contactDialogVisible" width="500px">
      <el-form :model="currentContact" :rules="contactRules" ref="contactForm" label-width="100px">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="currentContact.name"></el-input>
        </el-form-item>
        <el-form-item label="证件类型" prop="idType">
          <el-select v-model="currentContact.idType" placeholder="请选择证件类型">
            <el-option label="身份证" :value="1"></el-option>
            <el-option label="护照" :value="2"></el-option>
            <el-option label="军官证" :value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="证件号码" prop="idNumber">
          <el-input v-model="currentContact.idNumber"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input v-model="currentContact.phone"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="contactDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveContact">保存</el-button>
      </div>
    </el-dialog>
  </Layout>
</template>

<script>
import Layout from '@/components/common/Layout';
import mockData from './mock.json';

export default {
  name: 'ProfileView',
  components: {
    Layout
  },
  data() {
    // 确认密码验证
    const validateConfirmPassword = (rule, value, callback) => {
      if (value !== this.passwordForm.newPassword) {
        callback(new Error('两次输入密码不一致'));
      } else {
        callback();
      }
    };
    
    return {
      activeTab: 'basic',
      navItems: [
        { key: 'basic', label: '基本信息', icon: 'el-icon-user' },
        { key: 'security', label: '安全设置', icon: 'el-icon-lock' }
      ],
      userInfo: {},
      passwordDialogVisible: false,
      passwordForm: {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      },
      passwordRules: {
        oldPassword: [
          { required: true, message: '请输入原密码', trigger: 'blur' }
        ],
        newPassword: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
          { min: 6, message: '密码长度不能小于6位', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请确认密码', trigger: 'blur' },
          { validator: validateConfirmPassword, trigger: 'blur' }
        ]
      },
      contactDialogVisible: false,
      currentContact: {
        id: null,
        name: '',
        idType: 1,
        idNumber: '',
        phone: ''
      },
      contactRules: {
        name: [
          { required: true, message: '请输入姓名', trigger: 'blur' }
        ],
        idType: [
          { required: true, message: '请选择证件类型', trigger: 'change' }
        ],
        idNumber: [
          { required: true, message: '请输入证件号码', trigger: 'blur' }
        ],
        phone: [
          { required: true, message: '请输入手机号码', trigger: 'blur' },
          { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
        ]
      },
      securitySettings: {
        passwordLastChanged: '2023-05-10',
        twoFactorEnabled: false,
        loginNotifications: true,
        lastLoginTime: '2023-10-15 14:30:22',
        lastLoginIP: '192.168.1.100'
      }
    };
  },
  created() {
    // 从mock数据加载
    this.userInfo = mockData.userInfo;
    this.securitySettings = mockData.securitySettings;
  },
  methods: {
    // 处理头像上传
    handleAvatarUpload(e) {
      const file = e.target.files[0];
      if (!file) return;
      
      // 实际应该调用API上传
      /*
      const formData = new FormData();
      formData.append('avatar', file);
      
      this.postRequest('/user/avatar/upload', formData).then(resp => {
        if (resp && resp.data && resp.data.code === 200) {
          this.userInfo.avatar = resp.data.data.url;
          this.$message.success('头像上传成功');
        } else {
          this.$message.error(resp?.data?.msg || '头像上传失败');
        }
      }).catch(error => {
        console.error('头像上传失败:', error);
        this.$message.error('头像上传失败');
      });
      */
      
      // 模拟上传成功
      const reader = new FileReader();
      reader.onload = (e) => {
        this.userInfo.avatar = e.target.result;
        this.$message.success('头像上传成功');
      };
      reader.readAsDataURL(file);
    },
    
    // 保存基本信息
    saveBasicInfo() {
      // 实际应该调用API
      /*
      this.postRequest('/user/info/update', this.userInfo).then(resp => {
        if (resp && resp.data && resp.data.code === 200) {
          this.$message.success('个人信息保存成功');
        } else {
          this.$message.error(resp?.data?.msg || '保存失败，请稍后重试');
        }
      }).catch(error => {
        console.error('保存个人信息失败:', error);
        this.$message.error('保存失败，请稍后重试');
      });
      */
      
      // 模拟成功
      this.$message.success('个人信息保存成功');
    },
    
    // 显示修改密码对话框
    showPasswordDialog() {
      this.passwordForm = {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      };
      this.passwordDialogVisible = true;
    },
    
    // 修改密码
    changePassword() {
      this.$refs.passwordForm.validate(valid => {
        if (valid) {
          // 实际应该调用API
          /*
          this.postRequest('/user/password/change', {
            oldPassword: this.passwordForm.oldPassword,
            newPassword: this.passwordForm.newPassword
          }).then(resp => {
            if (resp && resp.data && resp.data.code === 200) {
              this.$message.success('密码修改成功');
              this.passwordDialogVisible = false;
            } else {
              this.$message.error(resp?.data?.msg || '密码修改失败，请稍后重试');
            }
          }).catch(error => {
            console.error('密码修改失败:', error);
            this.$message.error('密码修改失败，请稍后重试');
          });
          */
          
          // 模拟成功
          this.$message.success('密码修改成功');
          this.passwordDialogVisible = false;
        }
      });
    },
    
    // 显示手机绑定对话框
    showPhoneDialog() {
      // 实现手机绑定逻辑
      this.$message.info('手机绑定功能开发中');
    },
    
    // 显示邮箱绑定对话框
    showEmailDialog() {
      // 实现邮箱绑定逻辑
      this.$message.info('邮箱绑定功能开发中');
    },
    
    // 显示联系人对话框
    showContactDialog(contact) {
      if (contact) {
        // 编辑现有联系人
        this.currentContact = JSON.parse(JSON.stringify(contact));
      } else {
        // 添加新联系人
        this.currentContact = {
          id: null,
          name: '',
          idType: 1,
          idNumber: '',
          phone: ''
        };
      }
      this.contactDialogVisible = true;
    },
    
    // 保存联系人
    saveContact() {
      this.$refs.contactForm.validate(valid => {
        if (valid) {
          // 实际应该调用API
          /*
          const url = this.currentContact.id 
            ? '/user/contacts/update' 
            : '/user/contacts/add';
            
          this.postRequest(url, this.currentContact).then(resp => {
            if (resp && resp.data && resp.data.code === 200) {
              this.$message.success('联系人保存成功');
              this.contactDialogVisible = false;
              this.fetchContacts(); // 重新获取联系人列表
            } else {
              this.$message.error(resp?.data?.msg || '保存失败，请稍后重试');
            }
          }).catch(error => {
            console.error('保存联系人失败:', error);
            this.$message.error('保存失败，请稍后重试');
          });
          */
          
          // 模拟成功
          if (this.currentContact.id) {
            // 更新现有联系人
            const index = this.contacts.findIndex(item => item.id === this.currentContact.id);
            if (index !== -1) {
              this.contacts.splice(index, 1, this.currentContact);
            }
          } else {
            // 添加新联系人
            this.currentContact.id = Date.now(); // 生成临时ID
            this.contacts.push(this.currentContact);
          }
          
          this.$message.success('联系人保存成功');
          this.contactDialogVisible = false;
        }
      });
    },
    
    // 启用/禁用两步验证
    toggleTwoFactor() {
      // 两步验证逻辑
    }
  }
};
</script>

<style lang="scss" scoped>
@import './styles/profile.scss';
</style> 