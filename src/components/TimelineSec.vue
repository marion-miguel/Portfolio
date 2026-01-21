<template>
  <section id="journey" ref="sectionRef" class="timeline-section">
    <div class="timeline-container">
      <!-- Header -->
      <div class="timeline-header">
        <h4 class="section-subtitle" :class="{ visible: headerVisible }">
          Evolution
        </h4>
        <h2 class="section-title" :class="{ visible: headerVisible }">
          The Journey.
        </h2>

        <div class="tab-switcher" :class="{ visible: headerVisible }">
          <button
            v-for="tab in ['Work', 'Education']"
            :key="tab"
            :class="['tab-button', { active: activeTab === tab }]"
            @click="activeTab = tab"
          >
            <div v-if="activeTab === tab" class="tab-indicator"></div>
            {{ tab }}
          </button>
        </div>
      </div>

      <!-- Timeline Content -->
      <div class="timeline-content">
        <!-- Background Line -->
        <div class="timeline-line-bg"></div>

        <!-- Progress Line -->
        <div
          class="timeline-line-progress"
          :style="{ transform: `scaleY(${scrollProgress})` }"
        >
          <div class="progress-head"></div>
        </div>

        <!-- Timeline Items -->
        <transition-group name="timeline">
          <div
            v-for="(item, idx) in filteredItems"
            :key="item.id"
            class="timeline-item"
            :class="{ even: idx % 2 === 0, visible: visibleItems[idx] }"
          >
            <div
              :class="[
                'item-content',
                { right: idx % 2 === 0, left: idx % 2 !== 0 },
              ]"
            >
              <div class="content-card">
                <span class="item-period">{{ item.period }}</span>
                <h3 class="item-title">{{ item.title }}</h3>
                <p class="item-organization">{{ item.organization }}</p>
                <p class="item-description">{{ item.description }}</p>
              </div>
            </div>

            <!-- Marker -->
            <div
              class="item-marker desktop-marker"
              :class="{ visible: visibleItems[idx] }"
            >
              <div class="marker-dot"></div>
            </div>
            <div class="item-marker mobile-marker">
              <div class="marker-dot"></div>
            </div>
          </div>
        </transition-group>
      </div>
    </div>

    <!-- Decorative Blobs -->
    <div class="decorative-blob blob-right"></div>
    <div class="decorative-blob blob-left"></div>
  </section>
</template>

<script>
import { ref, computed, onMounted, onUnmounted, watch } from "vue";
import portfolioData from "src/data/portfolio-data.json";

export default {
  name: "TimelineSec",
  setup() {
    const sectionRef = ref(null);
    const activeTab = ref("Work");
    const headerVisible = ref(false);
    const visibleItems = ref({});
    const scrollProgress = ref(0);

    const filteredItems = computed(() => {
      if (activeTab.value === "Work") {
        return portfolioData.ResumeSection.experience.map((item, index) => ({
          ...item,
          id: `work-${index}`,
          type: "Work",
          title: item.position,
          organization: item.company,
          period: item.year,
        }));
      } else {
        return portfolioData.ResumeSection.education.map((item, index) => ({
          ...item,
          id: `edu-${index}`,
          type: "Education",
          title: item.degree,
          organization: item.institution,
          period: item.year,
        }));
      }
    });

    const handleScroll = () => {
      if (!sectionRef.value) return;

      const rect = sectionRef.value.getBoundingClientRect();
      const windowHeight = window.innerHeight;

      // Check if section is in view (with some buffer for smoother transitions)
      const isInView =
        rect.top < windowHeight * 0.8 && rect.bottom > windowHeight * 0.2;

      if (isInView) {
        headerVisible.value = true;
      } else {
        // Reset animations when out of view
        headerVisible.value = false;
        visibleItems.value = {};
        scrollProgress.value = 0;
        return;
      }

      // Calculate scroll progress within the section
      const sectionTop = rect.top;
      const sectionHeight = rect.height;
      const viewportMiddle = windowHeight * 0.8;

      if (sectionTop < viewportMiddle && sectionTop + sectionHeight > 0) {
        const progress = Math.max(
          0,
          Math.min(1, (viewportMiddle - sectionTop) / (sectionHeight * 0.8))
        );
        scrollProgress.value = progress;

        // Show items progressively
        filteredItems.value.forEach((_, idx) => {
          if (progress > idx / filteredItems.value.length) {
            visibleItems.value[idx] = true;
          }
        });
      }
    };

    onMounted(() => {
      window.addEventListener("scroll", handleScroll);
      handleScroll();
    });

    onUnmounted(() => {
      window.removeEventListener("scroll", handleScroll);
    });

    // Reset timeline animations when tab changes
    watch(activeTab, () => {
      visibleItems.value = {};
      scrollProgress.value = 0;
      // Retrigger scroll check to animate new timeline items
      setTimeout(() => {
        handleScroll();
      }, 50);
    });

    return {
      sectionRef,
      activeTab,
      headerVisible,
      filteredItems,
      visibleItems,
      scrollProgress,
    };
  },
};
</script>

<style scoped lang="scss">
.timeline-section {
  padding: 8rem 1.5rem;
  position: relative;
  overflow: hidden;
  background-color: #fafafa;

  .dark-mode & {
    background-color: #15263b;
  }

  @media (min-width: 768px) {
    padding: 8rem 3rem;
  }
}

.timeline-container {
  max-width: 1600px;
  margin: 0 auto;
}

.timeline-header {
  text-align: center;
  margin-bottom: 6rem;
}

.section-subtitle {
  color: #2dd4bf;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  margin-bottom: 1rem;
  font-size: 0.875rem;
  opacity: 0;
  transform: translateY(10px);
  transition: all 0.6s ease-out;

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.section-title {
  font-size: 3rem;
  font-family: "Playfair Display", serif;
  font-weight: 900;
  font-style: italic;
  margin-bottom: 3rem;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease-out;
  transition-delay: 0.1s;

  @media (min-width: 768px) {
    font-size: 6rem;
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.tab-switcher {
  display: inline-flex;
  padding: 0.375rem;
  background-color: rgba(0, 0, 0, 0.05);
  border-radius: 9999px;
  border: 1px solid rgba(21, 38, 59, 0.05);
  backdrop-filter: blur(12px);
  position: relative;
  z-index: 30;
  opacity: 0;
  transform: translateY(10px);
  transition: all 0.6s ease-out;
  transition-delay: 0.2s;

  .dark-mode & {
    background-color: rgba(25, 32, 44, 1);
    border-color: rgba(250, 250, 250, 0.05);
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.tab-button {
  position: relative;
  padding: 0.75rem 2.5rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  z-index: 10;
  background: transparent;
  border: none;
  cursor: none;
  transition: color 0.5s;

  &.active {
    color: white;
  }

  &:not(.active) {
    color: rgba(21, 38, 59, 0.4);

    .dark-mode & {
      color: rgba(250, 250, 250, 0.4);
    }

    &:hover {
      color: rgba(21, 38, 59, 0.7);

      .dark-mode & {
        color: rgba(250, 250, 250, 0.7);
      }
    }
  }
}

.tab-indicator {
  position: absolute;
  inset: 0;
  background-color: #2dd4bf;
  border-radius: 9999px;
  z-index: -1;
  box-shadow: 0 10px 25px -5px rgba(45, 212, 191, 0.4);
  animation: tabSlide 0.6s cubic-bezier(0.16, 1, 0.3, 1);
}

.timeline-content {
  position: relative;
  min-height: 600px;
}

.timeline-line-bg,
.timeline-line-progress {
  position: absolute;
  left: 1rem;
  top: 0;
  bottom: 0;
  width: 2px;

  @media (min-width: 768px) {
    left: 50%;
    transform: translateX(-50%);
  }
}

.timeline-line-bg {
  background-color: rgba(21, 38, 59, 0.05);

  .dark-mode & {
    background-color: rgba(250, 250, 250, 0.05);
  }
}

.timeline-line-progress {
  background: linear-gradient(to bottom, #2dd4bf, #38bdf8, #2dd4bf);
  z-index: 10;
  transform-origin: top;
  transition: transform 0.1s ease-out;
}

.progress-head {
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background-color: #2dd4bf;
  box-shadow: 0 0 20px rgba(45, 212, 191, 1);
  border: 4px solid rgba(45, 212, 191, 0.2);
}

.timeline-item {
  position: relative;
  margin-bottom: 3rem;
  min-height: 350px;
  display: flex;
  flex-direction: column;

  @media (min-width: 768px) {
    margin-bottom: 0;
  }
}

.item-content {
  padding-left: 3rem;
  width: 100%;

  @media (min-width: 768px) {
    padding-left: 0;
    width: 45%;

    &.right {
      margin-left: auto;
      padding-left: 4rem;
    }

    &.left {
      margin-right: auto;
      padding-right: 4rem;
      text-align: right;
    }
  }
}

.content-card {
  padding: 2rem;
  background-color: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(21, 38, 59, 0.05);
  border-radius: 3rem;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  transition: all 0.7s;
  opacity: 0;
  transform: translateX(-80px) translateY(40px) scale(0.9);

  .timeline-item.visible & {
    opacity: 1;
    transform: translateX(0) translateY(0) scale(1);
  }

  .timeline-item.even & {
    transform: translateX(80px) translateY(40px) scale(0.9);

    .timeline-item.even.visible & {
      transform: translateX(0) translateY(0) scale(1);
    }
  }

  .dark-mode & {
    background-color: rgba(25, 32, 44, 1);
    border-color: rgba(250, 250, 250, 0.05);
  }

  @media (min-width: 768px) {
    padding: 3rem;
  }

  &:hover {
    border-color: rgba(45, 212, 191, 0.3);
    box-shadow: 0 35px 60px -15px rgba(0, 0, 0, 0.35);

    .item-period {
      letter-spacing: 0.3em;
    }

    .item-title {
      color: #2dd4bf;
    }
  }
}

.item-period {
  color: #2dd4bf;
  font-weight: 900;
  letter-spacing: 0.15em;
  font-size: 0.75rem;
  text-transform: uppercase;
  display: block;
  margin-bottom: 0.75rem;
  transition: letter-spacing 0.3s;
}

.item-title {
  font-size: 1.5rem;
  font-family: "Playfair Display", serif;
  font-weight: 700;
  margin-bottom: 0.5rem;
  transition: color 0.3s;

  @media (min-width: 768px) {
    font-size: 2.5rem;
  }
}

.item-organization {
  font-size: 1.125rem;
  font-weight: 700;
  font-style: italic;
  opacity: 0.8;
  margin-bottom: 1.5rem;

  @media (min-width: 768px) {
    font-size: 1.25rem;
  }

  .dark-mode & {
    color: rgba(250, 250, 250, 0.8);
  }
}

.item-description {
  line-height: 1.6;

  .dark-mode & {
    color: rgba(250, 250, 250, 0.6);
  }

  @media (min-width: 768px) {
    font-size: 1.125rem;
  }
}

.item-marker {
  position: absolute;
  z-index: 30;
}

.desktop-marker {
  display: none;
  top: 4rem;
  left: 50%;
  transform: translateX(-50%);

  @media (min-width: 768px) {
    display: block;
  }

  &.visible .marker-dot {
    transform: scale(1) rotate(0);
  }
}

.mobile-marker {
  top: 4rem;
  left: 0.5rem;

  @media (min-width: 768px) {
    display: none;
  }
}

.marker-dot {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background-color: #15263b;
  border: 4px solid #fafafa;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  transition: transform 0.6s cubic-bezier(0.16, 1, 0.3, 1);

  .dark-mode & {
    background-color: #fafafa;
    border-color: #15263b;
  }

  .desktop-marker & {
    border-width: 8px;
    box-shadow: 0 0 0 8px rgba(45, 212, 191, 0.05);
    transform: scale(0) rotate(180deg);
  }

  .mobile-marker & {
    width: 16px;
    height: 16px;
  }
}

.decorative-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  pointer-events: none;

  &.blob-right {
    right: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 256px;
    height: 256px;
    background-color: rgba(45, 212, 191, 0.05);
  }

  &.blob-left {
    left: 0;
    bottom: 0;
    width: 384px;
    height: 384px;
    background-color: rgba(56, 189, 248, 0.05);
  }
}

.timeline-enter-active,
.timeline-leave-active {
  transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);
}

.timeline-enter-from {
  opacity: 0;
  transform: scale(0.9);
}

.timeline-leave-to {
  opacity: 0;
  transform: scale(0.9);
}

@keyframes tabSlide {
  0% {
    transform: scale(0.95);
    opacity: 0;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
