<template>
  <div>
    <!-- Progress Bar -->
    <div
      class="scroll-progress"
      :style="{ transform: `scaleX(${scrollProgress})` }"
    ></div>

    <!-- Navbar -->
    <nav :class="['navbar', { scrolled: scrolled }]">
      <div class="navbar-content">
        <div class="nav-links desktop-only">
          <a
            v-for="(item, idx) in navItems"
            :key="item.label"
            :href="`#${item.href}`"
            class="nav-link"
            :style="{ transitionDelay: `${idx * 0.1}s` }"
            @click="handleNavClick($event, item.href)"
          >
            {{ item.label }}
          </a>
        </div>

        <div class="nav-actions">
          <MagneticButton :strength="20">
            <div class="theme-toggle" @click="$emit('toggle-dark-mode')">
              <div class="toggle-track">
                <div class="toggle-thumb" :class="{ active: darkMode }">
                  <div class="toggle-icon">
                    <svg
                      v-if="darkMode"
                      class="moon-icon"
                      viewBox="0 0 24 24"
                      fill="currentColor"
                    >
                      <path
                        d="M21.64 13a1 1 0 0 0-1.05-.14 8.05 8.05 0 0 1-3.37.73 8.15 8.15 0 0 1-8.14-8.1 8.59 8.59 0 0 1 .25-2A1 1 0 0 0 8 2.36a10.14 10.14 0 1 0 14 11.69 1 1 0 0 0-.36-1.05z"
                      />
                    </svg>
                    <svg
                      v-else
                      class="sun-icon"
                      viewBox="0 0 24 24"
                      fill="currentColor"
                    >
                      <path
                        d="M5.64 17l-.71.71a1 1 0 0 0 0 1.41 1 1 0 0 0 1.41 0L7.05 18.4a1 1 0 0 0 0-1.41 1 1 0 0 0-1.41 0zM5 12a1 1 0 0 0-1-1H3a1 1 0 0 0 0 2h1a1 1 0 0 0 1-1zm7-7a1 1 0 0 0 1-1V3a1 1 0 0 0-2 0v1a1 1 0 0 0 1 1zM5.64 7.05a1 1 0 0 0 .7.29 1 1 0 0 0 .71-.29 1 1 0 0 0 0-1.41l-.71-.71a1 1 0 0 0-1.41 1.41zM12 6.5a5.5 5.5 0 1 0 5.5 5.5A5.51 5.51 0 0 0 12 6.5zM21 11h-1a1 1 0 0 0 0 2h1a1 1 0 0 0 0-2zM18.36 17A1 1 0 0 0 17 18.36l.71.71a1 1 0 0 0 1.41 0 1 1 0 0 0 0-1.41zM12 21a1 1 0 0 0 1 1v1a1 1 0 0 0 2 0v-1a1 1 0 0 0-1-1zM18.36 7.05l.71-.71a1 1 0 0 0 0-1.41 1 1 0 0 0-1.41 0l-.71.71a1 1 0 0 0 0 1.41 1 1 0 0 0 .7.29 1 1 0 0 0 .71-.29z"
                      />
                    </svg>
                  </div>
                </div>
              </div>
            </div>
          </MagneticButton>

          <MagneticButton class="mobile-only">
            <div class="hamburger">
              <span></span>
              <span></span>
            </div>
          </MagneticButton>
        </div>
      </div>
    </nav>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from "vue";
import MagneticButton from "src/components/MagneticButton.vue";

export default {
  name: "NavbarSec",
  components: {
    MagneticButton,
  },
  props: {
    darkMode: {
      type: Boolean,
      required: true,
    },
  },
  emits: ["toggle-dark-mode"],
  setup() {
    const scrolled = ref(false);
    const scrollProgress = ref(0);

    const navItems = [
      { label: "Home", href: "home" },
      { label: "Skills", href: "craft" },
      { label: "Projects", href: "work" },
      { label: "Journey", href: "journey" },
      { label: "Contact", href: "contact" },
    ];

    const handleScroll = () => {
      scrolled.value = window.scrollY > 50;

      const winScroll = document.documentElement.scrollTop;
      const height =
        document.documentElement.scrollHeight -
        document.documentElement.clientHeight;
      scrollProgress.value = height > 0 ? winScroll / height : 0;
    };

    const handleNavClick = (e, href) => {
      e.preventDefault();
      const element = document.getElementById(href);
      if (element) {
        element.scrollIntoView({ behavior: "smooth" });
      }
    };

    onMounted(() => {
      window.addEventListener("scroll", handleScroll);
      handleScroll();
    });

    onUnmounted(() => {
      window.removeEventListener("scroll", handleScroll);
    });

    return {
      scrolled,
      scrollProgress,
      navItems,
      handleNavClick,
    };
  },
};
</script>

<style scoped lang="scss">
.scroll-progress {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: #2dd4bf;
  z-index: 6000;
  transform-origin: left;
  transition: transform 0.1s ease-out;
}

.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 5000;
  padding: 1rem 1.5rem;
  transition: all 0.5s;

  @media (min-width: 768px) {
    padding: 2rem 3rem;
  }

  &.scrolled {
    background-color: rgba(250, 250, 250, 0.8);
    backdrop-filter: blur(12px);
    padding: 1.75rem 1.5rem;

    .dark-mode & {
      background-color: rgba(21, 38, 59, 0.8);
    }

    @media (min-width: 768px) {
      padding: 1.75rem 3rem;
    }
  }
}

.navbar-content {
  max-width: 1600px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.logo {
  font-size: 1.5rem;
  font-family: "Playfair Display", serif;
  font-weight: 700;
  font-style: italic;
  letter-spacing: -0.05em;
  text-decoration: none;
  color: inherit;
  animation: fadeInLeft 0.6s ease-out;
}

.nav-links {
  display: flex;
  align-items: center;
  gap: 2rem;
}

.nav-link {
  font-size: 14px;
  font-weight: 900;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  text-decoration: none;
  color: inherit;
  opacity: 0;
  animation: fadeInDown 0.6s ease-out forwards;
  transition: color 0.3s;

  &:hover {
    color: #2dd4bf;
  }
}

.nav-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
  position: absolute;
  right: 0;
}

.theme-toggle {
  cursor: none;
  background-color: #31d1c2;
  border-radius: 25px;
  padding: 10px;
  margin: 6px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;

  .dark-mode & {
    background-color: rgba(0, 0, 0, 0.25);
    border-color: rgba(0, 0, 0, 0.3);
  }

  &:hover {
    background-color: rgba(255, 255, 255, 0.25);
    transform: scale(1.05);

    .dark-mode & {
      background-color: rgba(0, 0, 0, 0.4);
    }
  }
}

.toggle-track {
  width: 60px;
  height: 30px;
  background-color: #e5e7eb;
  border-radius: 15px;
  position: relative;
  transition: all 0.3s ease;
  cursor: none;

  .dark-mode & {
    background-color: #374151;
  }
}

.toggle-thumb {
  width: 26px;
  height: 26px;
  background-color: #ffffff;
  border-radius: 50%;
  position: absolute;
  top: 2px;
  left: 2px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);

  &.active {
    left: 32px;
    background-color: #2563eb;

    .toggle-icon {
      color: #ffffff;
    }
  }

  .toggle-icon {
    width: 14px;
    height: 14px;
    color: #6b7280;
    transition: color 0.3s ease;

    svg {
      width: 100%;
      height: 100%;
    }
  }
}

.hamburger {
  width: 32px;
  height: 32px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 6px;
  cursor: none;

  span {
    width: 100%;
    height: 2px;
    background-color: currentColor;
  }
}

.desktop-only {
  display: none;

  @media (min-width: 768px) {
    display: flex;
  }
}

.mobile-only {
  display: block;

  @media (min-width: 768px) {
    display: none;
  }
}

@keyframes fadeInLeft {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fadeInDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
