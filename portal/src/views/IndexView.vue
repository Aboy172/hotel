<template>
	<Layout>
		<div  style="width: 100%">

			<div class="index-page">
				<div data-am-widget="tabs" class="am-tabs am-tabs-default">
					<div class="am-tabs-bd">
						<div
							class="am-tab-panel am-active"
							v-if="slideshow.length > 0"
							:style="{ backgroundImage: `url(${slideshow[tabIndex].imageUrl})`}">
							<div class="index-banner">
								<div class="index-mask">
									<div class="container">
										<div class="am-g">
											<div class="am-u-md-10 am-u-sm-centered" style="text-align: center">
												<h1 class="slide_simple--title">企业移动化，首选云适配</h1>
												<p class="slide_simple--text am-text-left" style="display: flex;justify-content: center">
													全球领先的HTML5企业移动化解决方案供应商，安全高效的帮助您的企业移动化。云适配企业浏览器Enterploer,让企业安全迈进移动办公时代！
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>

		<div class="section">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">酒店推荐</h2>

				</div>

        <div class="index-container">
          <div class="am-g">
            <div class="am-u-md-3" v-for="(advantage,index) in advantageList" :key="index">
              <div class="features_item">
                <img :src="advantage.cover" alt="" class="rounded-image">

                <h3 class="features_item--title">{{advantage.hotelName}}</h3>
                <br/>
                <i style="color:#7c6aa6" class="contact-icon am-icon-map-marker">
                 {{advantage.location}}

                </i>


                <p class="features_item--text">{{advantage.description}}</p>
                <i style="color:#7c6aa6" class="contact-icon am-icon-genderless">
                  平均评分：{{advantage.rating}}

                </i>
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
	name: "IndexView",
	components: {Layout},
  computed: {


  },
	data(){
		return{

			tabIndex: 0,
			slideshow:[],
			advantageList:[
			],
			serviceList:[
				{id:1,icon:'am-icon-diamond',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'},
				{id:2,icon:'am-icon-user',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'},
				{id:3,icon:'am-icon-umbrella',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'},
				{id:4,icon:'am-icon-briefcase',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'}
			]
		}
	},
	mounted() {
    this.getAdvantageList();
	},
	methods:{

    getAdvantageList(){
      this.getRequest("/user/hotels/findAdvantageList").then(resp=>{
        if (resp){
          this.advantageList = resp.data.data;
          console.log(this.advantageList)
        }
      })
    },


	},
}
</script>

<style scoped>
.features_item {
  border-radius: 15px; /* 圆角值可以根据需要调整 */
  overflow: hidden; /* 防止内容溢出容器的圆角 */
}

.rounded-image {
  border-radius: 15px; /* 图片的圆角值 */
}
</style>
