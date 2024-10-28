<template>
	<Layout>
		<div class="layout-container" style="width: 100%">
			<div class="page-header">
				<div class="am-container">
					<h1 class="page-header-title">公告信息</h1>
				</div>
			</div>

      <div class="breadcrumb-box">
        <div class="am-container">
          <ol class="am-breadcrumb">
            <li><router-link to="/">首页</router-link></li>
            <li class="am-active">酒店动态</li>
          </ol>
          <ul class="am-list am-list-static am-list-border">
            <li v-for="item in announcements" :key="item.hotelId">
              <span>{{ item.hotels.hotelName }}</span>公告:
              <span>{{ item.message }}</span>
              <span class="am-badge am-badge-success">{{ item.createdAt }}</span>
              {{ item.text }}
            </li>
          </ul>

        </div>
        </div>
      </div>



	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
export default {
	name: "NewsView",
	components: {Layout},
	data(){
    return {
      announcements: [
        //{ text: "公告一：酒店即将举办大型活动。", date: "2024-10-30" },
        //{ text: "公告二：餐厅推出新菜品。", date: "2024-10-31" },
        //{ text: "公告三：游泳池维护通知。", date: "2024-11-01" },
        //{ text: "公告四：客房优惠活动开启。", date: "2024-11-02" },
      ],
      articles: {
        records: [
          {
            articleId: 1,
            title: "新闻标题 1",
            cover: "https://via.placeholder.com/300x200",
            createTime: "2024-10-25",
            introduction: "新闻简介 1"
          },
          {
            articleId: 2,
            title: "新闻标题 2",
            cover: "https://via.placeholder.com/300x200",
            createTime: "2024-10-24",
            introduction: "新闻简介 2"
          },
          {
            articleId: 3,
            title: "新闻标题 3",
            cover: "https://via.placeholder.com/300x200",
            createTime: "2024-10-23",
            introduction: "新闻简介 3"
          }
        ],
      },
      pageIndex: {
        current: 1,
        size:10
      },
    };
	},
	mounted() {
		this.getArticle(1);
    this.getAnnouncements(this.pageIndex);
	},
	methods:{
		getArticle(pageIndex){
			this.getRequest(`/findArticles/${pageIndex}`).then(resp =>{
				if (resp){
					this.articles = resp.data.data
					console.log(this.articles)

				}
			})
		},
    getAnnouncements(pageIndex){

      this.getRequest(`/hotel_notifications/notifications/list/data`,pageIndex).then(resp =>{
        if (resp){
          this.announcements = resp.data.data

        }
      })
    },
		changeIndex(p){
			if (p === 0){
				this.pageIndex = 1
			}else if (p === this.articles.pages + 1){
				this.pageIndex = this.articles.pages
			}else{
				this.pageIndex = p;
				this.getArticle(p)
			}
		}
	}
}
</script>

<style scoped>


.am-breadcrumb {
  margin-right: 20px; /* 面包屑和列表之间的间隔 */
}

.am-list {
  list-style: none; /* 去掉列表前的点 */
  padding: 0;
}
</style>
