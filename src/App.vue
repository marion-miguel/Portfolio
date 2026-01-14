<template>
  <div :class="['app-container', { 'dark-mode': darkMode }]">
    <CustomCursor />
    <MorphingBackground :activeAccent="activeAccent" />
    <Navbar :darkMode="darkMode" @toggle-dark-mode="toggleDarkMode" />

    <main class="main-content">
      <Hero />
      <Skills />
      <Projects @accent-change="handleAccentChange" />
      <Timeline />
      <Contact />
    </main>

    <!-- Grain Overlay -->
    <svg class="grain-overlay">
      <filter id="noise">
        <feTurbulence
          type="fractalNoise"
          baseFrequency="0.6"
          numOctaves="3"
          stitchTiles="stitch"
        />
        <feColorMatrix type="saturate" values="0" />
      </filter>
      <rect width="100%" height="100%" filter="url(#noise)" />
    </svg>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import CustomCursor from "src/components/CustomCursor.vue";
import MorphingBackground from "src/components/MorphingBackground.vue";
import Navbar from "src/components/NavbarSec.vue";
import Hero from "src/components/HeroSec.vue";
import Skills from "src/components/SkillsSec.vue";
import Projects from "src/components/ProjectsSec.vue";
import Timeline from "src/components/TimelineSec.vue";
import Contact from "src/components/ContactSec.vue";

export default {
  name: "App",
  components: {
    CustomCursor,
    MorphingBackground,
    Navbar,
    Hero,
    Skills,
    Projects,
    Timeline,
    Contact,
  },
  setup() {
    const darkMode = ref(true);
    const activeAccent = ref("#2DD4BF");

    const toggleDarkMode = () => {
      darkMode.value = !darkMode.value;
      updateTheme();
    };

    const handleAccentChange = (color) => {
      activeAccent.value = color;
    };

    const updateTheme = () => {
      if (darkMode.value) {
        document.documentElement.classList.add("dark-mode");
      } else {
        document.documentElement.classList.remove("dark-mode");
      }
    };

    onMounted(() => {
      updateTheme();
    });

    return {
      darkMode,
      activeAccent,
      toggleDarkMode,
      handleAccentChange,
    };
  },
};
</script>

<style lang="scss">
.app-container {
  min-height: 100vh;
  background-color: #fafafa;
  color: #15263b;
  transition: background-color 0.7s, color 0.7s;

  &.dark-mode {
    background-color: #15263b;
    color: #fafafa;
  }
}

.main-content {
  position: relative;
  z-index: 1;
}

.grain-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 9999;
  opacity: 0.04;
}
</style>
