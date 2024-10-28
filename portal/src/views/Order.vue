<template>

  <Layout>
    <div class="layout-container" style="width: 100%">
      <div class="page-header">
        <div class="am-container">
          <h1 class="page-header-title">我的订单</h1>
        </div>
      </div>
      <div class="breadcrumb-box">
        <div class="am-container">

          <ol class="am-breadcrumb">
            <li>
              <router-link to="/">首页</router-link>
            </li>
            <li class="am-active">我的订单</li>
          </ol>
          <b-container fluid>
            <b-row>
              <b-col lg="12" class="my-1">
                <b-form-group
                    label="搜索订单号"
                    size="lg"
                    label-for="filterInput"
                    id="filterLabel"
                >
                  <b-input-group size="lg">
                    <b-form-input
                        v-model="filter"
                        type="search"
                        id="filterInput"
                        placeholder="输入预定号进行搜索"
                    ></b-form-input>
                    <am-button size="sm" color="primary" style="margin: 0px 15px " @click="seachFilter">搜索</am-button>
                    <b-input-group-append>
                      <b-button :disabled="!filter" @click="clearFilter">Clear</b-button>
                    </b-input-group-append>
                  </b-input-group>
                </b-form-group>

              </b-col>


            </b-row>

            <!-- Main table element -->
            <b-table
                show-empty
                small
                stacked="md"
                :items="orderList"
                :fields="fields"
                :current-page="currentPage"
                :per-page="perPage"
                :filterIncludedFields="filterOn"
                :sort-by.sync="sortBy"
                :sort-desc.sync="sortDesc"
                :sort-direction="sortDirection"
            >
              <template v-slot:cell(name)="row">
                {{ row.value.first }} {{ row.value.last }}
              </template>

              <template v-slot:cell(actions)="row">


                <am-button @click="checkOut(row.item)" :round="true" color="primary"
                           v-if="row.item.status ==  '已入住'">退房
                </am-button>
                <am-button @click="evaluate(row.item)" :round="true" color="secondary"
                           v-if="row.item.status ==  '已退房，完成订单'">
                  评价
                </am-button>
                <!--                <b-button size="sm" v-if="row.item.status == '已退房，完成订单'"-->
                <!--                          @click="info(row.item, row.index, $event.target)"-->
                <!--                          class="mr-1">-->
                <!--                  评价-->
                <!--                </b-button>-->

              </template>

              <template v-slot:row-details="row">
                <b-card>
                  <ul>
                    <li v-for="(value, key) in row.item" :key="key">

                      <template>
                        {{ key }}: {{ value }}
                      </template>
                    </li>
                  </ul>
                </b-card>
              </template>
            </b-table>


            <div class="pagination-container">
              <el-pagination
                  @size-change="handleSizeChange"
                  @current-change="handleCurrentChange"
                  background
                  :total="totalRows"
                  :page-sizes="[10, 20, 30, 40]"
                  :page-size="size"
                  layout="total, sizes, prev, pager, next, jumper"
              ></el-pagination>
            </div>


            <b-modal v-model="evaluationModalVisible" :id="infoModal.id" :title="infoModal.title" ok-only
                     @hide="resetInfoModal" @ok="handleOk">
              <AwesomeVueStarRating
                  :star="this.star"
                  :disabled="this.disabled"
                  :maxstars="this.maxstars"
                  :totalStars="false"
                  :starsize="this.starsize"
                  :hasresults="false"
                  :hasdescription="this.hasdescription"
                  :ratingdescription="this.ratingdescription"/>
              <am-input type="textarea" size="lg" resize="2000" v-model="evaluationComment"
                        placeholder="请输入评价内容"></am-input>
            </b-modal>
          </b-container>

        </div>
      </div>

    </div>
  </Layout>
</template>
<script>
import Layout from "@/components/common/Layout.vue";

import AwesomeVueStarRating from "awesome-vue-star-rating";

export default {
  //eslint-disable-next-line vue/multi-word-component-names
  name: "order",
  components: {
    Layout, AwesomeVueStarRating
  },
  data() {
    return {
      orderList: [],
      fields: [
        {key: 'reservationId', label: '预定号', sortable: true, sortDirection: 'desc'},
        {key: 'hotelName', label: '酒店名称', sortDirection: 'desc'},
        {key: 'typeName', label: '客房类型', sortable: true, class: 'text-center'},
        {key: 'totalPrice', label: '花费金额', sortable: true, class: 'text-center'},
        {key: 'checkInDate', label: '预约入住日期', sortable: true, class: 'text-center'},
        {key: 'checkOutDate', label: '预约退房日期', sortable: true, class: 'text-center'},
        {key: 'status', label: '结算状态', sortable: true, class: 'text-center'},

        {key: 'actions', label: '操作'}
      ],
      current: 1,
      size: 10,
      totalRows: 0,
      sortBy: '',
      sortDesc: false,
      sortDirection: 'asc',
      filter: null,
      filterOn: [],
      evaluationComment: "",
      infoModal: {
        id: 'info-modal',
        title: '评价内容',
        content: ''
      },
      evaluationModalVisible: false,
      star: 5,
      ratingdescription: [
        {
          text: "差评",
          class: "star-poor",
        },
        {
          text: "凑合",
          class: "star-belowAverage",
        },
        {
          text: "一般",
          class: "star-average",
        },
        {
          text: "满意",
          class: "star-good",
        },
        {
          text: "非常满意",
          class: "star-excellent",
        },
      ],
      hasresults: true,
      hasdescription: true,
      starsize: "lg", //[xs,lg,1x,2x,3x,4x,5x,6x,7x,8x,9x,10x],
      maxstars: 5,
      disabled: false,
      hasresults2: true,
      hasdescription2: true,
      starsize2: "lg", //[xs,lg,1x,2x,3x,4x,5x,6x,7x,8x,9x,10x],
      maxstars2: 5,
      disabled2: false,
      starsize3: "xs",
      order: null,
      originalOrderList: [],

    }
  },
  computed: {
    sortOptions() {
      // Create an options list from our fields
      return this.fields
      .filter(f => f.sortable)
      .map(f => {
        return {text: f.label, value: f.key}
      })
    }
  },


  mounted() {
    // Set the initial number of items
    this.totalRows = this.orderList.length
    this.getList();
  },
  methods: {
    clearFilter(){
      this.filter = '';
      this.orderList = [...this.originalOrderList]; // Revert to the full list if no matches

    },
    seachFilter() {

      const filteredOrders = this.originalOrderList.filter(order =>
          order.reservationId && order.reservationId.toString().includes(this.filter)
      );

      if (filteredOrders.length > 0) {
        this.orderList = filteredOrders; // Update with filtered list
      } else {
        this.orderList = [...this.originalOrderList]; // Revert to the full list if no matches
      }

    },
    handleOk() {
      const params =
          `?hotelId=${this.order.hotelId}&rating=${this.star}&comment=${this.evaluationComment}&reservationId=${this.order.reservationId}&roomId=${this.order.roomId}`
      this.getRequestPost(`/user/order/evaluate${params}`).then(resp => {
        if (resp.data.code === 200) {
          this.getList();
          this.$notify.success("评价成功");
          this.evaluationModalVisible = false;
        }
      }).catch(error => {
        console.error('Logout request failed:', error);
      });
      // Trigger submit handler
    },
    evaluate(order) {
      this.evaluationModalVisible = true;
      this.order = order;

    },
    checkOut(order) {
      const _ins = this.$loading({"loadingText": "退房结算中，请稍后"});
      const reservation = {
        reservationId: order.reservationId,
        roomId: order.roomId,
        hotelName: order.hotelName,
        typeName: order.typeName,
        totalPrice: order.totalPrice,
        checkInDate: order.checkInDate,
        checkOutDate: new Date(),
      }
      this.getRequestPost(`/user/order/checkOut`, reservation).then(resp => {
        if (resp.data.code === 200) {
          setTimeout(() => {
            _ins.close();
          }, 300);
          this.getList();
        }
      }).catch(error => {
        console.error('Logout request failed:', error);
      });

    },
    handleCurrentChange(val) {
      this.current = val;
      this.getList();
    },
    handleSizeChange(val) {
      this.size = val;
      this.getList();
    },

    getList() {
      this.getRequest(`/user/order/getList?current=${this.current}&size=${this.size}`).then(resp => {
        if (resp.data.code === 200) {
          this.orderList = resp.data.data;
          this.totalRows = resp.data.total;
          this.originalOrderList = this.orderList;

        }
      }).catch(error => {
        console.error('Logout request failed:', error);
      });
    },

    info(item, index, button) {
      this.infoModal.title = `退房`
      this.infoModal.content = ""
      this.$root.$emit('bv::show::modal', this.infoModal.id, button)
    },
    resetInfoModal() {
      this.infoModal.title = ''
      this.infoModal.content = ''
      this.evaluationComment = "";

    },
    onFiltered(filteredItems) {
      console.log(filteredItems + "2222222");
    }
  }

}
</script>

<style lang="scss">
.star {
  color: red;
}

.star.active {
  color: red;
}

.list, .list.disabled {
  &:hover {
    .star {
      color: red !important;
    }

    .star.active {
      color: red;
    }
  }
}

.pagination-container {
  text-align: center;
}
</style>

