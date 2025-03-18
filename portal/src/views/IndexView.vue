<template>
	<Layout>
		<div style="width: 100%">
			<div class="index-page">
				<div class="banner-section">
					<el-carousel height="100vh" :interval="5000" arrow="always">
						<el-carousel-item v-for="item in sortedSlideshow" :key="item.id">
							<div class="banner-slide">
								<img :src="item.imageUrl" :alt="item.title" class="banner-image" @error="handleImageError" @load="handleImageLoad"/>
								<div class="banner-content">
									<h1>{{item.title}}</h1>
									<p>{{item.description}}</p>
									<el-button type="primary" size="large">立即预订</el-button>
								</div>
							</div>
						</el-carousel-item>
					</el-carousel>
				</div>
			</div>
		</div>

		<div class="section">
			<div class="container">
				<div class="section--header">
					<h2 class="section--title">酒店推荐</h2>
				</div>

				<div class="hotel-grid">
					<div class="hotel-card" v-for="(advantage,index) in advantageList" :key="index">
						<div class="hotel-image">
							<img :src="advantage.cover" alt="" class="rounded-image">
						</div>
						<div class="hotel-info">
							<h3 class="hotel-name">{{advantage.hotelName}}</h3>
							<div class="hotel-location">
								<i class="am-icon-map-marker"></i>
								<span>{{advantage.location}}</span>
							</div>
							<p class="hotel-desc">{{advantage.description}}</p>
							<div class="hotel-rating">
								<i class="am-icon-star"></i>
								<span>平均评分：{{advantage.rating}}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="section">
			<div class="container">
				<div class="section--header">
					<h2 class="section--title">热门房型</h2>
				</div>
				<div class="room-grid">
					<div class="room-card" v-for="(room, index) in hotRooms" :key="index">
						<div class="room-image">
							<img :src="room.image" :alt="room.name">
						</div>
						<div class="room-info">
							<h3 class="room-title">{{room.name}}</h3>
							<p class="room-desc">{{room.description}}</p>
							<div class="room-price">
								<span class="price">¥{{room.price}}</span>
								<span class="per-night">/晚</span>
								<el-button type="primary" size="small">立即预订</el-button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="service-section">
			<div class="container">
				<h2 class="section-title">酒店服务</h2>
				<div class="service-grid">
					<div class="service-item" v-for="(service, index) in services" :key="index">
						<div class="service-icon">
							<i :class="service.icon"></i>
						</div>
						<div class="service-content">
							<h3>{{service.title}}</h3>
							<p>{{service.description}}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="footer">
			<div class="container">
				<div class="footer-content">
					<div class="footer-section">
						<i class="am-icon-building"></i>
						<h3>关于我们</h3>
						<p>致力于为您提供优质的住宿体验</p>
					</div>
					<div class="footer-section">
						<i class="am-icon-phone"></i>
						<h3>联系方式</h3>
						<p>电话：400-888-8888</p>
						<p>邮箱：contact@hotel.com</p>
					</div>
					<div class="footer-section">
						<i class="am-icon-weixin"></i>
						<h3>关注我们</h3>
						<div class="social-icons">
							<i class="am-icon-weixin"></i>
							<i class="am-icon-weibo"></i>
						</div>
					</div>
				</div>
				<div class="footer-bottom">
					<p>© 2024 豪华酒店管理系统 版权所有 | ICP备案号：xxx</p>
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
		sortedSlideshow() {
			return this.slideshow.sort((a, b) => a.sort - b.sort);
		}
	},
	data(){
		return{
			tabIndex: 0,
			slideshow: [],
			advantageList:[
			],
			hotRooms: [
				{
					name: '豪华双床房',
					image: 'https://images.unsplash.com/photo-1590490360182-c33d57733427',
					description: '宽敞明亮，配备两张1.5米双人床',
					price: 688
				},
				{
					name: '行政套房',
					image: 'https://images.unsplash.com/photo-1591088398332-8a7791972843',
					description: '独立会客厅，商务办公首选',
					price: 1088
				},
				{
					name: '家庭套房',
					image: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
					description: '设施齐全，适合全家出行',
					price: 888
				}
			],
			services: [
				{
					icon: 'am-icon-wifi',
					title: '免费WiFi',
					description: '覆盖所有区域的高速网络'
				},
				{
					icon: 'am-icon-car',
					title: '免费停车',
					description: '提供24小时停车服务'
				},
				{
					icon: 'am-icon-coffee',
					title: '餐饮服务',
					description: '中西餐全天候供应'
				},
				{
					icon: 'am-icon-heartbeat',
					title: '健身中心',
					description: '专业健身设备一应俱全'
				}
			],
			isLoading: true
		}
	},
	mounted() {
		Promise.all([
			this.getCarouselList(),
			this.getAdvantageList()
		]).catch(error => {
			console.error('数据加载失败:', error);
		});
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
		getCarouselList(){
			return this.getRequest("/carousel/list").then(resp => {
				if (resp && resp.code === 0) {
					console.log('轮播图数据:', resp.data);
					this.slideshow = resp.data.map(item => ({
						id: item.id,
						imageUrl: item.url,
						title: item.name,
						description: '尽享奢华体验，给您家一般的温暖',
						sort: item.sort
					}));
					console.log('处理后的数据:', this.slideshow);
				}
			});
		},
		handleImageError(e) {
			console.error('图片加载失败:', e);
			e.target.src = 'path/to/default/image.jpg';
		},
		handleImageLoad() {
			console.log('图片加载成功');
			this.isLoading = false;
		}
	},
}
</script>

<style scoped>
.features_item, .room-card {
	height: 100%;
	display: flex;
	flex-direction: column;
	background: #fff;
	border-radius: 15px;
	overflow: hidden;
	margin-bottom: 20px;
	box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
	transition: all 0.3s ease-in-out;
}

.features_item:hover, .room-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.room-info {
	flex: 1;
	display: flex;
	flex-direction: column;
	padding: 20px;
}

.room-info h3 {
	font-size: 1.5em;
	color: #333;
	margin-bottom: 10px;
	font-weight: 600;
}

.rounded-image {
	width: 100%;
	height: 220px;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.features_item:hover .rounded-image, 
.room-card:hover .rounded-image {
	transform: scale(1.05);
}

.service-section {
	padding: 60px 0;
	background: #f8f9fa;
}

.section-title {
	text-align: center;
	font-size: 2.2em;
	color: #2c3e50;
	margin-bottom: 40px;
	position: relative;
}

.section-title::after {
	content: '';
	position: absolute;
	bottom: -10px;
	left: 50%;
	transform: translateX(-50%);
	width: 60px;
	height: 3px;
	background: #7c6aa6;
}

.service-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

.service-item {
	background: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0,0,0,0.06);
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	gap: 15px;
}

.service-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.service-icon {
	flex-shrink: 0;
	width: 50px;
	height: 50px;
	background: #f0f2f5;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.3s ease;
}

.service-item:hover .service-icon {
	background: #7c6aa6;
}

.service-icon i {
	font-size: 24px;
	color: #7c6aa6;
	transition: all 0.3s ease;
}

.service-item:hover .service-icon i {
	color: white;
}

.service-content {
	flex: 1;
}

.service-content h3 {
	font-size: 1.1em;
	color: #2c3e50;
	margin-bottom: 5px;
	font-weight: 600;
}

.service-content p {
	font-size: 0.9em;
	color: #666;
	line-height: 1.4;
	margin: 0;
}

.footer {
	background: #2c3e50;
	color: #fff;
	padding: 50px 0 20px;
	margin-top: 50px;
}

.footer-content {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 30px;
	margin-bottom: 40px;
}

.footer-section {
	text-align: center;
}

.footer-section i {
	font-size: 30px;
	margin-bottom: 15px;
	color: #7c6aa6;
}

.footer-section h3 {
	margin-bottom: 15px;
	font-size: 1.2em;
	color: #fff;
}

.social-icons {
	display: flex;
	justify-content: center;
	gap: 20px;
}

.social-icons i {
	font-size: 24px;
	cursor: pointer;
	transition: transform 0.3s ease;
}

.social-icons i:hover {
	transform: scale(1.2);
}

.footer-bottom {
	text-align: center;
	padding-top: 20px;
	border-top: 1px solid rgba(255,255,255,0.1);
}

.index-page {
	margin-top: -60px;
}

.banner-slide {
	position: relative;
	height: 100vh;
	width: 100%;
	overflow: hidden;
}

.banner-image {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
}

.banner-content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: center;
	color: white;
	z-index: 2;
	width: 80%;
	max-width: 800px;
}

.banner-content h1 {
	font-size: 3.5em;
	margin-bottom: 20px;
	text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
	animation: fadeInDown 1s ease-out;
}

.banner-content p {
	font-size: 1.5em;
	margin-bottom: 30px;
	text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
	animation: fadeInUp 1s ease-out 0.3s;
}

.container {
	width: 100%;
	max-width: 1400px;
	margin: 0 auto;
	padding: 0 20px;
}

.am-g {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	padding: 0;
}

.features_item, .room-card {
	margin: 0;
	height: 100%;
	min-height: 400px;
}

.service-grid {
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 40px;
}

@keyframes fadeInDown {
	from {
		opacity: 0;
		transform: translateY(-30px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

@keyframes fadeInUp {
	from {
		opacity: 0;
		transform: translateY(30px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

@media (max-width: 1200px) {
	.container {
		max-width: 100%;
		padding: 0 30px;
	}
	
	.banner-content h1 {
		font-size: 3em;
	}
	
	.banner-content p {
		font-size: 1.2em;
	}
}

@media (max-width: 768px) {
	.banner-content h1 {
		font-size: 2.5em;
	}
	
	.section {
		padding: 40px 0;
	}
	
	.container {
		padding: 0 15px;
	}
}

.footer {
	margin-top: 0;
	padding: 80px 0 30px;
	background: linear-gradient(to bottom, #2c3e50, #1a252f);
}

.footer-content {
	max-width: 1400px;
	margin: 0 auto;
}

.section--header {
	text-align: center;
	margin-bottom: 60px;
}

.section--title {
	font-size: 2.5em;
	color: #2c3e50;
	position: relative;
	display: inline-block;
	padding-bottom: 15px;
}

.section--title::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 60px;
	height: 3px;
	background: #7c6aa6;
}

.rounded-image {
	height: 280px;
	width: 100%;
	object-fit: cover;
}

.section:nth-child(even) {
	background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.section:nth-child(odd) {
	background: #fff;
}

.hotel-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 30px;
	padding: 20px 0;
}

.hotel-card {
	background: #fff;
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 2px 12px rgba(0,0,0,0.1);
	transition: all 0.3s ease;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.hotel-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.hotel-image {
	width: 100%;
	height: 200px;
	overflow: hidden;
}

.hotel-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.hotel-card:hover .hotel-image img {
	transform: scale(1.05);
}

.hotel-info {
	padding: 20px;
	flex: 1;
	display: flex;
	flex-direction: column;
}

.hotel-name {
	font-size: 1.4em;
	color: #2c3e50;
	margin-bottom: 10px;
	font-weight: 600;
}

.hotel-location {
	display: flex;
	align-items: center;
	color: #7c6aa6;
	margin-bottom: 10px;
}

.hotel-location i {
	margin-right: 8px;
}

.hotel-desc {
	color: #666;
	line-height: 1.6;
	margin: 10px 0;
	flex: 1;
}

.hotel-rating {
	display: flex;
	align-items: center;
	color: #7c6aa6;
	font-weight: 500;
}

.hotel-rating i {
	margin-right: 8px;
}

.section {
	padding: 60px 0;
	background: #f8f9fa;
}

.section:nth-child(even) {
	background: #fff;
}

@media (max-width: 768px) {
	.hotel-grid {
		grid-template-columns: 1fr;
	}
	
	.container {
		padding: 0 15px;
	}
}

@media (min-width: 769px) and (max-width: 1200px) {
	.hotel-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

.rounded-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 0;
}

/* 添加一些过渡效果 */
.el-carousel__item {
	transition: all 0.3s ease;
}

/* 确保轮播图容器有正确的高度 */
.el-carousel, .el-carousel__container {
	height: 100vh !important;
}
</style>
