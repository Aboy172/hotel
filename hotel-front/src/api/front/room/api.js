import request from '@/utils/request'

// 房间相关接口
export const roomApi = {
  // 获取房间列表
  getRoomList(params) {
    return request({
      url: '/user/room/list',
      method: 'get',
      params
    })
  },
  
  // 获取房间详情
  getRoomDetail(roomId) {
    return request({
      url: `/user/room/getRoomDetails/${roomId}`,
      method: 'get'
    })
  },
  
  // 获取房型列表
  getRoomTypeList() {
    return request({
      url: '/user/room/type/list',
      method: 'get'
    })
  },
  
  // 预订房间
  bookRoom(data) {
    return request({
      url: '/user/order/create',
      method: 'post',
      data
    })
  },
  
  // 获取相似房间
  getSimilarRooms(roomTypeId, excludeRoomId) {
    return request({
      url: '/user/room/similar',
      method: 'get',
      params: {
        roomTypeId,
        excludeRoomId
      }
    })
  },
  
  // 添加收藏
  addToFavorite(roomId) {
    return request({
      url: '/user/favorite/add',
      method: 'post',
      data: {
        roomId
      }
    })
  },
  
  // 获取房间评价
  getRoomReviews(roomId) {
    return request({
      url: `/user/room/reviews/${roomId}`,
      method: 'get'
    })
  },

  // 搜索房间
  searchRooms(params) {
    return request({
      url: '/user/room/query',
      method: 'get',
      params
    })
  },

  // 获取酒店优势列表
  getAdvantageList() {
    return request({
      url: '/user/hotels/findAdvantageList',
      method: 'get'
    })
  }
} 