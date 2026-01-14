<template>
  <div
    ref="buttonRef"
    class="magnetic-button"
    :style="buttonStyle"
    @mousemove="handleMouseMove"
    @mouseleave="handleMouseLeave"
    @click="handleClick"
  >
    <slot></slot>
  </div>
</template>

<script>
import { ref, computed } from "vue";

export default {
  name: "MagneticButton",
  props: {
    strength: {
      type: Number,
      default: 30,
    },
  },
  emits: ["click"],
  setup(props, { emit }) {
    const buttonRef = ref(null);
    const positionX = ref(0);
    const positionY = ref(0);
    const currentX = ref(0);
    const currentY = ref(0);

    const buttonStyle = computed(() => ({
      transform: `translate(${currentX.value}px, ${currentY.value}px)`,
    }));

    let animationFrame = null;

    const animate = () => {
      const speed = 0.15;
      currentX.value += (positionX.value - currentX.value) * speed;
      currentY.value += (positionY.value - currentY.value) * speed;

      if (
        Math.abs(positionX.value - currentX.value) > 0.1 ||
        Math.abs(positionY.value - currentY.value) > 0.1
      ) {
        animationFrame = requestAnimationFrame(animate);
      }
    };

    const handleMouseMove = (e) => {
      if (!buttonRef.value) return;

      const rect = buttonRef.value.getBoundingClientRect();
      const centerX = rect.left + rect.width / 2;
      const centerY = rect.top + rect.height / 2;

      const x = (e.clientX - centerX) / props.strength;
      const y = (e.clientY - centerY) / props.strength;

      positionX.value = x * props.strength;
      positionY.value = y * props.strength;

      if (!animationFrame) {
        animate();
      }
    };

    const handleMouseLeave = () => {
      positionX.value = 0;
      positionY.value = 0;

      if (!animationFrame) {
        animate();
      }
    };

    const handleClick = (e) => {
      emit("click", e);
    };

    return {
      buttonRef,
      buttonStyle,
      handleMouseMove,
      handleMouseLeave,
      handleClick,
    };
  },
};
</script>

<style scoped lang="scss">
.magnetic-button {
  display: inline-block;
  transition: transform 0.15s cubic-bezier(0.23, 1, 0.32, 1);
}
</style>
