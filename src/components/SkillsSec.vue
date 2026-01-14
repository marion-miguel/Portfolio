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
          <div class="skill-dots">
            <div v-for="dot in 5" :key="dot" class="dot"></div>
          </div>
          <div class="skill-accent"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { ref, onMounted, onUnmounted, computed } from "vue";
import { SKILLS } from "src/data/constants.js";

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

    const skillsWithCategories = SKILLS.map((skill) => ({
      ...skill,
      category: getSkillCategory(skill.name),
    }));

    function getSkillCategory(skillName) {
      const developmentSkills = [
        "React / Next.js",
        "TypeScript",
        "Node.js",
        "Three.js / WebGL",
      ];
      const designSkills = ["UI/UX Design"];

      if (developmentSkills.some((dev) => skillName.includes(dev)))
        return "development";
      if (designSkills.some((design) => skillName.includes(design)))
        return "design";
      return "other";
    }

    const filteredSkills = computed(() => {
      if (activeCategory.value === "all") {
        return skillsWithCategories;
      }
      return skillsWithCategories.filter(
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
      const isInView = rect.top < window.innerHeight * 0.7;

      if (isInView) {
        headerVisible.value = true;
        filteredSkills.value.forEach((_, idx) => {
          setTimeout(() => {
            visibleCards.value[idx] = true;
          }, idx * 50);
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

    return {
      SKILLS,
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
  min-height: 220px;
  padding: 2.5rem;
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

    .skill-dots {
      opacity: 1;
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

.skill-dots {
  margin-top: 1.5rem;
  display: flex;
  gap: 0.5rem;
  opacity: 0;
  transition: opacity 0.7s;

  .dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background-color: #2dd4bf;
  }
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
