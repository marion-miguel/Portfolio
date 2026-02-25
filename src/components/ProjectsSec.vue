<template>
  <section id="work" class="projects-section">
    <div class="projects-container">
      <div class="projects-header">
        <div class="header-left" :class="{ visible: headerVisible }">
          <h4 class="section-subtitle">Portfolio</h4>
          <h2 class="section-title">Selected Creations.</h2>
        </div>

        <div class="header-right" :class="{ visible: headerVisible }">
          <button
            v-for="filter in FILTERS"
            :key="filter"
            :class="['filter-btn', { active: activeFilter === filter }]"
            @click="activeFilter = filter"
          >
            {{ filter }}
          </button>
        </div>
      </div>

      <transition-group name="grid" tag="div" class="projects-grid">
        <div
          v-for="(project, idx) in filteredProjects"
          :key="project.id"
          class="project-card-wrapper"
          :class="{ visible: visibleProjects[idx] }"
          :style="{ transitionDelay: `${(idx % 4) * 0.1}s` }"
        >
          <TiltCard :project="project" @click="selectedProject = project" />
        </div>
      </transition-group>
    </div>

    <ProjectModal
      :project="selectedProject"
      :projects="filteredProjects"
      @close="selectedProject = null"
      @navigate="navigateToProject"
    />
  </section>
</template>

<script>
import { ref, computed, onMounted, onUnmounted, watch } from "vue";
import portfolioData from "src/data/portfolio-data.json";
import TiltCard from "src/components/TiltCard.vue";
import ProjectModal from "src/components/ProjectModal.vue";

const FILTERS = ["ALL", "UI/UX", "Web Development", "Design", "Others"];

export default {
  name: "ProjectsSec",
  components: {
    TiltCard,
    ProjectModal,
  },
  emits: ["accent-change"],
  setup(props, { emit }) {
    const activeFilter = ref("ALL");
    const selectedProject = ref(null);
    const headerVisible = ref(false);
    const visibleProjects = ref({});

    const filteredProjects = computed(() => {
      const projects = portfolioData.ProjectsSection.projects || [];
      if (activeFilter.value === "ALL") {
        return projects;
      }
      return projects.filter((p) => p.category === activeFilter.value);
    });

    const handleScroll = () => {
      const section = document.getElementById("work");
      if (!section) return;

      const rect = section.getBoundingClientRect();
      const windowHeight = window.innerHeight;
      const isInView =
        rect.top < windowHeight * 0.7 && rect.bottom > windowHeight * 0.3;

      if (isInView) {
        headerVisible.value = true;
        filteredProjects.value.forEach((_, idx) => {
          setTimeout(() => {
            visibleProjects.value[idx] = true;
          }, idx * 100);
        });
      } else {
        // Reset animations when out of view
        headerVisible.value = false;
        visibleProjects.value = {};
      }
    };

    const navigateToProject = (direction) => {
      if (!selectedProject.value || !filteredProjects.value.length) return;

      const currentIndex = filteredProjects.value.findIndex(
        (p) => p.id === selectedProject.value.id
      );
      let newIndex;

      if (direction === "next") {
        newIndex =
          currentIndex === filteredProjects.value.length - 1
            ? 0
            : currentIndex + 1;
      } else {
        newIndex =
          currentIndex === 0
            ? filteredProjects.value.length - 1
            : currentIndex - 1;
      }

      selectedProject.value = filteredProjects.value[newIndex];
    };

    watch(selectedProject, (newProject) => {
      if (newProject && newProject.accentColor) {
        emit("accent-change", newProject.accentColor);
      }
    });

    watch(activeFilter, () => {
      // Reset project animations when filter changes
      visibleProjects.value = {};
      // Retrigger scroll check to animate new filtered projects
      setTimeout(() => {
        handleScroll();
      }, 50);
    });

    onMounted(() => {
      window.addEventListener("scroll", handleScroll);
      handleScroll();
    });

    onUnmounted(() => {
      window.removeEventListener("scroll", handleScroll);
    });

    return {
      FILTERS,
      activeFilter,
      selectedProject,
      filteredProjects,
      headerVisible,
      visibleProjects,
      navigateToProject,
    };
  },
};
</script>

<style scoped lang="scss">
.projects-section {
  padding: 6rem 1.5rem;
  background-color: rgba(255, 255, 255, 0.05);

  .dark-mode & {
    background-color: rgba(0, 0, 0, 0.05);
  }

  @media (min-width: 768px) {
    padding: 6rem 3rem;
  }
}

.projects-container {
  max-width: 1600px;
  margin: 0 auto;
}

.projects-header {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  margin-bottom: 4rem;

  @media (min-width: 768px) {
    flex-direction: row;
    align-items: flex-end;
    justify-content: space-between;
  }
}

.header-left {
  opacity: 0;
  transform: translateX(-30px);
  transition: all 0.8s ease-out;

  &.visible {
    opacity: 1;
    transform: translateX(0);
  }
}

.header-right {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  opacity: 0;
  transform: translateX(30px);
  transition: all 0.8s ease-out;

  &.visible {
    opacity: 1;
    transform: translateX(0);
  }
}

.section-subtitle {
  color: #2dd4bf;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.section-title {
  font-size: 2.5rem;
  font-family: "Playfair Display", serif;
  font-weight: 900;
  letter-spacing: -0.02em;
  font-style: italic;

  @media (min-width: 768px) {
    font-size: 4.5rem;
  }
}

.filter-btn {
  padding: 0.5rem 1.5rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  border: 1px solid;
  background-color: transparent;
  cursor: none;
  transition: all 0.3s;
  color: #0f172a;

  border-color: rgba(21, 38, 59, 0.1);

  .dark-mode & {
    border-color: rgba(250, 250, 250, 0.1);
    color: #fafafa;
  }

  &:hover {
    border-color: rgba(45, 212, 191, 0.5);
  }

  &.active {
    background-color: #2dd4bf;
    border-color: #2dd4bf;
    color: #ffffff;
    box-shadow: 0 10px 25px -5px rgba(45, 212, 191, 0.3);
  }
}

.projects-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.5rem;

  @media (min-width: 768px) {
    grid-template-columns: repeat(2, 1fr);
  }

  @media (min-width: 1024px) {
    grid-template-columns: repeat(3, 1fr);
  }

  @media (min-width: 1536px) {
    grid-template-columns: repeat(4, 1fr);
  }
}

.project-card-wrapper {
  opacity: 0;
  transform: translateY(50px) scale(0.9);
  transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);

  &.visible {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.grid-enter-active,
.grid-leave-active {
  transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);
}

.grid-enter-from {
  opacity: 0;
  transform: scale(0.9) translateY(20px);
}

.grid-leave-to {
  opacity: 0;
  transform: scale(0.9) translateY(20px);
}

.grid-move {
  transition: transform 0.6s cubic-bezier(0.23, 1, 0.32, 1);
}
</style>
