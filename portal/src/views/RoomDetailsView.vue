<template>
  <Layout>
    <div class="layout-container" style="width: 100%">
      <div class="breadcrumb-box">
        <div class="am-container">
          <ol class="am-breadcrumb">
            <li>
              <router-link to="/">首页</router-link>
            </li>
            <li>
              <router-link to="/product">客房信息</router-link>
            </li>
            <li class="am-active">客房详细信息</li>
          </ol>
        </div>
      </div>
    </div>
    <div class="solution-page">
      <div class="room-details-container">
        <div class="room-details">
          <div class="room-image-container">
            <img :src="room.cover" alt="Room Image" class="room-image"/>
          </div>
          <div class="room-info-container">
            <div class="container">
              <h2 class="room-title">{{ room.typeName }}</h2>
              <p class="room-info">酒店名称: {{ room.hotelName }}</p>
              <p class="room-info">位置: {{ room.location }}</p>
              <p class="room-info">房间号: {{ room.roomNumber }}</p>
              <p class="room-info">价格: ¥{{ room.price }}/天</p>
              <p class="room-info">房间介绍: {{ room.description }}</p>
              <p class="room-status">入住状态: {{ room.status == 0 ? '可入住' : '已被他人入住' }}</p>
              <!--                <b-button size="lg" id="show-btn" class="am-icon-bed" variant="success" @click="openModal">-->
              <!--                  点击入住-->
              <!--                </b-button>-->
              <am-button @click="showConfirm" class="am-icon-bed" v-if="room.status ==0 ">立即入住</am-button>

              <am-confirm :is-show.sync="confirmVisible" title="入住确认" @cancel="cancelHandle"
                          @confirm="confirmHandle">
                <span style="float: left;font-size:14px;">入住天数</span>
                <am-input type="number" placeholder="请选择入住天数" min="1" v-model="day"/>
              </am-confirm>

            </div>
          </div>
        </div>

      </div>
    </div>
    <div v-if="modalVisible">
      <!-- 模态框内容 -->
    </div>


  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout";

export default {
  name: "ProductDetailsView",
  components: {Layout},
  data() {
    return {
      title: '',
      introduction: '',
      activePhoto: 0,
      photos: [],
      room: {},
      day: 1,
      confirmVisible: false
    };
  },
  mounted() {
    this.getRoomDetails(this.$route.params.roomId);
  },
  methods: {
    showConfirm() {
      this.confirmVisible = true;

    },
    cancelHandle() {
      this.$notify({
        message: '取消成功',
        type: 'warning'

      });
      this.day = 1;

    },
    confirmHandle() {
      // 当前日期作为入住日期
      const checkInDate = new Date();
      const checkOutDate = new Date(checkInDate);
       // 将退房日期设为入住日期加3天
      checkOutDate.setDate(checkOutDate.getDate() + 3)

      // 创建请求体对象
      const payload = {
        roomId: this.$route.params.roomId,
        checkInDate: checkInDate.toISOString().split('T')[0],
        checkOutDate: checkOutDate.toISOString().split('T')[0],
        totalPrice: this.room.price,
        days: this.day,
      };

      // 使用请求体发送POST请求
      this.getRequestPost('/user/order/reservation', payload).then(resp => {
        if (resp) {
          this.$notify({
            message: '入住成功',
            type: 'success'
          });
          this.day = 1;
          this.getRoomDetails();
          this.$router.push({ name: 'room' });
        }
      });


    },

    getRoomDetails(roomId) {
      this.getRequest(`/user/room/getRoomDetails/${roomId}`).then(resp => {
        if (resp) {
          this.room = resp.data.data;
        }
      });
    },
    getProductById(typeDetailsId) {
      this.getRequest(`/findTypeDetailsByTypeDetailsId/${typeDetailsId}`).then(resp => {
        if (resp) {
          const temp = resp.data.data;
          this.title = temp.title;
          this.introduction = temp.introduction;
          const photos = [];
          for (let i = 1; i < 6; i++) {
            if (temp['imageUrl' + i] != null) {
              if (!photos.includes(temp['imageUrl' + i])) {
                photos.push(temp['imageUrl' + i]);
              }
            }
          }
          this.photos = photos;
        }
      });
    },
    nextPhoto() {
      this.activePhoto = (this.activePhoto + 1 < this.photos.length ? this.activePhoto + 1 : 0);
    },
    previousPhoto() {
      this.activePhoto = (this.activePhoto - 1 >= 0 ? this.activePhoto - 1 : this.photos.length - 1);
    }
  }
}
</script>

<style scoped>


.room-image {
  height: 200px;
  width: 100%;
  object-fit: cover;
  border-radius: 12px; /* 圆角边框 */
}

.room-title {
  font-size: 1.8em;
  margin-bottom: 10px;
}

.room-info, .room-status {
  font-size: 1.2em;
  margin: 5px 0;
}


.room-image {
  height: 300px;
  width: 100%;
  object-fit: cover;
  border-radius: 12px;
}

.container {
  padding: 30px;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.room-title {
  font-size: 2em;
  margin-bottom: 15px;
}

.room-info, .room-status {
  font-size: 1.2em;
  margin: 8px 0;
}

@media (max-width: 768px) {
  .room-image {
    height: 200px;
  }

  .room-title {
    font-size: 1.5em;
  }

  .room-info, .room-status {
    font-size: 1.2em;
  }
}

</style>
