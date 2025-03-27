<template>
	<div class="layout">
		<Header/>
		<main class="main-content">
			<slot></slot>
		</main>
		<FrontFooter/>
	</div>
</template>

<script>
import Header from "@/components/common/header/Header";
import FrontFooter from "@/components/common/front/Footer.vue";
import CommentList from "@/components/CommentList.vue";

export default {
	name: "Layout",
	components: {
		Header,
		FrontFooter,
		CommentList
	}
}
</script>

<style scoped>
.layout {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.main-content {
	flex: 1;
}

.main-content{
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}


</style>
