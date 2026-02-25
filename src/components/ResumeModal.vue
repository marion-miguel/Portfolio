<template>
  <transition name="modal">
    <div v-if="isOpen" class="modal-overlay" @click="handleOverlayClick">
      <div class="modal-container" @click.stop>
        <button class="close-button" @click="$emit('close')">✕</button>

        <iframe
          :src="resumePath"
          type="application/pdf"
          class="pdf-viewer"
          title="Resume PDF"
        />
      </div>
    </div>
  </transition>
</template>

<script>
import { ref } from "vue";

export default {
  name: "ResumeModal",
  props: {
    isOpen: {
      type: Boolean,
      default: false,
    },
  },
  emits: ["close"],
  setup(props, { emit }) {
    const resumePath = ref("/pdf/Marion-Ray-G.-Miguel-Resume.pdf");

    const handleOverlayClick = () => {
      emit("close");
    };

    return {
      resumePath,
      handleOverlayClick,
    };
  },
};
</script>

<style scoped lang="scss">
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.85);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  backdrop-filter: blur(5px);

  @media (min-width: 768px) {
    padding: 2rem;
  }
}

.modal-container {
  background: #ffffff;
  border-radius: 16px;
  width: 100%;
  max-width: 1200px;
  height: 90vh;
  max-height: 900px;
  position: relative;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
  overflow: hidden;

  .dark-mode & {
    background: #1e293b;
  }
}

.close-button {
  position: absolute;
  top: 1rem;
  right: 1rem;
  width: 40px;
  height: 40px;
  border: none;
  background: rgba(0, 0, 0, 0.5);
  color: #ffffff;
  border-radius: 50%;
  font-size: 20px;
  cursor: pointer;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;

  .dark-mode & {
    background: rgba(255, 255, 255, 0.2);
    color: #ffffff;
  }

  &:hover {
    background: rgba(239, 68, 68, 0.9);
    color: #ffffff;
    transform: rotate(90deg);
  }
}

.pdf-viewer {
  width: 100%;
  height: 100%;
  border: none;
  border-radius: 16px;
}

.modal-enter-to,
.modal-leave-from {
  opacity: 1;

  .modal-container {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
