<template>
  <Layout>
    <!-- 页面标题横幅 -->
    <div class="page-banner">
      <h1>我的订单</h1>
    </div>

    <div class="main-container">
      <!-- 搜索区域 -->
      <div class="search-section">
        <div class="filter-options">
          <el-select v-model="filterHotel" placeholder="选择酒店" clearable @change="handleSearch">
            <el-option
              v-for="item in hotelOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
          
          <el-select v-model="filterStatus" placeholder="订单状态" clearable @change="handleSearch">
            <el-option
              v-for="item in statusOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
          
          <el-date-picker
            v-model="dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="入住日期"
            end-placeholder="退房日期"
            format="yyyy-MM-dd"
            value-format="yyyy-MM-dd"
            @change="handleSearch">
          </el-date-picker>
        </div>
        
        <div class="search-box">
          <el-input
            v-model="searchQuery"
            placeholder="输入预定号或酒店名称搜索"
            prefix-icon="el-icon-search"
            clearable
            @keyup.enter.native="handleSearch"
          />
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </div>
      </div>

      <!-- 订单表格 -->
      <div class="order-table">
        <el-table
          :data="orderList"
          style="width: 100%"
          border
          stripe
          :header-cell-style="{background:'#f5f7fa', color:'#606266'}"
        >
          <el-table-column prop="orderId" label="预定号" width="100" align="center" sortable />
          <el-table-column prop="hotelName" label="酒店名称" min-width="150" align="center" />
          <el-table-column prop="roomType" label="客房类型" min-width="150" align="center" />
          <el-table-column prop="price" label="花费金额" width="120" align="center">
            <template slot-scope="scope">
              {{ scope.row.price }} 元
            </template>
          </el-table-column>
          <el-table-column prop="checkInDate" label="预约入住日期" width="150" align="center" sortable />
          <el-table-column prop="checkOutDate" label="预约退房日期" width="150" align="center" sortable />
          <el-table-column prop="status" label="结算状态" width="120" align="center">
            <template slot-scope="scope">
              <el-tag :type="getStatusType(scope.row.status)">
                {{ getStatusText(scope.row.status) }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="120" align="center">
            <template slot-scope="scope">
              <el-button 
                v-if="scope.row.status === 'booked'" 
                type="primary" 
                size="small" 
                @click="handleCheckout(scope.row)"
                class="action-button"
              >
                退房
              </el-button>
              <el-button 
                v-if="scope.row.status === 'checkout' && !scope.row.isEvaluated" 
                type="success" 
                size="small" 
                @click="handleEvaluate(scope.row)"
                class="action-button"
              >
                评价
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>

      <!-- 分页 -->
      <div class="pagination-container">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[10, 20, 30, 50]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          background
        />
      </div>
    </div>

    <!-- 评价对话框 -->
    <el-dialog title="订单评价" :visible.sync="evaluateDialogVisible" width="500px">
      <el-form :model="evaluateForm" label-width="80px">
        <el-form-item label="评分">
          <el-rate
            v-model="evaluateForm.rating"
            :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
            show-text
            :texts="['很差', '较差', '一般', '较好', '很好']"
          />
        </el-form-item>
        <el-form-item label="评价内容">
          <el-input
            type="textarea"
            v-model="evaluateForm.content"
            :rows="4"
            placeholder="请输入您对本次住宿的评价..."
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="evaluateDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitEvaluate">提交评价</el-button>
      </div>
    </el-dialog>
  </Layout>
</template>

<script>
import { formatDate } from '@/utils/dateUtil';
import Layout from '@/components/common/Layout';

export default {
  name: 'OrderView',
  components: {
    Layout
  },
  data() {
    return {
      searchQuery: '',
      filterHotel: '',
      filterStatus: '',
      dateRange: null,
      currentPage: 1,
      pageSize: 10,
      total: 0,
      orderList: [],
      evaluateDialogVisible: false,
      evaluateForm: {
        orderId: '',
        rating: 5,
        content: ''
      },
      currentOrder: null,
      hotelOptions: [],
      statusOptions: []
    };
  },
  created() {
    // 从mock数据加载选项
    this.loadOptions();
    this.fetchOrders();
  },
  methods: {
    // 加载选项数据
    loadOptions() {
      // 实际应该调用API
      /*
      this.getRequest('/user/hotels/options').then(resp => {
        if (resp && resp.data && resp.data.code === 200) {
          this.hotelOptions = resp.data.data.hotelOptions;
          this.statusOptions = resp.data.data.statusOptions;
        }
      }).catch(error => {
        console.error('获取选项数据失败:', error);
      });
      */
      
      // 从mock.json加载数据
      import('@/views/front/order/mock.json').then(data => {
        this.hotelOptions = data.hotelOptions;
        this.statusOptions = data.statusOptions;
      }).catch(error => {
        console.error('加载选项数据失败:', error);
      });
    },
    // 获取订单列表
    fetchOrders() {
      // 实际应该调用API
      /*
      this.getRequest('/user/orders/list', {
        page: this.currentPage,
        size: this.pageSize,
        query: this.searchQuery,
        hotel: this.filterHotel,
        status: this.filterStatus,
        checkInDate: this.dateRange ? this.dateRange[0] : null,
        checkOutDate: this.dateRange ? this.dateRange[1] : null
      }).then(resp => {
        if (resp && resp.data && resp.data.code === 200) {
          this.orderList = resp.data.data.records;
          this.total = resp.data.data.total;
        }
      }).catch(error => {
        console.error('获取订单列表失败:', error);
      });
      */
      
      // 从mock.json加载数据
      import('@/views/front/order/mock.json').then(data => {
        const mockOrders = data.orders;
        
        // 筛选数据
        let filteredOrders = [...mockOrders];
        
        if (this.searchQuery) {
          const query = this.searchQuery.toLowerCase();
          filteredOrders = filteredOrders.filter(order => 
            order.orderId.toString().includes(query) || 
            order.hotelName.toLowerCase().includes(query)
          );
        }
        
        if (this.filterHotel) {
          filteredOrders = filteredOrders.filter(order => 
            order.hotelName === this.filterHotel
          );
        }
        
        if (this.filterStatus) {
          filteredOrders = filteredOrders.filter(order => 
            order.status === this.filterStatus
          );
        }
        
        if (this.dateRange && this.dateRange.length === 2) {
          const startDate = new Date(this.dateRange[0]);
          const endDate = new Date(this.dateRange[1]);
          
          filteredOrders = filteredOrders.filter(order => {
            const checkIn = new Date(order.checkInDate);
            const checkOut = new Date(order.checkOutDate);
            
            return (checkIn >= startDate && checkIn <= endDate) || 
                   (checkOut >= startDate && checkOut <= endDate) ||
                   (checkIn <= startDate && checkOut >= endDate);
          });
        }
        
        this.orderList = filteredOrders;
        this.total = filteredOrders.length;
      }).catch(error => {
        console.error('加载订单数据失败:', error);
        this.orderList = [];
        this.total = 0;
      });
    },
    
    // 处理搜索
    handleSearch() {
      this.currentPage = 1;
      this.fetchOrders();
    },
    
    // 重置搜索
    resetSearch() {
      this.searchQuery = '';
      this.filterHotel = '';
      this.filterStatus = '';
      this.dateRange = null;
      this.currentPage = 1;
      this.fetchOrders();
    },
    
    // 处理分页大小变化
    handleSizeChange(val) {
      this.pageSize = val;
      this.fetchOrders();
    },
    
    // 处理当前页变化
    handleCurrentChange(val) {
      this.currentPage = val;
      this.fetchOrders();
    },
    
    // 获取状态类型（用于标签颜色）
    getStatusType(status) {
      const statusMap = {
        'booked': 'primary',   // 已入住
        'paid': 'success',     // 已评价
        'checkout': 'info',    // 已退房，完成订单
        'cancelled': 'danger'  // 已取消
      };
      return statusMap[status] || 'info';
    },
    
    // 获取状态文本
    getStatusText(status) {
      const statusMap = {
        'booked': '已入住',
        'paid': '已评价',
        'checkout': '已退房',
        'cancelled': '已取消'
      };
      return statusMap[status] || '未知状态';
    },
    
    // 处理退房
    handleCheckout(order) {
      this.$confirm('确定要办理退房吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 实际应该调用API
        /*
        this.postRequest('/user/orders/checkout', {
          orderId: order.orderId
        }).then(resp => {
          if (resp && resp.data && resp.data.code === 200) {
            this.$message.success('退房成功');
            this.fetchOrders();
          } else {
            this.$message.error(resp?.data?.msg || '退房失败，请稍后重试');
          }
        }).catch(error => {
          console.error('退房失败:', error);
          this.$message.error('退房失败，请稍后重试');
        });
        */
        
        // 模拟成功
        this.$message.success('退房成功');
        const index = this.orderList.findIndex(item => item.orderId === order.orderId);
        if (index !== -1) {
          this.orderList[index].status = 'checkout';
        }
      }).catch(() => {
        // 取消退房
      });
    },
    
    // 处理评价
    handleEvaluate(order) {
      this.currentOrder = order;
      this.evaluateForm.orderId = order.orderId;
      this.evaluateForm.rating = 5;
      this.evaluateForm.content = '';
      this.evaluateDialogVisible = true;
    },
    
    // 提交评价
    submitEvaluate() {
      if (!this.evaluateForm.content) {
        this.$message.warning('请输入评价内容');
        return;
      }
      
      // 实际应该调用API
      /*
      this.postRequest('/user/orders/evaluate', this.evaluateForm).then(resp => {
        if (resp && resp.data && resp.data.code === 200) {
          this.$message.success('评价提交成功');
          this.evaluateDialogVisible = false;
          this.fetchOrders();
        } else {
          this.$message.error(resp?.data?.msg || '评价提交失败，请稍后重试');
        }
      }).catch(error => {
        console.error('评价提交失败:', error);
        this.$message.error('评价提交失败，请稍后重试');
      });
      */
      
      // 模拟成功
      this.$message.success('评价提交成功');
      this.evaluateDialogVisible = false;
      
      if (this.currentOrder) {
        const index = this.orderList.findIndex(item => item.orderId === this.currentOrder.orderId);
        if (index !== -1) {
          this.orderList[index].status = 'paid';
          this.orderList[index].isEvaluated = true;
        }
      }
    },
    
    // 格式化日期
    formatDate(date) {
      return formatDate(date, 'YYYY-MM-DD');
    }
  }
};
</script>

<style lang="scss" scoped>
@import './styles/order.scss';
</style> 