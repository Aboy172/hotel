<template>
	<Layout>
		<div class="carousel-container">
			<el-carousel :height="carouselHeight" :interval="5000" arrow="always">
				<el-carousel-item v-for="item in slideshow" :key="item.id">
					<img :src="item.url" :alt="item.name" class="carousel-image"/>
					<div class="carousel-overlay"></div>
					<div class="carousel-content">
						<h2>{{item.name}}</h2>
						<p>尊享奢华住宿体验，给您家一般的温暖</p>
						<el-button type="primary" class="book-btn" @click="goToRooms">立即预订</el-button>
					</div>
				</el-carousel-item>
			</el-carousel>
		</div>

		<FeaturedRooms />
		<HotelServices />

	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
import FeaturedRooms from '@/views/front/home/FeaturedRooms.vue';
import HotelServices from '@/views/front/home/HotelServices.vue';
export default {
	name: "IndexView",
	components: {Layout, FeaturedRooms, HotelServices},
	computed: {
		// sortedSlideshow() {
		// 	return this.slideshow.sort((a, b) => a.sort - b.sort);
		// }
	},
	data(){
		return{
			tabIndex: 0,
			slideshow: [],
			advantageList:[
			],
			isLoading: true
		}
	},
	mounted() {
		this.updateCarouselHeight();
		window.addEventListener('resize', this.updateCarouselHeight);

		Promise.all([
			this.getCarouselList(),
			this.getAdvantageList()
		]).catch(error => {
			console.error('数据加载失败:', error);
		});
	},
	beforeDestroy() {
		window.removeEventListener('resize', this.updateCarouselHeight);
	},
	methods:{
		updateCarouselHeight() {
			this.carouselHeight = window.innerHeight + 'px';
		},
		getAdvantageList(){
			this.getRequest("/user/hotels/findAdvantageList").then(resp=>{
				if (resp){
					this.advantageList = resp.data.data;
					console.log(this.advantageList)
				}
			})
		},
		getCarouselList(){
			this.getRequest("/carousel/list").then(resp => {
				if (resp && resp.data.code === 0) {
					this.slideshow = resp.data.data;
					console.log('轮播图数据:', this.slideshow);
				} else {
					console.error('轮播图数据加载失败:', resp);
				}
			}).catch(error => {
				console.error('请求失败:', error);
			});
		},
		handleImageError(e) {
			console.error('图片加载失败:', e);
			e.target.src = 'path/to/default/image.jpg';
		},
		handleImageLoad() {
			console.log('图片加载成功');
			this.isLoading = false;
		},
		goToRooms() {
			this.$router.push('/room');
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

.carousel-container {
	position: relative;
	width: 100%;
	height: 100vh;
	overflow: hidden;
}

.carousel-item {
	position: relative;
	width: 100%;
	height: 100%;
}

.carousel-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.carousel-overlay {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: linear-gradient(
		to bottom,
		rgba(0, 0, 0, 0.2),
		rgba(0, 0, 0, 0.5)
	);
}

.carousel-content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: center;
	color: white;
	width: 80%;
	max-width: 800px;
	z-index: 2;
}

.carousel-content h2 {
	font-size: 3.5em;
	font-weight: 600;
	margin-bottom: 20px;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
	animation: fadeInDown 1s ease-out;
}

.carousel-content p {
	font-size: 1.8em;
	margin-bottom: 30px;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
	animation: fadeInUp 1s ease-out 0.3s;
}

.book-btn {
	padding: 15px 40px;
	font-size: 1.2em;
	border-radius: 30px;
	background: #7c6aa6;
	border: none;
	transition: all 0.3s ease;
	animation: fadeIn 1s ease-out 0.6s;
}

.book-btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	background: #9b89c9;
}

.el-carousel__arrow {
	width: 50px;
	height: 50px;
	background: rgba(0, 0, 0, 0.3);
	border-radius: 50%;
	transition: all 0.3s ease;
}

.el-carousel__arrow:hover {
	background: rgba(0, 0, 0, 0.6);
}

.el-carousel__indicators {
	z-index: 10;
}

.el-carousel__button {
	width: 12px;
	height: 12px;
	border-radius: 50%;
	background: rgba(255, 255, 255, 0.7);
	transition: all 0.3s ease;
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

@keyframes fadeIn {
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}

@media (max-width: 768px) {
	.carousel-content h2 {
		font-size: 2.5em;
	}

	.carousel-content p {
		font-size: 1.2em;
	}

	.book-btn {
		padding: 12px 30px;
		font-size: 1em;
	}
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

@media (max-width: 1200px) {
	.container {
		max-width: 100%;
		padding: 0 30px;
	}

	.carousel-content h1 {
		font-size: 3em;
	}

	.carousel-content p {
		font-size: 1.2em;
	}
}

@media (max-width: 768px) {
	.carousel-content h1 {
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

.features_item {
	border-radius: 15px;
	overflow: hidden;
	margin-bottom: 20px;
	box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
	transition: all 0.3s;
	text-align: center;
	padding: 30px 20px;
	background: #fff;
}

.features_item:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.features_item i {
	font-size: 40px;
	color: #7c6aa6;
	margin-bottom: 20px;
}

.features_item--title {
	font-size: 1.2em;
	color: #2c3e50;
	margin-bottom: 15px;
}

.features_item--text {
	color: #666;
	line-height: 1.6;
}

.banner-section {
	margin-top: -60px;
}

.carousel-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.section {
	padding: 40px 0;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

.section-title {
	text-align: center;
	font-size: 28px;
	margin-bottom: 30px;
	color: #333;
}

/* 酒店列表样式 */
.hotel-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.hotel-item {
	flex: 1;
	min-width: 300px;
	max-width: calc(33.333% - 14px);
	background: #fff;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.hotel-image {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.hotel-content {
	padding: 15px;
}

/* 房型列表样式 */
.room-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 30px;
	padding: 20px;
}

.room-item {
	background: white;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.room-image {
	width: 100%;
	height: 250px;
	object-fit: cover;
}

.room-info {
	padding: 20px;
}

.room-price {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 15px;
}

.price {
	color: #f56c6c;
	font-size: 24px;
	font-weight: bold;
}

/* 响应式调整 */
@media (max-width: 768px) {
	.hotel-item {
		max-width: 100%;
	}

	.room-grid {
		grid-template-columns: 1fr;
	}

	.room-item {
		flex: 0 0 100%;
	}
}
</style>

