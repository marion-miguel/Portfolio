<template>
  <section id="contact" class="contact-section">
    <div class="contact-container">
      <div class="contact-info" :class="{ visible: infoVisible }">
        <h4 class="section-subtitle">Engagement</h4>
        <h2 class="section-title">
          Let's Craft <br />
          Something.
        </h2>
        <p class="contact-description">
          Currently accepting high-impact projects for 2025. Whether it's a new
          venture or a bold redesign, let's talk.
        </p>

        <div class="contact-details">
          <a href="mailto:hello@ether.dev" class="email-link">
            hello@ether.dev
            <span class="link-underline"></span>
          </a>

          <div class="social-links">
            <a
              v-for="link in socialLinks"
              :key="link.name"
              :href="link.href"
              target="_blank"
              rel="noopener noreferrer"
              class="social-link"
              :aria-label="link.name"
            >
              <span class="social-icon" v-html="link.icon"></span>
              <span class="social-name">
                {{ link.name }}
                <span class="social-underline"></span>
              </span>
            </a>
          </div>
        </div>
      </div>

      <div class="contact-form-wrapper" :class="{ visible: formVisible }">
        <transition name="fade" mode="out-in">
          <form
            v-if="!isSubmitted"
            @submit.prevent="handleSubmit"
            class="contact-form"
          >
            <div class="form-field">
              <label class="form-label">Full Name</label>
              <input
                v-model="formData.name"
                type="text"
                required
                placeholder="Julian Ether"
                class="form-input"
              />
            </div>

            <div class="form-field">
              <label class="form-label">Email Address</label>
              <input
                v-model="formData.email"
                type="email"
                required
                placeholder="hello@example.com"
                class="form-input"
              />
            </div>

            <div class="form-field">
              <label class="form-label">Message</label>
              <textarea
                v-model="formData.message"
                rows="4"
                required
                placeholder="Briefly describe your vision..."
                class="form-input form-textarea"
              ></textarea>
            </div>

            <MagneticButton :strength="15" class="submit-wrapper">
              <button type="submit" class="submit-button">Send Inquiry</button>
            </MagneticButton>
          </form>

          <div v-else class="success-message">
            <div class="success-icon">
              <span>✓</span>
            </div>
            <h3 class="success-title">Message Sent!</h3>
            <p class="success-text">
              Thank you for reaching out, Julian will get back to you shortly.
            </p>
          </div>
        </transition>
      </div>
    </div>
  </section>
</template>

<script>
import { ref, onMounted, onUnmounted } from "vue";
import MagneticButton from "src/components/MagneticButton.vue";

export default {
  name: "ContactSec",
  components: {
    MagneticButton,
  },
  setup() {
    const isSubmitted = ref(false);
    const formData = ref({ name: "", email: "", message: "" });
    const infoVisible = ref(false);
    const formVisible = ref(false);

    const socialLinks = [
      {
        name: "LinkedIn",
        href: "https://www.linkedin.com",
        icon: '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/></svg>',
      },
      {
        name: "Indeed",
        href: "https://www.indeed.com",
        icon: '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M2.397 4.574C4.498 4.406 18.023 4.406 20.125 4.574c1.847.151 2.213 1.259 2.25 7.426-.037 6.167-.403 7.275-2.25 7.426-2.102.168-15.627.168-17.728 0-1.847-.151-2.213-1.259-2.25-7.426.037-6.167.403-7.275 2.25-7.426zM7.022 15.516V8.484L13.118 12l-6.096 3.516z"/></svg>',
      },
      {
        name: "JobStreet",
        href: "https://www.jobstreet.com",
        icon: '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" fill="none"/><path d="M8 12h8M12 8v8" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>',
      },
      {
        name: "GitHub",
        href: "https://www.github.com",
        icon: '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.43.372.823 1.102.823 2.222 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/></svg>',
      },
    ];

    const handleSubmit = () => {
      if (
        formData.value.name &&
        formData.value.email &&
        formData.value.message
      ) {
        isSubmitted.value = true;
        setTimeout(() => {
          isSubmitted.value = false;
          formData.value = { name: "", email: "", message: "" };
        }, 5000);
      }
    };

    const handleScroll = () => {
      const section = document.getElementById("contact");
      if (!section) return;

      const rect = section.getBoundingClientRect();
      const isInView = rect.top < window.innerHeight * 0.7;

      if (isInView) {
        infoVisible.value = true;
        setTimeout(() => {
          formVisible.value = true;
        }, 200);
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
      isSubmitted,
      formData,
      socialLinks,
      handleSubmit,
      infoVisible,
      formVisible,
    };
  },
};
</script>

<style scoped lang="scss">
.contact-section {
  padding: 6rem 1.5rem;
  background-color: rgba(255, 255, 255, 0.05);

  .dark-mode & {
    background-color: rgba(25, 32, 44, 0.3);
  }

  @media (min-width: 768px) {
    padding: 6rem 3rem;
  }
}

.contact-container {
  max-width: 1600px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr;
  gap: 5rem;

  @media (min-width: 1024px) {
    grid-template-columns: 1fr 1fr;
  }
}

.contact-info {
  opacity: 0;
  transform: translateX(-50px);
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
  font-style: italic;
  margin-bottom: 2rem;

  @media (min-width: 768px) {
    font-size: 4.5rem;
  }
}

.contact-description {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 3rem;
  max-width: 28rem;

  .dark-mode & {
    color: rgba(250, 250, 250, 0.6);
  }
}

.contact-details {
  display: flex;
  flex-direction: column;
  gap: 3rem;
}

.email-link {
  position: relative;
  font-size: 1.5rem;
  font-family: "Playfair Display", serif;
  font-style: italic;
  text-decoration: none;
  color: inherit;
  display: inline-block;
  transition: color 0.3s;

  @media (min-width: 768px) {
    font-size: 2.5rem;
  }

  &:hover {
    color: #2dd4bf;

    .link-underline {
      width: 100%;
    }
  }
}

.link-underline {
  display: block;
  height: 2px;
  width: 0;
  background-color: #2dd4bf;
  transition: width 0.5s;
}

.social-links {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;

  @media (min-width: 768px) {
    gap: 2.5rem;
  }
}

.social-link {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  font-size: 0.625rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  text-decoration: none;
  color: inherit;
  opacity: 0.4;
  transition: all 0.3s;

  &:hover {
    opacity: 1;
    color: #2dd4bf;

    .social-icon {
      transform: scale(1.25) rotate(-6deg);
    }

    .social-underline {
      width: 100%;
    }
  }
}

.social-icon {
  transition: transform 0.5s;

  :deep(svg) {
    width: 20px;
    height: 20px;
  }
}

.social-name {
  position: relative;
}

.social-underline {
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 0;
  height: 1px;
  background-color: #2dd4bf;
  transition: width 0.5s;
}

.contact-form-wrapper {
  background-color: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(21, 38, 59, 0.1);
  padding: 2.5rem;
  border-radius: 3rem;
  backdrop-filter: blur(20px);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  opacity: 0;
  transform: translateX(50px) scale(0.95);
  transition: all 0.8s ease-out;
  transition-delay: 0.2s;

  .dark-mode & {
    background-color: rgba(25, 32, 44, 1);
    border-color: rgba(250, 250, 250, 0.05);
  }

  @media (min-width: 768px) {
    padding: 4rem;
  }

  &.visible {
    opacity: 1;
    transform: translateX(0) scale(1);
  }
}

.contact-form {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.form-field {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  opacity: 0;
  transform: translateY(10px);
  animation: fadeInUp 0.6s ease-out forwards;

  &:nth-child(1) {
    animation-delay: 0.4s;
  }
  &:nth-child(2) {
    animation-delay: 0.5s;
  }
  &:nth-child(3) {
    animation-delay: 0.6s;
  }
}

.form-label {
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  opacity: 0.5;
}

.form-input {
  width: 100%;
  background-color: transparent;
  border: none;
  border-bottom: 1px solid rgba(21, 38, 59, 0.1);
  padding: 1rem 0;
  font-size: 1.125rem;
  outline: none;
  transition: border-color 0.3s;
  color: inherit;

  .dark-mode & {
    border-bottom-color: rgba(250, 250, 250, 0.1);
  }

  &:focus {
    border-bottom-color: #2dd4bf;
  }

  &::placeholder {
    color: rgba(21, 38, 59, 0.3);

    .dark-mode & {
      color: rgba(250, 250, 250, 0.3);
    }
  }
}

.form-textarea {
  resize: none;
}

.submit-wrapper {
  width: 100%;
}

.submit-button {
  width: 100%;
  padding: 1.5rem;
  background-color: #15263b;
  color: #fafafa;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  border-radius: 1rem;
  border: none;
  cursor: none;
  transition: all 0.3s;
  box-shadow: 0 10px 25px -5px rgba(45, 212, 191, 0.2);

  .dark-mode & {
    background-color: #2dd4bf;
    color: #15263b;
  }

  &:hover {
    background-color: #2dd4bf;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 15px 30px -5px rgba(45, 212, 191, 0.4);

    .dark-mode & {
      background-color: white;
      color: #2dd4bf;
    }
  }

  &:active {
    transform: scale(0.95);
  }
}

.success-message {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 5rem 0;
  text-align: center;
}

.success-icon {
  width: 80px;
  height: 80px;
  background-color: rgba(45, 212, 191, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.5rem;
  font-size: 2.5rem;
  color: #2dd4bf;
}

.success-title {
  font-size: 2rem;
  font-family: "Playfair Display", serif;
  font-weight: 700;
  margin-bottom: 1rem;
}

.success-text {
  .dark-mode & {
    color: rgba(250, 250, 250, 0.6);
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
