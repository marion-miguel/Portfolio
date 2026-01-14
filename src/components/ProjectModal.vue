<template>
  <transition name="modal">
    <div v-if="project" class="modal-overlay" @click="handleOverlayClick">
      <div class="modal-container" @click.stop>
        <button class="close-button" @click="$emit('close')">✕</button>

        <div class="modal-content">
          <!-- Gallery Section -->
          <div class="gallery-container">
            <div ref="galleryRef" class="gallery-scroll" @scroll="handleScroll">
              <div
                v-for="(img, i) in project.images"
                :key="i"
                class="gallery-item"
              >
                <img
                  :src="img"
                  :alt="`${project.title} - ${i}`"
                  class="gallery-image"
                />
              </div>
            </div>

            <!-- Navigation Arrows -->
            <template v-if="project.images.length > 1">
              <button class="gallery-nav prev" @click="scrollGallery('left')">
                ←
              </button>
              <button class="gallery-nav next" @click="scrollGallery('right')">
                →
              </button>
            </template>

            <!-- Indicators -->
            <div class="gallery-indicators">
              <div
                v-for="(_, i) in project.images"
                :key="i"
                :class="['indicator', { active: currentImageIndex === i }]"
              ></div>
            </div>
          </div>

          <!-- Info Section -->
          <div class="info-section">
            <div class="info-main">
              <h2 class="project-title">{{ project.title }}</h2>
              <p class="project-description">{{ project.fullDescription }}</p>
            </div>

            <div class="info-sidebar">
              <div class="info-item">
                <h4 class="info-label">Category</h4>
                <p class="info-value">{{ project.category }}</p>
              </div>
              <div class="info-item">
                <h4 class="info-label">Client</h4>
                <p class="info-value">{{ project.client }}</p>
              </div>
              <div class="info-item">
                <h4 class="info-label">Year</h4>
                <p class="info-value">{{ project.year }}</p>
              </div>
              <div class="info-item">
                <h4 class="info-label">Technologies</h4>
                <div class="tech-tags">
                  <span v-for="tag in project.tags" :key="tag" class="tech-tag">
                    {{ tag }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import { ref, watch, nextTick } from "vue";

export default {
  name: "ProjectModal",
  props: {
    project: {
      type: Object,
      default: null,
    },
  },
  emits: ["close"],
  setup(props, { emit }) {
    const galleryRef = ref(null);
    const currentImageIndex = ref(0);

    const handleOverlayClick = () => {
      emit("close");
    };

    const handleScroll = (e) => {
      const target = e.target;
      currentImageIndex.value = Math.round(
        target.scrollLeft / target.clientWidth
      );
    };

    const scrollGallery = (direction) => {
      if (!galleryRef.value) return;

      const { scrollLeft, clientWidth } = galleryRef.value;
      const scrollAmount = direction === "left" ? -clientWidth : clientWidth;

      galleryRef.value.scrollTo({
        left: scrollLeft + scrollAmount,
        behavior: "smooth",
      });
    };

    watch(
      () => props.project,
      (newProject) => {
        if (newProject) {
          document.body.style.overflow = "hidden";
          currentImageIndex.value = 0;
          nextTick(() => {
            if (galleryRef.value) {
              galleryRef.value.scrollLeft = 0;
            }
          });
        } else {
          document.body.style.overflow = "";
        }
      }
    );

    return {
      galleryRef,
      currentImageIndex,
      handleOverlayClick,
      handleScroll,
      scrollGallery,
    };
  },
};
</script>

<style scoped lang="scss">
.modal-overlay {
  position: fixed;
  inset: 0;
  z-index: 10000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  background-color: rgba(21, 38, 59, 0.8);
  backdrop-filter: blur(40px);

  @media (min-width: 768px) {
    padding: 3rem;
  }
}

.modal-container {
  position: relative;
  background-color: white;
  width: 100%;
  max-width: 1200px;
  max-height: 100%;
  overflow: hidden;
  border-radius: 2.5rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  display: flex;
  flex-direction: column;

  .dark-mode & {
    background-color: #15263b;
    border-color: rgba(255, 255, 255, 0.1);
  }
}

.close-button {
  position: absolute;
  top: 2rem;
  right: 2rem;
  z-index: 30;
  padding: 1rem;
  background-color: rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(12px);
  border-radius: 50%;
  border: none;
  cursor: none;
  transition: all 0.3s;

  .dark-mode & {
    background-color: rgba(255, 255, 255, 0.1);
  }

  &:hover {
    background-color: #2dd4bf;
    color: #15263b;
  }
}

.modal-content {
  flex: 1;
  overflow-y: auto;
  scroll-behavior: smooth;

  &::-webkit-scrollbar {
    display: none;
  }
}

.gallery-container {
  position: relative;
  height: 45vh;

  @media (min-width: 768px) {
    height: 65vh;
  }
}

.gallery-scroll {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  height: 100%;
  scroll-behavior: smooth;

  &::-webkit-scrollbar {
    display: none;
  }
}

.gallery-item {
  flex: 0 0 100%;
  width: 100%;
  height: 100%;
  scroll-snap-align: center;
  overflow: hidden;
}

.gallery-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  animation: scaleIn 0.8s ease-out;
}

.gallery-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  padding: 1rem;
  background-color: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(12px);
  border-radius: 50%;
  border: 1px solid rgba(255, 255, 255, 0.2);
  cursor: none;
  z-index: 20;
  opacity: 0;
  transition: all 0.3s;

  .dark-mode & {
    background-color: rgba(0, 0, 0, 0.2);
  }

  .gallery-container:hover & {
    opacity: 1;
  }

  &:hover {
    background-color: #2dd4bf;
    color: #15263b;
  }

  &.prev {
    left: 2rem;
  }

  &.next {
    right: 2rem;
  }
}

.gallery-indicators {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 0.5rem;
  z-index: 20;
}

.indicator {
  height: 6px;
  border-radius: 9999px;
  background-color: rgba(255, 255, 255, 0.4);
  transition: all 0.5s;
  width: 8px;

  &.active {
    width: 32px;
    background-color: #2dd4bf;
  }
}

.info-section {
  padding: 2rem;
  display: grid;
  grid-template-columns: 1fr;
  gap: 4rem;

  @media (min-width: 768px) {
    padding: 5rem;
    grid-template-columns: 2fr 1fr;
  }
}

.info-main {
  animation: fadeInUp 0.8s ease-out 0.2s both;
}

.project-title {
  font-size: 3rem;
  font-family: "Playfair Display", serif;
  font-weight: 900;
  margin-bottom: 2.5rem;
  line-height: 1.1;

  @media (min-width: 768px) {
    font-size: 4.5rem;
  }
}

.project-description {
  font-size: 1.25rem;
  line-height: 1.6;
  font-weight: 300;
  font-style: italic;

  .dark-mode & {
    color: rgba(250, 250, 250, 0.7);
  }

  @media (min-width: 768px) {
    font-size: 1.5rem;
  }
}

.info-sidebar {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding: 2.5rem;
  background-color: rgba(0, 0, 0, 0.05);
  border-radius: 1.5rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: inset 0 2px 4px 0 rgba(0, 0, 0, 0.2);
  animation: fadeInRight 0.8s ease-out 0.4s both;

  .dark-mode & {
    background-color: rgba(25, 32, 44, 1);
  }
}

.info-item {
  .info-label {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.15em;
    color: #2dd4bf;
    font-weight: 700;
    margin-bottom: 0.5rem;
  }

  .info-value {
    font-size: 1.25rem;
    font-family: "Playfair Display", serif;
  }
}

.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-top: 1rem;
}

.tech-tag {
  font-size: 0.625rem;
  padding: 0.375rem 1rem;
  background-color: #2dd4bf;
  color: #15263b;
  border-radius: 9999px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

@keyframes scaleIn {
  from {
    transform: scale(1.1);
  }
  to {
    transform: scale(1);
  }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}
</style>
