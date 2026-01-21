<template>
  <section id="craft" class="skills-section">
    <div class="skills-container">
      <div class="skills-header" :class="{ visible: headerVisible }">
        <h4 class="section-subtitle">Capabilities</h4>
        <h2 class="section-title">Technical Craft.</h2>
      </div>

      <div class="skills-filter" :class="{ visible: headerVisible }">
        <button
          v-for="category in categories"
          :key="category.value"
          class="filter-btn"
          :class="{ active: activeCategory === category.value }"
          @click="setActiveCategory(category.value)"
        >
          {{ category.label }}
        </button>
      </div>

      <div class="skills-grid">
        <div
          v-for="(skill, idx) in filteredSkills"
          :key="skill.name"
          class="skill-card"
          :class="{ visible: visibleCards[idx] }"
          :style="{ transitionDelay: `${idx * 0.05}s` }"
        >
          <span class="skill-index">{{ skill.index }}</span>
          <div class="skill-icon">{{ skill.icon }}</div>
          <h3 class="skill-name">{{ skill.name }}</h3>

          <div class="skill-accent"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { ref, onMounted, onUnmounted, computed } from "vue";
import portfolioData from "src/data/portfolio-data.json";

export default {
  name: "SkillsSec",
  setup() {
    const headerVisible = ref(false);
    const visibleCards = ref({});
    const activeCategory = ref("all");

    const categories = [
      { label: "All Skills", value: "all" },
      { label: "Development", value: "development" },
      { label: "Design", value: "design" },
      { label: "Other Skills", value: "other" },
    ];

    const skillsData = computed(() => {
      const skills = portfolioData.AboutSection.skills;
      const allSkills = [
        ...skills.development.map((name) => ({
          name,
          category: "development",
          level: 85,
          icon: "💻",
        })),
        ...skills.design.map((name) => ({
          name,
          category: "design",
          level: 80,
          icon: "🎨",
        })),
        ...skills.other.map((name) => ({
          name,
          category: "other",
          level: 75,
          icon: "⚡",
        })),
      ];
      return allSkills.map((skill, index) => ({
        ...skill,
        index: String(index + 1).padStart(2, "0"),
      }));
    });

    const skillsWithCategories = skillsData;

    function getSkillCategory(skillName) {
      const skill = skillsData.value.find((s) => s.name === skillName);
      return skill ? skill.category : "other";
    }

    const filteredSkills = computed(() => {
      if (activeCategory.value === "all") {
        return skillsWithCategories.value;
      }
      return skillsWithCategories.value.filter(
        (skill) => skill.category === activeCategory.value
      );
    });

    const setActiveCategory = (category) => {
      activeCategory.value = category;
      // Reset visibility for new filtered skills
      visibleCards.value = {};
      setTimeout(() => {
        filteredSkills.value.forEach((_, idx) => {
          setTimeout(() => {
            visibleCards.value[idx] = true;
          }, idx * 50);
        });
      }, 100);
    };

    const handleScroll = () => {
      const section = document.getElementById("craft");
      if (!section) return;

      const rect = section.getBoundingClientRect();
      const windowHeight = window.innerHeight;
      const isInView =
        rect.top < windowHeight * 0.7 && rect.bottom > windowHeight * 0.3;

      if (isInView) {
        headerVisible.value = true;
        filteredSkills.value.forEach((_, idx) => {
          setTimeout(() => {
            visibleCards.value[idx] = true;
          }, idx * 50);
        });
      } else {
        // Reset animations when out of view
        headerVisible.value = false;
        visibleCards.value = {};
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
      skillsData,
      headerVisible,
      visibleCards,
      activeCategory,
      categories,
      filteredSkills,
      setActiveCategory,
    };
  },
};
</script>

<style scoped lang="scss">
.skills-section {
  padding: 6rem 1.5rem;
  background-color: rgba(255, 255, 255, 0.05);

  .dark-mode & {
    background-color: rgba(25, 32, 44, 0.3);
  }

  @media (min-width: 768px) {
    padding: 6rem 3rem;
  }
}

.skills-container {
  max-width: 1600px;
  margin: 0 auto;
}

.skills-header {
  margin-bottom: 3rem;
  text-align: center;
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.8s ease-out;

  @media (min-width: 768px) {
    text-align: left;
    margin-bottom: 4rem;
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
  }
}

.skills-filter {
  display: flex;
  justify-content: flex-end;
  flex-wrap: wrap;
  gap: 1rem;
  margin-bottom: 3rem;
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.8s ease-out;
  transition-delay: 0.2s;

  @media (min-width: 768px) {
    gap: 1.5rem;
  }

  &.visible {
    opacity: 1;
    transform: translateY(0);
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
  font-style: italic;

  @media (min-width: 768px) {
    font-size: 4.5rem;
  }
}

.skills-grid {
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
    grid-template-columns: repeat(6, 1fr);
  }
}

.skill-card {
  position: relative;
  min-height: 200px;
  padding: 1.5rem 0.5rem;
  background-color: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(21, 38, 59, 0.05);
  border-radius: 2.5rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  overflow: hidden;
  transition: all 0.7s cubic-bezier(0.23, 1, 0.32, 1);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  opacity: 0;
  transform: translateY(20px) scale(0.9);

  .dark-mode & {
    background-color: rgba(25, 32, 44, 1);
    border-color: rgba(250, 250, 250, 0.05);
  }

  &.visible {
    opacity: 1;
    transform: translateY(0) scale(1);
  }

  &:hover {
    border-color: rgba(45, 212, 191, 0.5);
    background-color: rgba(255, 255, 255, 0.1);
    transform: translateY(0) scale(1);

    .dark-mode & {
      background-color: rgba(255, 255, 255, 0.05);
    }

    .skill-index {
      opacity: 0.05;
    }

    .skill-icon {
      transform: scale(1.1) translateY(-8px);
    }

    .skill-name {
      color: #2dd4bf;
    }
  }
}

.skill-index {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 12rem;
  font-family: "Playfair Display", serif;
  font-weight: 900;
  opacity: 0.02;
  pointer-events: none;
  transition: opacity 0.7s;
}

.skill-icon {
  font-size: 3.75rem;
  margin-bottom: 2rem;
  transform: scale(1);
  transition: transform 0.7s;
}

.skill-name {
  font-size: 1.125rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  line-height: 1.3;
  transition: color 0.7s;
}
.skill-accent {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 33.333%;
  height: 1px;
  background: linear-gradient(
    to right,
    transparent,
    rgba(45, 212, 191, 0.3),
    transparent
  );
}
</style>
