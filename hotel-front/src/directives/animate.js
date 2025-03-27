// 创建自定义动画指令
export default {
  bind(el, binding) {
    // 默认动画
    const animation = binding.value || 'fadeIn';
    // 延迟时间
    const delay = el.dataset.animateDelay || 0;
    // 持续时间
    const duration = el.dataset.animateDuration || '0.8s';
    
    // 设置初始状态
    el.style.opacity = '0';
    
    // 添加动画类
    setTimeout(() => {
      el.style.animation = `${animation} ${duration} forwards`;
      el.style.opacity = '1';
    }, delay);
  }
}; 