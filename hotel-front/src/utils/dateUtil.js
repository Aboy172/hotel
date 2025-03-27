/**
 * 日期格式化工具
 * @param {string|Date} date 日期对象或日期字符串
 * @param {string} format 格式化模式，如 'YYYY-MM-DD HH:mm:ss'
 * @returns {string} 格式化后的日期字符串
 */
export function formatDate(date, format = 'YYYY-MM-DD') {
  if (!date) return '';
  
  // 如果是字符串，转换为Date对象
  if (typeof date === 'string') {
    // 处理可能的时间戳字符串
    if (!isNaN(Number(date))) {
      date = new Date(Number(date));
    } else {
      date = new Date(date.replace(/-/g, '/'));
    }
  }
  
  if (!(date instanceof Date) || isNaN(date.getTime())) {
    return '';
  }
  
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  const seconds = String(date.getSeconds()).padStart(2, '0');
  
  return format
    .replace('YYYY', year)
    .replace('MM', month)
    .replace('DD', day)
    .replace('HH', hours)
    .replace('mm', minutes)
    .replace('ss', seconds);
}

/**
 * 获取相对时间描述
 * @param {string|Date} date 日期对象或日期字符串
 * @returns {string} 相对时间描述，如"刚刚"、"5分钟前"等
 */
export function getRelativeTime(date) {
  if (!date) return '';
  
  // 如果是字符串，转换为Date对象
  if (typeof date === 'string') {
    date = new Date(date.replace(/-/g, '/'));
  }
  
  if (!(date instanceof Date) || isNaN(date.getTime())) {
    return '';
  }
  
  const now = new Date();
  const diff = now.getTime() - date.getTime();
  
  // 小于1分钟
  if (diff < 60 * 1000) {
    return '刚刚';
  }
  
  // 小于1小时
  if (diff < 60 * 60 * 1000) {
    return `${Math.floor(diff / (60 * 1000))}分钟前`;
  }
  
  // 小于1天
  if (diff < 24 * 60 * 60 * 1000) {
    return `${Math.floor(diff / (60 * 60 * 1000))}小时前`;
  }
  
  // 小于30天
  if (diff < 30 * 24 * 60 * 60 * 1000) {
    return `${Math.floor(diff / (24 * 60 * 60 * 1000))}天前`;
  }
  
  // 大于30天，返回格式化日期
  return formatDate(date, 'YYYY-MM-DD');
} 