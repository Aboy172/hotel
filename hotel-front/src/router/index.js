import Vue from 'vue'
import VueRouter from 'vue-router'
import Room from '@/views/front/room/Room.vue'

Vue.use(VueRouter)

const routes = [
    {
        path:'/',
        redirect:'/index'
    },
    {
       path:'/login',
       name:'login',
        component: () => import('../views/Auth.vue')
    },
    {
        path: '/index',
        name: 'index',
        component: () => import('../views/IndexView.vue')
    },
    {
        path: '/room',
        name: 'room',
        component: () => import('@/views/front/room/Room.vue')
    },
    {
        path: '/room/roomId/:roomId',
        name: 'roomDetail',
        component: () => import('@/views/front/roomdetail/RoomDetail.vue')
    },

    {
        path: '/news',
        name: 'news',
        component: () => import('../views/front/news/News.vue')
    },
    {
        path: '/news/newsId/:newsId',
        name: 'newsDetails',
        component: () => import('../views/NewsDetailsView.vue')
    },
    {
        path: '/order',
        name: 'order',
        component: () => import('../views/front/order/Order.vue')
    },
    {
        path: '/about',
        name: 'about',
        component: () => import('../views/front/complaint/Complaint.vue')
    },
    {
        path: '/profile',
        name: 'Profile',
        component: () => import('../views/front/profile/Profile.vue')
    }
]

const router = new VueRouter({
    routes
})

export default router
