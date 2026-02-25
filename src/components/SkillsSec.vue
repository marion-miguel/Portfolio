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
          <div class="skill-icon" v-html="skill.icon"></div>
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

      // Icon mapping for each skill
      const skillIcons = {
        "HTML 5": `<svg viewBox="0 0 24 24" fill="#e34c26"><path d="M1.5 0h21l-1.91 21.563L11.977 24l-8.564-2.438L1.5 0zm7.031 9.75l-.232-2.718 10.059.003.23-2.622L5.412 4.41l.698 8.01h9.126l-.326 3.426-2.91.804-2.955-.81-.188-2.11H6.248l.33 4.171L12 19.351l5.379-1.443.744-8.157H8.531z"/></svg>`,
        "Rest API": `<svg viewBox="0 0 24 24" fill="#61dafb"><path d="M14.23 12.004a2.236 2.236 0 0 1-2.235 2.236 2.236 2.236 0 0 1-2.236-2.236 2.236 2.236 0 0 1 2.235-2.236 2.236 2.236 0 0 1 2.236 2.236zm2.648-10.69c-1.346 0-3.107.96-4.888 2.622-1.78-1.653-3.542-2.602-4.887-2.602-.41 0-.783.093-1.106.278-1.375.793-1.683 3.264-.973 6.365C1.98 8.917 0 10.42 0 12.004c0 1.59 1.99 3.097 5.043 4.03-.704 3.113-.39 5.588.988 6.38.32.187.69.275 1.102.275 1.345 0 3.107-.96 4.888-2.624 1.78 1.654 3.542 2.603 4.887 2.603.41 0 .783-.09 1.106-.275 1.374-.792 1.683-3.263.973-6.365C22.02 15.096 24 13.59 24 12.004c0-1.59-1.99-3.097-5.043-4.032.704-3.11.39-5.587-.988-6.38-.318-.184-.688-.277-1.092-.278zm-.005 1.09v.006c.225 0 .406.044.558.127.666.382.955 1.835.73 3.704-.054.46-.142.945-.25 1.44-.96-.236-2.006-.417-3.107-.534-.66-.905-1.345-1.727-2.035-2.447 1.592-1.48 3.087-2.292 4.105-2.295zm-9.77.02c1.012 0 2.514.808 4.11 2.28-.686.72-1.37 1.537-2.02 2.442-1.107.117-2.154.298-3.113.538-.112-.49-.195-.964-.254-1.42-.23-1.868.054-3.32.714-3.707.19-.09.4-.127.563-.132zm4.882 3.05c.455.468.91.992 1.36 1.564-.44-.02-.89-.034-1.345-.034-.46 0-.915.01-1.36.034.44-.572.895-1.096 1.345-1.565zM12 8.1c.74 0 1.477.034 2.202.093.406.582.802 1.203 1.183 1.86.372.64.71 1.29 1.018 1.946-.308.655-.646 1.31-1.013 1.95-.38.66-.773 1.288-1.18 1.87-.728.063-1.466.098-2.21.098-.74 0-1.477-.035-2.202-.093-.406-.582-.802-1.204-1.183-1.86-.372-.64-.71-1.29-1.018-1.946.303-.657.646-1.313 1.013-1.954.38-.66.773-1.286 1.18-1.866.728-.064 1.466-.098 2.21-.098zm-3.635.254c-.24.377-.48.763-.704 1.16-.225.39-.435.782-.635 1.174-.265-.656-.49-1.31-.676-1.947.64-.15 1.315-.283 2.015-.386zm7.26 0c.695.103 1.365.23 2.006.387-.18.632-.405 1.282-.66 1.933-.2-.39-.41-.783-.64-1.174-.225-.392-.465-.774-.705-1.146zm3.063.675c.484.15.944.317 1.375.498 1.732.74 2.852 1.708 2.852 2.476-.005.768-1.125 1.74-2.857 2.475-.42.18-.88.342-1.355.493-.28-.958-.646-1.956-1.1-2.98.45-1.017.81-2.01 1.085-2.964zm-13.395.004c.278.96.645 1.957 1.1 2.98-.45 1.017-.812 2.01-1.086 2.964-.484-.15-.944-.318-1.37-.5-1.732-.737-2.852-1.706-2.852-2.474 0-.768 1.12-1.742 2.852-2.476.42-.18.88-.342 1.356-.494zm11.678 4.28c.265.657.49 1.312.676 1.948-.64.157-1.316.29-2.016.39.24-.375.48-.762.705-1.158.225-.39.435-.788.636-1.18zm-9.945.02c.2.392.41.783.64 1.175.23.39.465.772.705 1.143-.695-.102-1.365-.23-2.006-.386.18-.63.406-1.282.66-1.933zM17.92 16.32c.112.493.2.968.254 1.423.23 1.868-.054 3.32-.714 3.708-.147.09-.338.128-.563.128-1.012 0-2.514-.807-4.11-2.28.686-.72 1.37-1.536 2.02-2.44 1.107-.118 2.154-.3 3.113-.54zm-11.83.01c.96.234 2.006.415 3.107.532.66.905 1.345 1.727 2.035 2.446-1.595 1.483-3.092 2.295-4.11 2.295-.22-.005-.406-.05-.553-.132-.666-.38-.955-1.834-.73-3.703.054-.46.142-.944.25-1.438zm4.56.64c.44.02.89.034 1.345.034.46 0 .915-.01 1.36-.034-.44.572-.895 1.095-1.345 1.565-.455-.47-.91-.993-1.36-1.565z"/></svg>`,
        "CSS/ SCSS": `<svg viewBox="0 0 24 24" fill="#1572b6"><path d="M1.5 0h21l-1.91 21.563L11.977 24l-8.564-2.438L1.5 0zm17.09 4.413L5.41 4.41l.213 2.622 10.125.002-.255 2.716h-6.64l.24 2.573h6.182l-.366 3.523-2.91.804-2.956-.81-.188-2.11h-2.61l.29 3.855L12 19.288l5.373-1.53L18.59 4.414z"/></svg>`,
        Tailwind: `<svg viewBox="0 0 24 24" fill="#06b6d4"><path d="M12.001,4.8c-3.2,0-5.2,1.6-6,4.8c1.2-1.6,2.6-2.2,4.2-1.8c0.913,0.228,1.565,0.89,2.288,1.624 C13.666,10.618,15.027,12,18.001,12c3.2,0,5.2-1.6,6-4.8c-1.2,1.6-2.6,2.2-4.2,1.8c-0.913-0.228-1.565-0.89-2.288-1.624 C16.337,6.182,14.976,4.8,12.001,4.8z M6.001,12c-3.2,0-5.2,1.6-6,4.8c1.2-1.6,2.6-2.2,4.2-1.8c0.913,0.228,1.565,0.89,2.288,1.624 C7.666,17.818,9.027,19.2,12.001,19.2c3.2,0,5.2-1.6,6-4.8c-1.2,1.6-2.6,2.2-4.2,1.8c-0.913-0.228-1.565-0.89-2.288-1.624 C10.337,13.382,8.976,12,6.001,12z"/></svg>`,
        Bootstrap: `<svg viewBox="0 0 24 24" fill="#7952b3"><path d="M11.77 11.24H9.956V8.202h2.152c1.17 0 1.834.522 1.834 1.466 0 1.008-.773 1.572-2.174 1.572zm.324 1.206H9.957v3.348h2.231c1.459 0 2.232-.585 2.232-1.685s-.795-1.663-2.326-1.663zM24 0v24H0V0h24zM8.27 5.264h4.132c2.174 0 3.542.923 3.542 2.58 0 1.235-.734 1.946-1.836 2.234v.052c1.326.234 2.264 1.077 2.264 2.626 0 1.894-1.483 2.982-4.694 2.982H8.27V5.264z"/></svg>`,
        JavaScript: `<svg viewBox="0 0 24 24" fill="#f7df1e"><path d="M0 0h24v24H0V0zm22.034 18.276c-.175-1.095-.888-2.015-3.003-2.873-.736-.345-1.554-.585-1.797-1.14-.091-.33-.105-.51-.046-.705.15-.646.915-.84 1.515-.66.39.12.75.42.976.9 1.034-.676 1.034-.676 1.755-1.125-.27-.42-.404-.601-.586-.78-.63-.705-1.469-1.065-2.834-1.034l-.705.089c-.676.165-1.32.525-1.71 1.005-1.14 1.291-.811 3.541.569 4.471 1.365 1.02 3.361 1.244 3.616 2.205.24 1.17-.87 1.545-1.966 1.41-.811-.18-1.26-.586-1.755-1.336l-1.83 1.051c.21.48.45.689.81 1.109 1.74 1.756 6.09 1.666 6.871-1.004.029-.09.24-.705.074-1.65l.046.067zm-8.983-7.245h-2.248c0 1.938-.009 3.864-.009 5.805 0 1.232.063 2.363-.138 2.711-.33.689-1.18.601-1.566.48-.396-.196-.597-.466-.83-.855-.063-.105-.11-.196-.127-.196l-1.825 1.125c.305.63.75 1.172 1.324 1.517.855.51 2.004.675 3.207.405.783-.226 1.458-.691 1.811-1.411.51-.93.402-2.07.397-3.346.012-2.054 0-4.109 0-6.179l.004-.056z"/></svg>`,
        "Vue.js": `<svg viewBox="0 0 24 24" fill="#4fc08d"><path d="M24,1.61H14.06L12,5.16,9.94,1.61H0L12,22.39ZM12,14.08,5.16,2.23H9.59L12,6.41l2.41-4.18h4.43Z"/></svg>`,
        Typescript: `<svg viewBox="0 0 24 24" fill="#3178c6"><path d="M1.125 0C.502 0 0 .502 0 1.125v21.75C0 23.498.502 24 1.125 24h21.75c.623 0 1.125-.502 1.125-1.125V1.125C24 .502 23.498 0 22.875 0zm17.363 9.75c.612 0 1.154.037 1.627.111a6.38 6.38 0 0 1 1.306.34v2.458a3.95 3.95 0 0 0-.643-.361 5.093 5.093 0 0 0-.717-.26 5.453 5.453 0 0 0-1.426-.2c-.3 0-.573.028-.819.086a2.1 2.1 0 0 0-.623.242c-.17.104-.3.229-.393.374a.888.888 0 0 0-.14.49c0 .196.053.373.156.529.104.156.252.304.443.444s.423.276.696.41c.273.135.582.274.926.416.47.197.892.407 1.266.628.374.222.695.473.963.753.268.279.472.598.614.957.142.359.213.776.213 1.253 0 .657-.125 1.21-.373 1.656a3.033 3.033 0 0 1-1.012 1.085 4.38 4.38 0 0 1-1.487.596c-.566.12-1.163.18-1.79.18a9.916 9.916 0 0 1-1.84-.164 5.544 5.544 0 0 1-1.512-.493v-2.63a5.033 5.033 0 0 0 3.237 1.2c.333 0 .624-.03.872-.09.249-.06.456-.144.623-.25.166-.108.29-.234.373-.38a1.023 1.023 0 0 0-.074-1.089 2.12 2.12 0 0 0-.537-.5 5.597 5.597 0 0 0-.807-.444 27.72 27.72 0 0 0-1.007-.436c-.918-.383-1.602-.852-2.053-1.405-.45-.553-.676-1.222-.676-2.005 0-.614.123-1.141.369-1.582.246-.441.58-.804 1.004-1.089a4.494 4.494 0 0 1 1.47-.629 7.536 7.536 0 0 1 1.77-.201zm-15.113.188h9.563v2.166H9.506v9.646H6.789v-9.646H3.375z"/></svg>`,
        "Quasar Framework": `<svg viewBox="0 0 24 24" fill="#1976d2"><path d="M12.664 3.122L8.732 9.53H.053l2.539-3.53 1.594-.006-1.542-2.14zm5.999 8.408L14.73 17.938H6.051l2.539-3.53 1.594-.006-1.542-2.14zm-6.019-5.408L8.712 12.53H.033l2.539-3.53 1.594-.006L2.624 6.854zm6.019 8.408l-3.932 6.408H6.051l2.539-3.53 1.594-.006-1.542-2.14z"/></svg>`,
        Mysql: `<svg viewBox="0 0 24 24" fill="#4479a1"><path d="M16.405 5.501c-.115 0-.193.014-.274.033v.013h.014c.054.104.146.18.214.273.054.107.1.214.154.32l.014-.015c.094-.066.14-.172.14-.333-.04-.047-.046-.094-.08-.14-.04-.067-.126-.1-.18-.153zM5.77 18.695h-.927a50.854 50.854 0 00-.27-4.41h-.008l-1.41 4.41H2.45l-1.4-4.41h-.01a72.892 72.892 0 00-.195 4.41H.232c.1-3.047.312-5.252.312-5.252h1.504l1.26 3.64h.008l1.261-3.64h1.503s.203 2.205.311 5.252zm0-8.64c-.835 0-1.511.605-1.511 1.348s.676 1.348 1.511 1.348c.835 0 1.511-.605 1.511-1.348s-.676-1.348-1.511-1.348zm.78 5.252h-.927a50.854 50.854 0 00-.27-4.41h-.008l-1.41 4.41H3.23l-1.4-4.41h-.01a72.892 72.892 0 00-.195 4.41H1.012c.1-3.047.312-5.252.312-5.252h1.504l1.26 3.64h.008l1.261-3.64h1.503s.203 2.205.311 5.252z"/></svg>`,
        SQL: `<svg viewBox="0 0 24 24" fill="#336791"><path d="M12.09 24C5.425 24 0 18.576 0 11.91 0 5.246 5.425 0 12.09 0S24 5.246 24 11.91C24 18.576 18.576 24 12.09 24zM7.637 10.364c0-1.39 1.127-2.518 2.518-2.518s2.518 1.127 2.518 2.518-1.127 2.518-2.518 2.518-2.518-1.127-2.518-2.518zm8.128 0c0-1.39 1.127-2.518 2.518-2.518s2.518 1.127 2.518 2.518-1.127 2.518-2.518 2.518-2.518-1.127-2.518-2.518z"/></svg>`,
        Navicat: `<svg viewBox="0 0 24 24" fill="#ff6b35"><path d="M12 2L3 7l9 5 9-5-9-5zM3 17l9 5 9-5M3 12l9 5 9-5"/></svg>`,
        POSTGRESQL: `<svg viewBox="0 0 24 24" fill="#336791"><path d="M23.98 12.85c.007 5.26-1.88 6.99-3.84 8.47-.51.38-1.01.75-1.47 1.14-1.86 1.56-3.02 3.5-3.82 5.53H13.1c.55-1.45 1.34-2.8 2.37-4.01.33-.39.69-.77 1.07-1.13 1.45-1.37 3.12-2.85 3.12-7.45 0-4.37-3.55-7.92-7.92-7.92S3.82 10.23 3.82 14.6c0 4.6 1.67 6.08 3.12 7.45.38.36.74.74 1.07 1.13 1.03 1.21 1.82 2.56 2.37 4.01H8.64c-.8-2.03-1.96-3.97-3.82-5.53-.46-.39-.96-.76-1.47-1.14C1.37 19.84-.55 18.11-.55 12.85c0-6.59 5.35-11.94 11.94-11.94s11.94 5.35 11.94 11.94z"/></svg>`,
        Figma: `<svg viewBox="0 0 24 24" fill="#f24e1e"><path d="M15.852 8.981h-4.588V0h4.588c2.476 0 4.49 2.014 4.49 4.49s-2.014 4.491-4.49 4.491zM12.735 7.51h3.117c1.665 0 3.019-1.355 3.019-3.02s-1.354-3.02-3.02-3.02h-3.116v6.04zm0 1.471H8.148c-2.476 0-4.49-2.015-4.49-4.491S5.672 0 8.148 0h4.588v8.981zm-4.587-7.51c-1.666 0-3.02 1.355-3.02 3.02s1.354 3.02 3.02 3.02h3.117V1.471H8.148zm4.587 15.019H8.148c-2.476 0-4.49-2.014-4.49-4.49s2.014-4.49 4.49-4.49h4.588v8.98zM8.148 8.981c-1.666 0-3.02 1.354-3.02 3.019s1.354 3.02 3.02 3.02h3.117v-6.04H8.148z"/><path d="M8.172 24c-2.489 0-4.515-2.014-4.515-4.49s2.014-4.49 4.49-4.49h4.588v4.441c0 2.503-2.047 4.539-4.563 4.539zm-.024-7.51c-1.665 0-3.019 1.355-3.019 3.02s1.354 3.02 3.019 3.02c1.665 0 3.02-1.355 3.02-3.02v-3.02H8.148z"/><circle cx="17.666" cy="12.018" r="4.49" fill="#1abcfe"/></svg>`,
        "Adobe Illustrator": `<svg viewBox="0 0 24 24" fill="#ff9a00"><path d="M7.5 6.5l1.97 5.5H5.53L7.5 6.5zM24 .3v23.4c0 .17-.13.3-.3.3H.3c-.17 0-.3-.13-.3-.3V.3C0 .13.13 0 .3 0h23.4c.17 0 .3.13.3.3zM10.7 17l-.85-2.4H5.15L4.3 17H2.05l4.35-11.9h2.45L13.2 17h-2.5zM17.9 8.8c-.8 0-1.2.4-1.2 1.2v7h-2.2V8.6c0-1.9 1.1-3 3.1-3 .5 0 .9.1 1.3.2v2c-.3-.1-.7-.15-1-.15z"/></svg>`,
        "UI/UX Principles": `<svg viewBox="0 0 24 24" fill="#ff6b6b"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>`,
        "Caricature/ Drawing": `<svg viewBox="0 0 24 24" fill="#ffa500"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>`,
        "Git/GitHub": `<svg viewBox="0 0 24 24" fill="#f05032"><path d="M23.546 10.93L13.067.452c-.604-.603-1.582-.603-2.188 0L8.708 2.627l2.76 2.76c.645-.215 1.379-.07 1.889.441.516.515.658 1.258.438 1.9l2.658 2.66c.645-.223 1.387-.078 1.9.435.721.721.721 1.884 0 2.604-.719.719-1.881.719-2.6 0-.539-.541-.674-1.337-.404-1.996L12.86 8.955v6.525c.176.086.342.203.488.348.713.721.713 1.883 0 2.6-.719.721-1.889.721-2.609 0-.719-.719-.719-1.879 0-2.598.182-.18.387-.316.605-.406V8.835c-.217-.091-.422-.227-.605-.406-.545-.545-.676-1.342-.396-2.009L7.636 3.7.45 10.881c-.6.605-.6 1.584 0 2.189l10.48 10.477c.604.604 1.582.604 2.186 0l10.43-10.43c.605-.603.605-1.582 0-2.187"/></svg>`,
        "Responsive Design": `<svg viewBox="0 0 24 24" fill="#4285f4"><path d="M21 2H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h7l-2 3v1h8v-1l-2-3h7c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 12H3V4h18v10z"/></svg>`,
        "Performance Optimization": `<svg viewBox="0 0 24 24" fill="#ff5722"><path d="M13.5.67s.74 2.65.74 4.8c0 2.06-1.35 3.73-3.41 3.73-2.07 0-3.63-1.67-3.63-3.73l.03-.36C5.21 7.51 4 10.62 4 14c0 4.42 3.58 8 8 8s8-3.58 8-8C20 8.61 17.41 3.8 13.5.67zM11.71 19c-1.78 0-3.22-1.4-3.22-3.14 0-1.62 1.05-2.76 2.81-3.12 1.77-.36 3.6-1.21 4.62-2.58.39 1.29.68 2.37.68 4.41C16.6 17.53 14.35 19 11.71 19z"/></svg>`,
        "SEO Basics": `<svg viewBox="0 0 24 24" fill="#34a853"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>`,
        "Mobile App": `<svg viewBox="0 0 24 24" fill="#2196f3"><path d="M17 2H7c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM7 4h10v1H7V4zm0 15V7h10v12H7z"/></svg>`,
        "Software App": `<svg viewBox="0 0 24 24" fill="#9c27b0"><path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4 4H9v-2h6v2zm4-8H9V5h10v2z"/></svg>`,
        "Concept Web Creator": `<svg viewBox="0 0 24 24" fill="#ff9800"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>`,
        "Web Designer": `<svg viewBox="0 0 24 24" fill="#e91e63"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>`,
        "Quality Assurance Tester": `<svg viewBox="0 0 24 24" fill="#4caf50"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>`,
      };

      const allSkills = [
        ...skills.development.map((name) => ({
          name,
          category: "development",
          level: 85,
          icon: skillIcons[name] || "💻",
        })),
        ...skills.design.map((name) => ({
          name,
          category: "design",
          level: 80,
          icon: skillIcons[name] || "🎨",
        })),
        ...skills.other.map((name) => ({
          name,
          category: "other",
          level: 75,
          icon: skillIcons[name] || "⚡",
        })),
      ];
      return allSkills.map((skill, index) => ({
        ...skill,
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
  position: relative;
}

.skills-header {
  margin-bottom: 3rem;
  text-align: center;
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.8s ease-out;
  position: relative;
  z-index: 10;

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
  position: relative;
  z-index: 10;

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
  position: relative;
  z-index: 10;

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
  width: 3.75rem;
  height: 3.75rem;
  margin-bottom: 2rem;
  transform: scale(1);
  transition: transform 0.7s;
  display: flex;
  align-items: center;
  justify-content: center;

  :deep(svg) {
    width: 100%;
    height: 100%;
    max-width: 60px;
    max-height: 60px;
  }
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
