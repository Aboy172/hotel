<template>
  <Layout>
    <div class="layout-container" style="width: 100%">
      <div class="page-header">
        <div class="am-container">
          <h1 class="page-header-title">投诉页面</h1>
        </div>
      </div>
      <div class="breadcrumb-box">
        <div class="am-container">
          <ol class="am-breadcrumb">
            <li>
              <router-link to="/">首页</router-link>
            </li>
            <li class="am-active">投诉页面</li>
          </ol>
          <div class="complaint-section">
            <p>如果您对我们的服务有任何不满或投诉，请填写以下信息，我们将尽快处理。</p>
            <form>
              <div class="form-group">
                <label for="categorySelect">投诉酒店</label>
                <select id="categorySelect" v-model="selectedCategory">
                  <option v-for="hotel in hotelList" :key="hotel.hotelId" :value="hotel.hotelName">
                    {{ hotel.hotelName }}
                  </option>
                </select>
              </div>
              <div class="form-group">
                <label for="complaintSubject">投诉主题</label>
                <input type="text" id="complaintSubject" class="form-control"/>
              </div>
              <div class="form-group">
                <label for="complaintDetails">投诉详情</label>
                <textarea id="complaintDetails" class="form-control" v-model="description"></textarea>
              </div>
              <am-button color="secondary" @click="submitComplaint">提交投诉</am-button>
            </form>
          </div>
        </div>
      </div>

    </div>

  </Layout>
</template>

<script>
import Layout from "@/components/common/Layout";

export default {
  name: "AboutView",
  components: {Layout},
  data() {
    return {
      companyInfo: {},
      designers: [],
      selectedCategory: "",
      hotelList: null,
      description: "",
    }
  },
  mounted() {
    this.getHotels()
  },
  methods: {
    getHotels() {
      this.getRequest("/hotels/hotels/list/data").then(resp => {
        if (resp.data.code === 200) {
          this.hotelList = resp.data.data;
        }
      }).catch(error => {
        console.error('Logout request failed:', error);
      });
    },
    submitComplaint() {
      let hotelId = "";
      const selectedHotel = this.hotelList.find(hotel => hotel.hotelName === this.selectedCategory);
      if (selectedHotel) {
        hotelId = selectedHotel.hotelId; // or whatever property you need to access
      }
      const params = `?hotelId=${hotelId}&description=${this.description}`
      this.getRequestPost(`/user/hotels/complaint${params}`).then(resp => {
        if (resp.data.code === 200) {
          this.$notify({
            message: '提交成功，我们会尽快处理的',
            type: 'success'

          });
          this.description = "";
        }
      }).catch(error => {
        console.error('Logout request failed:', error);
      });
    }

  }
}
</script>

<style scoped>
.complaint-section {
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  background-color: #fff;
}

.form-group {
  margin-bottom: 15px;
}

label {
  font-weight: bold;
}

input[type="text"],
textarea {
  width: 100%;
}

select {
  width: 100%;
}
</style>
