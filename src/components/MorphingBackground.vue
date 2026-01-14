<template>
  <div class="morphing-background">
    <transition name="fade" mode="out-in">
      <svg
        :key="activeAccent + '-1'"
        viewBox="0 0 1000 1000"
        xmlns="http://www.w3.org/2000/svg"
        class="blob blob-1"
        :style="{ fill: activeAccent || '#2DD4BF' }"
      >
        <path
          d="M784,657.5Q688,815,500,808Q312,801,234,650.5Q156,500,230,344.5Q304,189,500,192.5Q696,196,788,348Q880,500,784,657.5Z"
        >
          <animateTransform
            attributeName="transform"
            type="rotate"
            from="0 500 500"
            to="360 500 500"
            dur="30s"
            repeatCount="indefinite"
          />
        </path>
      </svg>
    </transition>

    <transition name="fade" mode="out-in">
      <svg
        :key="activeAccent + '-2'"
        viewBox="0 0 1000 1000"
        xmlns="http://www.w3.org/2000/svg"
        class="blob blob-2"
        :style="{ fill: activeAccent ? activeAccent + '88' : '#38BDF8' }"
      >
        <path
          d="M741.5,659.5Q633,819,451,791.5Q269,764,213,632Q157,500,227,379.5Q297,259,471,231Q645,203,697.5,351.5Q750,500,741.5,659.5Z"
        >
          <animateTransform
            attributeName="transform"
            type="rotate"
            from="360 500 500"
            to="0 500 500"
            dur="40s"
            repeatCount="indefinite"
          />
        </path>
      </svg>
    </transition>
  </div>
</template>

<script>
export default {
  name: "MorphingBackground",
  props: {
    activeAccent: {
      type: String,
      default: "#2DD4BF",
    },
  },
};
</script>

<style scoped lang="scss">
.morphing-background {
  position: fixed;
  inset: 0;
  z-index: -10;
  overflow: hidden;
  opacity: 0.3;
  transition: opacity 1s;

  .dark-mode & {
    opacity: 0.2;
  }
}

.blob {
  position: absolute;
  filter: blur(100px);

  &.blob-1 {
    top: -20%;
    left: -10%;
    width: 120%;
    height: 120%;
  }

  &.blob-2 {
    bottom: -20%;
    right: -10%;
    width: 120%;
    height: 120%;
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 1s;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
