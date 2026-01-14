import { createApp } from "vue";
import { Quasar, Notify, Loading, Dialog } from "quasar";

// Import icon libraries
import "@quasar/extras/material-icons/material-icons.css";

// Import Quasar css
import "quasar/src/css/index.sass";

// Import custom styles
import "./assets/styles.css";

// Import root component
import App from "./App.vue";

const app = createApp(App);

app.use(Quasar, {
  plugins: {
    Notify,
    Loading,
    Dialog,
  },
  config: {
    brand: {
      primary: "#2DD4BF",
      secondary: "#38BDF8",
      dark: "#15263B",
      positive: "#21BA45",
      negative: "#C10015",
      info: "#31CCEC",
      warning: "#F2C037",
    },
  },
});

app.mount("#app");
