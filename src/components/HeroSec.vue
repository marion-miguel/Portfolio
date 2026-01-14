<template>
  <section id="home" class="hero-section">
    <div class="hero-content" :style="heroStyle">
      <p class="hero-subtitle" :class="{ visible: isVisible }">
        World-Class Product Engineer & Designer
      </p>

      <h1 class="hero-title" :class="{ visible: isVisible }">
        Forging Digital <br />
        <span class="gradient-text">Elegance.</span>
      </h1>

      <div class="hero-bottom">
        <p class="hero-description" :class="{ visible: isVisible }">
          Bespoke interfaces that blend high-end aesthetics with technical
          precision. Designing experiences that feel like craftsmanship in the
          digital age.
        </p>

        <div class="hero-cta" :class="{ visible: isVisible }">
          <MagneticButton :strength="25">
            <a href="#work" class="cta-button" @click="handleNavClick">
              <div class="cta-background"></div>
              <span class="cta-text">
                View Selected Work
                <span class="arrow">→</span>
              </span>
            </a>
          </MagneticButton>
        </div>
      </div>
    </div>

    <!-- Decorative elements -->
    <div
      class="decorative-circle circle-1"
      :class="{ visible: isVisible }"
    ></div>
    <div
      class="decorative-circle circle-2"
      :class="{ visible: isVisible }"
    ></div>
  </section>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from "vue";
import MagneticButton from "src/components/MagneticButton.vue";

export default {
  name: "HeroSec",
  components: {
    MagneticButton,
  },
  setup() {
    const scrollY = ref(0);
    const isVisible = ref(false);

    const heroStyle = computed(() => {
      const translateY = scrollY.value * 0.3;
      const opacity = 1 - (scrollY.value / 500) * 0.8;
      return {
        transform: `translateY(${translateY}px)`,
        opacity: Math.max(opacity, 0.2),
      };
    });

    const handleScroll = () => {
      scrollY.value = window.scrollY;
    };

    const handleNavClick = (e) => {
      e.preventDefault();
      const element = document.getElementById("work");
      if (element) {
        element.scrollIntoView({ behavior: "smooth" });
      }
    };

    onMounted(() => {
      window.addEventListener("scroll", handleScroll);
      setTimeout(() => {
        isVisible.value = true;
      }, 100);
    });

    onUnmounted(() => {
      window.removeEventListener("scroll", handleScroll);
    });

    return {
      heroStyle,
      isVisible,
      handleNavClick,
    };
  },
};
</script>

<style scoped lang="scss">
.hero-section {
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding: 1.5rem;
  position: relative;
  overflow: hidden;

  @media (min-width: 768px) {
    padding: 3rem;
  }
}

.hero-content {
  max-width: 1600px;
  margin: 0 auto;
  width: 100%;
  z-index: 10;
  transition: transform 0.1s ease-out, opacity 0.1s ease-out;
}

.hero-subtitle {
  color: #2dd4bf;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.3em;
  margin-bottom: 1.5rem;
  font-size: 0.75rem;
  opacity: 0;
  transform: translateY(60px);
  transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
  transition-delay: 0.3s;

  @media (min-width: 768px) {
    font-size: 0.875rem;
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-title {
  font-size: 3.75rem;
  font-family: "Playfair Display", serif;
  font-weight: 900;
  line-height: 0.85;
  letter-spacing: -0.05em;
  margin-bottom: 3rem;
  opacity: 0;
  transform: translateY(60px);
  transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
  transition-delay: 0.45s;

  @media (min-width: 768px) {
    font-size: 10rem;
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.gradient-text {
  font-style: italic;
  background: linear-gradient(to right, #2dd4bf, #38bdf8);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-bottom {
  display: flex;
  flex-direction: column;
  gap: 3rem;

  @media (min-width: 768px) {
    flex-direction: row;
    align-items: flex-end;
    justify-content: space-between;
  }
}

.hero-description {
  font-size: 1.125rem;
  max-width: 36rem;
  line-height: 1.6;
  opacity: 0;
  transform: translateY(60px);
  transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
  transition-delay: 0.6s;

  .dark-mode & {
    color: rgba(250, 250, 250, 0.6);
  }

  @media (min-width: 768px) {
    font-size: 1.5rem;
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-cta {
  opacity: 0;
  transform: translateY(60px);
  transition: all 0.8s cubic-bezier(0.23, 1, 0.32, 1);
  transition-delay: 0.75s;

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.cta-button {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem 2.5rem;
  font-size: 1.125rem;
  font-weight: 700;
  overflow: hidden;
  border-radius: 9999px;
  border: 1px solid;
  text-decoration: none;
  color: inherit;
  cursor: none;
  transition: all 0.3s;

  .dark-mode & {
    border-color: #fafafa;
  }
}

.cta-background {
  position: absolute;
  inset: 0;
  background-color: #2dd4bf;
  transform: translateY(101%);
  transition: transform 0.5s ease-out;

  .cta-button:hover & {
    transform: translateY(0);
  }
}

.cta-text {
  position: relative;
  z-index: 10;
  display: flex;
  align-items: center;

  .cta-button:hover & {
    color: #15263b;
  }

  .arrow {
    margin-left: 0.75rem;
    transition: transform 0.3s;

    .cta-button:hover & {
      transform: translateX(4px);
    }
  }
}

.decorative-circle {
  position: absolute;
  border-radius: 50%;
  border: 1px solid;
  pointer-events: none;
  display: none;
  opacity: 0;
  transform: scale(0.8);
  transition: all 1.5s ease-out;

  @media (min-width: 1024px) {
    display: block;
  }

  &.visible {
    opacity: 1;
    transform: scale(1);
  }

  &.circle-1 {
    right: -5rem;
    top: 50%;
    transform: translateY(-50%) scale(0.8);
    width: 600px;
    height: 600px;
    border-color: rgba(21, 38, 59, 0.05);

    .dark-mode & {
      border-color: rgba(250, 250, 250, 0.05);
    }

    &.visible {
      transform: translateY(-50%) scale(1);
    }
  }

  &.circle-2 {
    right: -2.5rem;
    top: 50%;
    transform: translateY(-50%) scale(0.8);
    width: 400px;
    height: 400px;
    border-color: rgba(45, 212, 191, 0.1);
    transition-duration: 2s;

    &.visible {
      transform: translateY(-50%) scale(1.1);
      opacity: 0.5;
    }
  }
}
</style>
