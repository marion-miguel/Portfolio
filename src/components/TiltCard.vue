<template>
  <div
    ref="cardRef"
    class="tilt-card"
    :style="cardStyle"
    @mousemove="handleMouseMove"
    @mouseleave="handleMouseLeave"
    @click="$emit('click')"
  >
    <img :src="project.images[0]" :alt="project.title" class="card-image" />
    <div class="card-overlay"></div>

    <div class="card-tags">
      <span v-for="tag in project.tags.slice(0, 2)" :key="tag" class="tag">
        {{ tag }}
      </span>
    </div>

    <div class="card-content">
      <p class="card-category">{{ project.category }}</p>
      <h3 class="card-title">{{ project.title }}</h3>
      <p class="card-description">{{ project.description }}</p>

      <div class="card-cta">
        <span class="cta-text">Explore Case Study</span>
        <span class="cta-arrow">→</span>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed } from "vue";

export default {
  name: "TiltCard",
  props: {
    project: {
      type: Object,
      required: true,
    },
  },
  emits: ["click"],
  setup() {
    const cardRef = ref(null);
    const rotateX = ref(0);
    const rotateY = ref(0);
    const currentX = ref(0);
    const currentY = ref(0);

    const cardStyle = computed(() => ({
      transform: `perspective(1000px) rotateX(${currentX.value}deg) rotateY(${currentY.value}deg)`,
    }));

    let animationFrame = null;

    const animate = () => {
      const speed = 0.1;
      currentX.value += (rotateX.value - currentX.value) * speed;
      currentY.value += (rotateY.value - currentY.value) * speed;

      if (
        Math.abs(rotateX.value - currentX.value) > 0.1 ||
        Math.abs(rotateY.value - currentY.value) > 0.1
      ) {
        animationFrame = requestAnimationFrame(animate);
      }
    };

    const handleMouseMove = (event) => {
      if (!cardRef.value) return;

      const rect = cardRef.value.getBoundingClientRect();
      const mouseX = event.clientX - rect.left;
      const mouseY = event.clientY - rect.top;

      const xPercent = mouseX / rect.width;
      const yPercent = mouseY / rect.height;

      rotateY.value = (xPercent - 0.5) * 20;
      rotateX.value = (yPercent - 0.5) * -20;

      if (!animationFrame) {
        animate();
      }
    };

    const handleMouseLeave = () => {
      rotateX.value = 0;
      rotateY.value = 0;

      if (!animationFrame) {
        animate();
      }
    };

    return {
      cardRef,
      cardStyle,
      handleMouseMove,
      handleMouseLeave,
    };
  },
};
</script>

<style scoped lang="scss">
.tilt-card {
  position: relative;
  height: 450px;
  border-radius: 1.5rem;
  overflow: hidden;
  cursor: none;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  transition: box-shadow 0.3s, transform 0.1s ease-out;
  transform-style: preserve-3d;

  &:hover {
    box-shadow: 0 35px 60px -15px rgba(0, 0, 0, 0.35);

    .card-image {
      transform: scale(1.1);
    }

    .card-overlay {
      opacity: 0.9;
    }

    .tag {
      opacity: 1;
      transform: translateY(0);
    }

    .card-category,
    .card-description,
    .card-cta {
      opacity: 1;
      transform: translateY(0);
    }

    .card-title {
      transform: translateY(-4px);
    }
  }
}

.card-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 1s;
}

.card-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to top,
    rgba(21, 38, 59, 0.95),
    rgba(21, 38, 59, 0.2),
    transparent
  );
  opacity: 0.7;
  transition: opacity 0.5s;
}

.card-tags {
  position: absolute;
  top: 1.5rem;
  left: 1.5rem;
  display: flex;
  flex-wrap: wrap;
  gap: 0.375rem;
  pointer-events: none;
  transform: translateZ(50px);
}

.tag {
  font-size: 0.5rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  padding: 0.25rem 0.5rem;
  background-color: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 9999px;
  color: white;
  opacity: 0;
  transform: translateY(-10px);
  transition: all 0.3s;
}

.card-content {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 2rem;
  color: white;
  transform: translateZ(40px);
}

.card-category {
  font-size: 0.625rem;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  font-weight: 700;
  color: #2dd4bf;
  margin-bottom: 0.5rem;
  opacity: 0;
  transform: translateY(16px);
  transition: all 0.5s;
}

.card-title {
  font-size: 1.5rem;
  font-family: "Playfair Display", serif;
  font-weight: 700;
  margin-bottom: 0.75rem;
  transition: transform 0.5s;
}

.card-description {
  font-size: 0.75rem;
  color: rgba(250, 250, 250, 0.7);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  margin-bottom: 1rem;
  opacity: 0;
  transform: translateY(16px);
  transition: all 0.5s;
}

.card-cta {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.625rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  color: #2dd4bf;
  opacity: 0;
  transform: translateY(16px);
  transition: all 0.5s, color 0.3s;

  &:hover {
    color: white;
  }
}

.cta-arrow {
  transition: transform 0.3s;

  .card-cta:hover & {
    transform: translateX(4px);
  }
}
</style>
