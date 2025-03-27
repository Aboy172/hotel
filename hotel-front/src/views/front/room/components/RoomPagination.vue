<template>
  <div class="pagination-container">
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-sizes="[12, 24, 36, 48]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
    />
  </div>
</template>

<script>
export default {
  props: {
    currentPage: Number,
    pageSize: Number,
    total: Number
  },
  
  emits: ['update:currentPage', 'update:pageSize', 'pagination-change'],
  
  methods: {
    handleSizeChange(val) {
      this.$emit('update:pageSize', val)
      this.$emit('pagination-change', {
        currentPage: this.currentPage,
        pageSize: val
      })
    },
    
    handleCurrentChange(val) {
      this.$emit('update:currentPage', val)
      this.$emit('pagination-change', {
        currentPage: val,
        pageSize: this.pageSize
      })
    }
  }
}
</script>

<style scoped>
/* 保持原有样式 */
</style> 