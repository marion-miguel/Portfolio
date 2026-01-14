<template>
  <div
    ref="cursorRef"
    class="custom-cursor"
    :style="cursorStyle"
    :class="{ 'is-hovering': isHovering, 'is-clicking': isClicking }"
  >
    <div class="cursor-dot"></div>
  </div>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from "vue";

export default {
  name: "CustomCursor",
  setup() {
    const cursorRef = ref(null);
    const mouseX = ref(0);
    const mouseY = ref(0);
    const currentX = ref(0);
    const currentY = ref(0);
    const isHovering = ref(false);
    const isClicking = ref(false);

    const cursorStyle = computed(() => ({
      transform: `translate(${currentX.value}px, ${
        currentY.value
      }px) translate(-50%, -50%) scale(${
        isClicking.value ? 0.8 : isHovering.value ? 2 : 1
      })`,
      backgroundColor: isHovering.value
        ? "rgba(45, 212, 191, 0.4)"
        : "transparent",
    }));

    let animationFrame = null;

    const animateCursor = () => {
      const speed = 0.15;
      currentX.value += (mouseX.value - currentX.value) * speed;
      currentY.value += (mouseY.value - currentY.value) * speed;
      animationFrame = requestAnimationFrame(animateCursor);
    };

    const handleMouseMove = (e) => {
      mouseX.value = e.clientX;
      mouseY.value = e.clientY;

      const target = e.target;
      isHovering.value = !!(
        target.closest("button") ||
        target.closest("a") ||
        target.closest(".interactive") ||
        target.closest('[role="button"]')
      );
    };

    const handleMouseDown = () => {
      isClicking.value = true;
    };

    const handleMouseUp = () => {
      isClicking.value = false;
    };

    onMounted(() => {
      window.addEventListener("mousemove", handleMouseMove);
      window.addEventListener("mousedown", handleMouseDown);
      window.addEventListener("mouseup", handleMouseUp);
      animateCursor();
    });

    onUnmounted(() => {
      window.removeEventListener("mousemove", handleMouseMove);
      window.removeEventListener("mousedown", handleMouseDown);
      window.removeEventListener("mouseup", handleMouseUp);
      if (animationFrame) {
        cancelAnimationFrame(animationFrame);
      }
    });

    return {
      cursorRef,
      cursorStyle,
      isHovering,
      isClicking,
    };
  },
};
</script>

<style scoped lang="scss">
.custom-cursor {
  position: fixed;
  top: 0;
  left: 0;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  border: 1px solid #2dd4bf;
  pointer-events: none;
  z-index: 10000;
  mix-blend-mode: difference;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.15s ease-out, background-color 0.15s ease-out;

  .cursor-dot {
    width: 4px;
    height: 4px;
    background-color: #2dd4bf;
    border-radius: 50%;
  }
}
</style>
