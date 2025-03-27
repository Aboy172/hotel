<template>
  <div class="am-comment-list">
    <div class="am-comment" v-for="comment in comments" :key="comment.id">
      <img :src="comment.avatar" alt="用户头像" class="am-comment-avatar" height="48" />
      <div class="am-comment-main">
        <header class="am-comment-hd">
          <div class="am-comment-meta">
            <a href="#" class="am-comment-author">{{ comment.author }}</a>
<!--            评论于 <time datetime="{{ comment.timestamp }}">{{ comment.time }}</time>-->
          </div>
        </header>
        <div class="am-comment-bd">
          <p>{{ comment.content }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "CommentList",
  data(){
    return {
      comments: [
        {
          id: 1,
          author: '游客 A',
          avatar: '/avatar1.jpg',
          timestamp: '2024-10-25',
          time: '10月25日',
          content: '房间很舒适，海景超棒！'
        },
        {
          id: 2,
          author: '游客 B',
          avatar: '/avatar2.jpg',
          timestamp: '2024-10-26',
          time: '10月26日',
          content: '家人都很喜欢这个海景房，非常推荐！'
        },
        {
          id: 3,
          author: '游客 C',
          avatar: '/avatar3.jpg',
          timestamp: '2024-10-27',
          time: '10月27日',
          content: '服务很周到，下次还会再来。'
        }
      ]
    };
  }
}
</script>
<style scoped>
.am-comment-avatar {
  border-radius: 50%;
  width: 48px;
}
.am-comment-author {
  font-weight: bold;
}
</style>
