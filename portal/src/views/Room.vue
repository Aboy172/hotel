<template>
  <Layout>

    <div class="layout-container" style="width: 100%">
      <div class="page-header">
        <div class="am-container">
          <h1 class="page-header-title">客房信息</h1>
        </div>
      </div>
      <div class="breadcrumb-box">
        <div class="am-container">
          <ol class="am-breadcrumb">
            <li>
              <router-link to="/">首页</router-link>
            </li>
            <li class="am-active">客房信息</li>
          </ol>
        </div>
      </div>
    </div>

    <div class="section">
      <div class="am-u-lg">
        <div class="am-input-group am-input-group-primary">
          <input type="text" class="am-form-field" placeholder="请输入客房号" v-model="query">
          <span class="am-input-group-btn">
            <button class="am-btn am-btn-primary" type="button"
                    @click="searchQuery()"><span class="am-icon-search"></span></button>
          </span>
        </div>
      </div>
      <div class="container">
        <div class="solution-container">

          <div class="filter-wrapper">
            <div class="filter-label">房间类型：</div>
            <select class="styled-select"  v-model="selectedRoomType">
              <option v-for="type in roomTypeList" :key="type.roomTypeId" :value="type.roomTypeId">{{ type.typeName
                }}</option>
            </select>
          </div>
          <div class="filter-wrapper">
            <div class="filter-label">入住状态：</div>
            <div class="radio-group">
              <label class="radio-inline">
                <input type="radio" name="status" value="0" v-model="selectedStatus"> 已被他人入住
              </label>
              <label class="radio-inline">
                <input type="radio" name="status" value="1" v-model="selectedStatus"> 可入住
              </label>
            </div>
          </div>
        </div>
        <div class="solution-container">
          <div data-am-widget="tabs" class="am-tabs ">
            <div class="am-g">
              <div class="am-u-md-3" v-for="(room,index) in roomList" :key="index">
                <div class="features_item">
                  <router-link :to="`/room/roomId/${room.roomId}`">
                    <img :src="room.cover" alt="Room Image" class="rounded-image">
                  </router-link>

                  <p> 酒店名称：{{ room.hotelId }}</p>
                  <p>客房号：{{ room.roomNumber }}</p>
                  <p>客房类型：{{ room.roomTypeName }}</p>
                  <p>入住状态：{{ room.status == 0 ? '可入住' : '已被他人入住' }}</p>


                </div>
              </div>
            </div>

          </div>
        </div>
      </div>

    </div>

  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout";

export default {
  name: "ProductView",
  components: {Layout},
  data() {
    return {
      roomTypeList: [],
      roomList: [],
      query:"",
      selectedRoomType: null,
      selectedStatus: '', // 入住状态选择
      list: [],
      tabIndex: 0,
      goodsList: [],
    }
  },
  mounted() {
    this.getRoomTypeList()
    //this.getGoodsList(1)
    this.getAdvantageList();
    this.getRoomList();
  },
  methods: {
    searchQuery(){
      let params = '';

      if (this.query) {
        params += `roomNumber=${this.query}&`;
      }
      console.log(this.selectedRoomType);
      if (this.selectedRoomType) {
        params += `roomTypeId=${this.selectedRoomType}&`;
      }

      if (this.selectedStatus) {
        params += `status=${this.selectedStatus}&`;
      }
      this.getRequest(`/user/room/query?${params}`).then(resp => {
        if (resp) {
          this.roomList = resp.data.data
          //console.log(resp.data.data)
          this.roomList = resp.data.data.map(room => {
            const matchedType = this.roomTypeList.find(type => type.roomTypeId === room.roomTypeId);
            if (matchedType) {

              room.roomTypeName = matchedType.typeName;
            }
            return room;
          });
          console.log( this.roomList)
        }
      })
    },
    getRoomTypeList() {
      this.getRequest("/room_types/types/list/data").then(resp => {
        if (resp) {
          this.roomTypeList = resp.data.data;

          this.roomTypeList.push({ typeId: 0, typeName: "全部" });
          this.roomTypeList.sort((a, b) => b.typeId - a.typeId);

        }
      })
    },
    getRoomList() {
      let params = '';

      if (this.query) {
        params += `roomNumber=${this.query}&`;
      }
      console.log(this.selectedRoomType);
      if (this.selectedRoomType) {
        params += `roomTypeId=${this.selectedRoomType}&`;
      }

      if (this.selectedStatus) {
        params += `status=${this.selectedStatus}&`;
      }
      this.getRequest(`/rooms/rooms/list/data?${params}`).then(resp => {

        if (resp) {
          this.roomList = resp.data.data
          //console.log(resp.data.data)
          this.roomList = resp.data.data.map(room => {
            const matchedType = this.roomTypeList.find(type => type.roomTypeId === room.roomTypeId);
            if (matchedType) {

              room.roomTypeName = matchedType.typeName;
            }
            return room;
          });
          console.log( this.roomList)
        }
      })
    },
    getAdvantageList() {
      this.getRequest("/user/hotels/findAdvantageList").then(resp => {
        if (resp) {
          this.roomList = resp.data.data;
          console.log(this.roomList)
        }
      })
    },
    changeTab(index, typeId) {
      this.tabIndex = index
      console.log(typeId)
      this.getGoodsList(typeId)
    },
    //getGoodsList(typeId) {
    //  this.getRequest(`/findTypeDetailsByTypeId/${typeId}`).then(resp => {
    //    if (resp) {
    //      this.goodsList = resp.data.data
    //      //console.log(resp.data.data)
    //    }
    //  })
    //},
    handleDetails(productId) {
      this.$router.push({path: `/product/productId/${productId}`})
    }
  }
}
</script>

<style scoped>
.solution-container {
  padding: 20px;
}
.filter-wrapper {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
  padding: 5px;
}
.filter-label {
  margin-right: 10px;
  font-weight: bold;
}
.styled-select {
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="10" height="6"><path d="M0 0L5 6L10 0"/></svg>');
  background-repeat: no-repeat;
  background-position: right center;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 5px 10px;
}
.radio-group label {
  margin-right: 20px;
}
/* 给筛选部分添加外边框 */
.solution-container:first-child {
  border: 1px solid #ddd;
  padding: 15px;
}
/* 给房间列表部分添加外边框 */
.solution-container:last-child {
  border: 1px solid #ddd;
  padding: 15px;
}
.features_item {
  border-radius: 10px; /* 圆角值可以根据需要调整 */
  overflow: hidden; /* 防止内容溢出容器的圆角 */
}
.rounded-image {
  border-radius: 10px; /* 图片的圆角值 */
}
.am-input-group {
  border-radius: 5px;

}
.am-btn.am-btn-primary {
  margin-left: 5px;
  border-radius: 5px;
  padding-top:3px;
}
h3 {
  text-align:left;
}
p{
  text-align:left;
}




</style>
