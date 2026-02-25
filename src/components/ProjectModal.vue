<template>
  <transition name="modal">
    <div v-if="project" class="modal-overlay" @click="handleOverlayClick">
      <!-- Project Navigation Buttons -->
      <template v-if="projects.length > 1">
        <button
          class="project-nav prev"
          @click.stop="$emit('navigate', 'prev')"
          :title="'Previous: ' + getPreviousProject()?.title"
        >
          <span class="nav-icon">‹</span>
        </button>
        <button
          class="project-nav next"
          @click.stop="$emit('navigate', 'next')"
          :title="'Next: ' + getNextProject()?.title"
        >
          <span class="nav-icon">›</span>
        </button>
      </template>

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
                :class="{ zoomed: zoomActive }"
                @mouseenter="handleImageMouseEnter"
                @mouseleave="handleImageMouseLeave"
                @mousemove="handleImageMouseMove"
                @touchstart="handleImageTouchStart"
              >
                <div class="image-container">
                  <img
                    :src="img.src || img"
                    :alt="img.description || `${project.title} - ${i}`"
                    class="gallery-image"
                    @load="handleImageLoad"
                  />

                  <!-- Zoom Box -->
                  <div
                    v-if="zoomActive"
                    class="zoom-box"
                    :style="zoomBoxStyle"
                  ></div>

                  <!-- Zoom Preview -->
                  <div
                    v-if="zoomActive"
                    class="zoom-preview"
                    :style="zoomPreviewStyle"
                  >
                    <img
                      :src="img.src || img"
                      :alt="`Zoomed ${img.description || project.title}`"
                      class="zoom-preview-image"
                      :style="zoomPreviewImageStyle"
                    />
                  </div>
                </div>

                <div v-if="img.description" class="image-description">
                  {{ img.description }}
                </div>
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
import { ref, watch, nextTick, onMounted, onUnmounted } from "vue";

export default {
  name: "ProjectModal",
  props: {
    project: {
      type: Object,
      default: null,
    },
    projects: {
      type: Array,
      default: () => [],
    },
  },
  emits: ["close", "navigate"],
  setup(props, { emit }) {
    const galleryRef = ref(null);
    const currentImageIndex = ref(0);
    const zoomActive = ref(false);
    const mouseX = ref(0);
    const mouseY = ref(0);
    const zoomBoxStyle = ref({});
    const zoomPreviewStyle = ref({});
    const zoomPreviewImageStyle = ref({});
    const currentImageElement = ref(null);

    const handleImageMouseEnter = (event) => {
      // Only enable zoom on devices that support hover
      if (!window.matchMedia("(hover: hover) and (pointer: fine)").matches) {
        return;
      }

      zoomActive.value = true;
      currentImageElement.value =
        event.currentTarget.querySelector(".gallery-image");

      // Trigger initial zoom positioning
      const rect = event.currentTarget.getBoundingClientRect();
      const x = rect.width / 2;
      const y = rect.height / 2;
      updateZoomStyles(x, y, rect);
    };

    const handleImageMouseLeave = () => {
      zoomActive.value = false;
    };

    const handleImageMouseMove = (event) => {
      if (!zoomActive.value) return;

      const rect = event.currentTarget.getBoundingClientRect();
      const x = event.clientX - rect.left;
      const y = event.clientY - rect.top;

      mouseX.value = x;
      mouseY.value = y;

      updateZoomStyles(x, y, rect);
    };

    // Add touch support for image descriptions
    const handleImageTouchStart = (event) => {
      // Toggle image description visibility on touch
      const imageItem = event.currentTarget;
      const description = imageItem.querySelector(".image-description");

      if (description) {
        const isVisible = description.style.transform === "translateY(0px)";
        description.style.transform = isVisible
          ? "translateY(100%)"
          : "translateY(0px)";
      }
    };

    const updateZoomStyles = (x, y, rect) => {
      const zoomBoxSize = 150;
      const zoomLevel = 2.5;
      const previewSize = 300;

      // Zoom box positioning
      zoomBoxStyle.value = {
        left: `${x - zoomBoxSize / 2}px`,
        top: `${y - zoomBoxSize / 2}px`,
        width: `${zoomBoxSize}px`,
        height: `${zoomBoxSize}px`,
      };

      // Preview positioning (follow cursor but stay within bounds)
      let previewX = x + 20;
      let previewY = y + 20;

      // Keep preview within the container bounds
      if (previewX + previewSize > rect.width) {
        previewX = x - previewSize - 20;
      }
      if (previewY + previewSize > rect.height) {
        previewY = y - previewSize - 20;
      }

      zoomPreviewStyle.value = {
        left: `${previewX}px`,
        top: `${previewY}px`,
        width: `${previewSize}px`,
        height: `${previewSize}px`,
      };

      // Calculate the image offset for the zoomed view
      if (currentImageElement.value) {
        const img = currentImageElement.value;
        const imgRect = img.getBoundingClientRect();
        const containerRect = rect;

        // Calculate relative position within the image
        const relativeX =
          (x - (imgRect.left - containerRect.left)) / imgRect.width;
        const relativeY =
          (y - (imgRect.top - containerRect.top)) / imgRect.height;

        zoomPreviewImageStyle.value = {
          transform: `scale(${zoomLevel})`,
          transformOrigin: `${relativeX * 100}% ${relativeY * 100}%`,
          width: `${previewSize}px`,
          height: `${previewSize}px`,
          objectFit: "cover",
        };
      }
    };

    const handleImageLoad = (event) => {
      // Ensure images load properly
      const img = event.target;
      img.style.opacity = "1";
    };

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

    const getPreviousProject = () => {
      if (!props.project || !props.projects.length) return null;
      const currentIndex = props.projects.findIndex(
        (p) => p.id === props.project.id
      );
      const prevIndex =
        currentIndex === 0 ? props.projects.length - 1 : currentIndex - 1;
      return props.projects[prevIndex];
    };

    const getNextProject = () => {
      if (!props.project || !props.projects.length) return null;
      const currentIndex = props.projects.findIndex(
        (p) => p.id === props.project.id
      );
      const nextIndex =
        currentIndex === props.projects.length - 1 ? 0 : currentIndex + 1;
      return props.projects[nextIndex];
    };

    const handleKeydown = (event) => {
      if (!props.project) return;

      switch (event.key) {
        case "Escape":
          emit("close");
          break;
        case "ArrowLeft":
          if (props.projects.length > 1) {
            emit("navigate", "prev");
          }
          break;
        case "ArrowRight":
          if (props.projects.length > 1) {
            emit("navigate", "next");
          }
          break;
      }
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

    onMounted(() => {
      document.addEventListener("keydown", handleKeydown);
    });

    onUnmounted(() => {
      document.removeEventListener("keydown", handleKeydown);
      document.body.style.overflow = "";
    });

    return {
      galleryRef,
      currentImageIndex,
      zoomActive,
      mouseX,
      mouseY,
      zoomBoxStyle,
      zoomPreviewStyle,
      zoomPreviewImageStyle,
      currentImageElement,
      handleImageMouseEnter,
      handleImageMouseLeave,
      handleImageMouseMove,
      handleImageTouchStart,
      handleImageLoad,
      handleOverlayClick,
      handleScroll,
      scrollGallery,
      getPreviousProject,
      getNextProject,
      handleKeydown,
    };
  },
};
</script>

<style scoped lang="scss">
// Responsive breakpoints
$mobile: 480px;
$tablet: 768px;
$laptop: 1024px;
$desktop: 1200px;

.modal-overlay {
  position: fixed;
  inset: 0;
  z-index: 10000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0.5rem;
  background-color: rgba(21, 38, 59, 0.8);
  backdrop-filter: blur(40px);

  @media (min-width: $mobile) {
    padding: 0.75rem;
  }

  @media (min-width: $tablet) {
    padding: 1rem;
  }

  @media (min-width: $laptop) {
    padding: 1.5rem;
  }
}

.modal-container {
  position: relative;
  background-color: white;
  width: 100%;
  max-width: none;
  max-height: 95vh;
  height: 95vh;
  overflow: hidden;
  border-radius: 1rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  display: flex;
  flex-direction: column;

  @media (min-width: $mobile) {
    border-radius: 1.5rem;
    max-height: 90vh;
    height: 90vh;
  }

  @media (min-width: $tablet) {
    max-width: 95vw;
    border-radius: 2rem;
    height: auto;
    max-height: 85vh;
  }

  @media (min-width: $laptop) {
    max-width: 1024px;
    border-radius: 2.5rem;
    max-height: 90vh;
  }

  @media (min-width: $desktop) {
    max-width: 1200px;
  }

  .dark-mode & {
    background-color: #15263b;
    border-color: rgba(255, 255, 255, 0.1);
  }
}

.close-button {
  position: absolute;
  top: 1rem;
  right: 1rem;
  z-index: 30;
  padding: 0.75rem;
  background: rgba(0, 0, 0, 0.6);
  border: none;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s;
  color: #ffffff;
  font-size: 1.2rem;
  width: 2.5rem;
  height: 2.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(10px);

  @media (min-width: $mobile) {
    top: 1.25rem;
    right: 1.25rem;
    width: 3rem;
    height: 3rem;
    font-size: 1.3rem;
    padding: 0.875rem;
  }

  @media (min-width: $tablet) {
    top: 1.5rem;
    right: 1.5rem;
    width: 3.5rem;
    height: 3.5rem;
    font-size: 1.4rem;
    padding: 1rem;
    cursor: none;
    background: transparent;
  }

  @media (min-width: $laptop) {
    top: 2rem;
    right: 2rem;
    font-size: 1.5rem;
  }

  &:hover {
    transform: scale(1.1);
    background: rgba(0, 0, 0, 0.8);

    @media (min-width: $tablet) {
      background: transparent;
    }
  }

  &:active {
    transform: scale(0.95);
  }
}

.project-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 25;
  background: rgba(0, 0, 0, 0.6);
  border: none;
  border-radius: 50%;
  backdrop-filter: blur(10px);
  padding: 0.75rem;
  color: #ffffff;
  cursor: pointer;
  width: 3rem;
  height: 3rem;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 1;
  transition: all 0.3s ease;

  @media (min-width: $mobile) {
    width: 3.5rem;
    height: 3.5rem;
    padding: 0.875rem;
  }

  @media (min-width: $tablet) {
    background: transparent;
    border-radius: 0;
    backdrop-filter: none;
    opacity: 0;
    cursor: none;
    width: auto;
    height: auto;
    padding: 0;

    .modal-overlay:hover & {
      opacity: 1;
    }
  }

  @media (min-width: $laptop) {
    &.prev {
      left: 2rem;
    }

    &.next {
      right: 2rem;
    }
  }

  &:hover {
    transform: translateY(-50%) scale(1.1);
    background: rgba(0, 0, 0, 0.8);

    @media (min-width: $tablet) {
      background: transparent;
    }
  }

  &:active {
    transform: translateY(-50%) scale(0.95);
  }

  &.prev {
    left: 1rem;

    @media (min-width: $mobile) {
      left: 1.25rem;
    }

    @media (min-width: $tablet) {
      left: 1.5rem;
    }
  }

  &.next {
    right: 1rem;

    @media (min-width: $mobile) {
      right: 1.25rem;
    }

    @media (min-width: $tablet) {
      right: 1.5rem;
    }
  }
}

.project-nav .nav-icon {
  font-size: 1.5rem;
  font-weight: 300;
  line-height: 1;
  color: #ffffff;

  @media (min-width: $mobile) {
    font-size: 1.75rem;
  }

  @media (min-width: $tablet) {
    font-size: 3rem;
  }

  @media (min-width: $laptop) {
    font-size: 5rem;
  }
}

.nav-icon {
  font-size: 1.5rem;

  @media (min-width: $tablet) {
    font-size: 5rem;
  }
}

.modal-content {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  scroll-behavior: smooth;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  padding: 0.75rem;

  @media (min-width: $mobile) {
    gap: 1rem;
    padding: 1rem;
  }

  @media (min-width: $tablet) {
    flex-direction: row;
    gap: 1.25rem;
    padding: 1.25rem;
  }

  @media (min-width: $laptop) {
    gap: 1.5rem;
    padding: 1.5rem;
  }

  &::-webkit-scrollbar {
    display: none;
  }
}

.gallery-container {
  position: relative;
  flex: 1;
  min-height: 40vh;
  background-color: #f8fafc;
  border-radius: 0.75rem;
  overflow: hidden;

  @media (min-width: $mobile) {
    min-height: 45vh;
    border-radius: 1rem;
  }

  @media (min-width: $tablet) {
    flex: 2.5;
    min-height: 70vh;
  }

  @media (min-width: $laptop) {
    min-height: 75vh;
  }

  @media (min-width: $desktop) {
    min-height: 80vh;
  }

  .dark-mode & {
    background-color: #1e293b;
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
  position: relative;
  cursor: default;

  // Only show crosshair cursor on devices that support hover
  @media (hover: hover) and (pointer: fine) {
    cursor: crosshair;

    &.zoomed {
      cursor: crosshair;
    }
  }
}

.image-container {
  width: 100%;
  height: 100%;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(0, 0, 0, 0.02);
}

.gallery-image {
  max-width: 100%;
  max-height: 100%;
  width: auto;
  height: auto;
  object-fit: contain;
  object-position: center;
  animation: scaleIn 0.8s ease-out;
  transition: all 0.3s ease;
  opacity: 0;
  border-radius: 0.5rem;
  cursor: default;

  // Only show crosshair cursor on devices that support hover
  @media (hover: hover) and (pointer: fine) {
    cursor: crosshair;
  }
}

.zoom-box {
  position: absolute;
  border: 3px solid #2dd4bf;
  border-radius: 50%;
  pointer-events: none;
  z-index: 15;
  background-color: rgba(45, 212, 191, 0.1);
  box-shadow: 0 0 0 2px rgba(45, 212, 191, 0.3),
    0 0 20px rgba(45, 212, 191, 0.4);
  backdrop-filter: blur(1px);
  transition: all 0.15s ease-out;
  transform: scale(0);
  animation: zoomBoxAppear 0.2s ease-out forwards;

  // Hide zoom box on touch devices for better UX
  @media (hover: none) and (pointer: coarse) {
    display: none;
  }
}

@keyframes zoomBoxAppear {
  from {
    transform: scale(0);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

.zoom-preview {
  position: absolute;
  border: 3px solid #2dd4bf;
  border-radius: 1rem;
  overflow: hidden;
  pointer-events: none;
  z-index: 20;
  background-color: white;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3), 0 0 0 2px rgba(45, 212, 191, 0.5);
  backdrop-filter: blur(10px);
  transition: all 0.15s ease-out;
  transform: scale(0);
  animation: zoomPreviewAppear 0.3s ease-out 0.1s forwards;

  // Hide zoom preview on touch devices for better UX
  @media (hover: none) and (pointer: coarse) {
    display: none;
  }

  .dark-mode & {
    background-color: #1e293b;
    border-color: #2dd4bf;
  }

  &::before {
    content: "";
    position: absolute;
    top: -3px;
    left: -3px;
    right: -3px;
    bottom: -3px;
    background: linear-gradient(45deg, #2dd4bf, #14b8a6, #0f766e, #2dd4bf);
    background-size: 400% 400%;
    border-radius: 1rem;
    z-index: -1;
    animation: gradientShift 2s ease infinite;
  }
}

@keyframes zoomPreviewAppear {
  from {
    transform: scale(0);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

.zoom-preview-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 0.8rem;
}

@keyframes gradientShift {
  0%,
  100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

.image-description {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.9), transparent);
  color: white;
  padding: 1rem 0.75rem 0.75rem;
  font-size: 0.8rem;
  line-height: 1.4;
  border-radius: 0 0 0.75rem 0.75rem;
  transform: translateY(100%);
  transition: transform 0.3s ease;

  @media (min-width: $mobile) {
    padding: 1.2rem 0.875rem 0.875rem;
    font-size: 0.825rem;
    border-radius: 0 0 1rem 1rem;
  }

  @media (min-width: $tablet) {
    padding: 1.5rem 1rem 1rem;
    font-size: 0.875rem;
  }
}

.gallery-item:hover .image-description {
  transform: translateY(0);
}

// Touch devices - show description on tap
@media (hover: none) and (pointer: coarse) {
  .image-description {
    // Start hidden but can be toggled via touch
    transform: translateY(100%);
  }
}

.gallery-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  padding: 0.75rem;
  background: rgba(0, 0, 0, 0.6);
  border: none;
  border-radius: 50%;
  backdrop-filter: blur(10px);
  cursor: pointer;
  z-index: 20;
  opacity: 1;
  transition: all 0.3s;
  color: #ffffff;
  font-size: 1.2rem;
  width: 2.5rem;
  height: 2.5rem;
  display: flex;
  align-items: center;
  justify-content: center;

  @media (min-width: $mobile) {
    width: 3rem;
    height: 3rem;
    font-size: 1.3rem;
    padding: 0.875rem;
  }

  @media (min-width: $tablet) {
    background: transparent;
    border-radius: 0;
    backdrop-filter: none;
    opacity: 0;
    cursor: none;
    width: auto;
    height: auto;
    padding: 1rem;
    font-size: 1.5rem;

    .gallery-container:hover & {
      opacity: 1;
    }
  }

  &:hover {
    transform: translateY(-50%) scale(1.1);
    background: rgba(0, 0, 0, 0.8);

    @media (min-width: $tablet) {
      background: transparent;
    }
  }

  &:active {
    transform: translateY(-50%) scale(0.95);
  }

  &.prev {
    left: 1rem;

    @media (min-width: $tablet) {
      left: 2rem;
    }
  }

  &.next {
    right: 1rem;

    @media (min-width: $tablet) {
      right: 2rem;
    }
  }
}

.gallery-indicators {
  position: absolute;
  bottom: 1rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 0.375rem;
  z-index: 20;

  @media (min-width: $mobile) {
    bottom: 1.25rem;
    gap: 0.5rem;
  }

  @media (min-width: $tablet) {
    bottom: 1.5rem;
  }

  @media (min-width: $laptop) {
    bottom: 2rem;
  }
}

.indicator {
  height: 4px;
  border-radius: 9999px;
  background-color: rgba(255, 255, 255, 0.4);
  transition: all 0.5s;
  width: 6px;

  @media (min-width: $mobile) {
    height: 5px;
    width: 7px;
  }

  @media (min-width: $tablet) {
    height: 6px;
    width: 8px;
  }

  &.active {
    width: 24px;
    background-color: #2dd4bf;

    @media (min-width: $mobile) {
      width: 28px;
    }

    @media (min-width: $tablet) {
      width: 32px;
    }
  }
}

.info-section {
  flex: 1;
  padding: 0.75rem;
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
  overflow-y: auto;

  @media (min-width: $mobile) {
    padding: 1rem;
    gap: 1.25rem;
  }

  @media (min-width: $tablet) {
    flex: 1.2;
    padding: 1.25rem;
    gap: 1.5rem;
  }

  @media (min-width: $laptop) {
    padding: 1.5rem;
    gap: 2rem;
  }
}

.info-main {
  animation: fadeInUp 0.8s ease-out 0.2s both;
}

.project-title {
  font-size: 1.4rem;
  font-family: "Playfair Display", serif;
  font-weight: 900;
  margin-bottom: 0.75rem;
  line-height: 1.1;

  @media (min-width: $mobile) {
    font-size: 1.6rem;
    margin-bottom: 0.875rem;
  }

  @media (min-width: $tablet) {
    font-size: 1.8rem;
    margin-bottom: 1rem;
  }

  @media (min-width: $laptop) {
    font-size: 2.2rem;
    margin-bottom: 1.25rem;
  }

  @media (min-width: $desktop) {
    font-size: 2.5rem;
    margin-bottom: 1.5rem;
  }
}

.project-description {
  font-size: 0.8rem;
  line-height: 1.5;
  font-weight: 300;
  font-style: italic;

  @media (min-width: $mobile) {
    font-size: 0.85rem;
    line-height: 1.55;
  }

  @media (min-width: $tablet) {
    font-size: 0.9rem;
    line-height: 1.6;
  }

  @media (min-width: $laptop) {
    font-size: 1rem;
  }

  .dark-mode & {
    color: rgba(250, 250, 250, 0.7);
  }
}

.info-sidebar {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  padding: 1rem;
  background-color: rgba(0, 0, 0, 0.05);
  border-radius: 0.75rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: inset 0 2px 4px 0 rgba(0, 0, 0, 0.2);
  animation: fadeInRight 0.8s ease-out 0.4s both;

  @media (min-width: $mobile) {
    gap: 0.875rem;
    border-radius: 1rem;
  }

  @media (min-width: $tablet) {
    gap: 1rem;
    padding: 1.25rem;
  }

  .dark-mode & {
    background-color: rgba(25, 32, 44, 1);
  }
}

.info-item {
  .info-label {
    font-size: 0.7rem;
    text-transform: uppercase;
    letter-spacing: 0.15em;
    color: #2dd4bf;
    font-weight: 700;
    margin-bottom: 0.375rem;

    @media (min-width: $mobile) {
      font-size: 0.72rem;
      margin-bottom: 0.45rem;
    }

    @media (min-width: $tablet) {
      font-size: 0.75rem;
      margin-bottom: 0.5rem;
    }
  }

  .info-value {
    font-size: 0.85rem;
    font-family: "Playfair Display", serif;

    @media (min-width: $mobile) {
      font-size: 0.9rem;
    }

    @media (min-width: $tablet) {
      font-size: 0.95rem;
    }
  }
}

.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.375rem;
  margin-top: 0.75rem;

  @media (min-width: $mobile) {
    gap: 0.45rem;
    margin-top: 0.875rem;
  }

  @media (min-width: $tablet) {
    gap: 0.5rem;
    margin-top: 1rem;
  }
}

.tech-tag {
  font-size: 0.55rem;
  padding: 0.3rem 0.75rem;
  background-color: #2dd4bf;
  color: #15263b;
  border-radius: 9999px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.1em;

  @media (min-width: $mobile) {
    font-size: 0.6rem;
    padding: 0.325rem 0.875rem;
  }

  @media (min-width: $tablet) {
    font-size: 0.625rem;
    padding: 0.375rem 1rem;
  }
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
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
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

/* Image loading animation */
.gallery-image {
  &[src] {
    opacity: 1;
  }
}
</style>
