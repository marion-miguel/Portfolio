const { configure } = require("quasar/wrappers");

module.exports = configure(function (/* ctx */) {
  return {
    boot: [],

    css: ["app.scss"],

    extras: ["roboto-font", "material-icons"],

    build: {
      target: {
        browser: ["es2019", "edge88", "firefox78", "chrome87", "safari13.1"],
        node: "node20",
      },

      vueRouterMode: "hash",

      vitePlugins: [
        // [
        //   "@intlify/vite-plugin-vue-i18n",
        //   {
        //     include: [],
        //   },
        // ],
      ],

      env: {
        API_KEY: process.env.GEMINI_API_KEY || "",
      },
    },

    devServer: {
      open: true,
      port: 9000,
    },

    framework: {
      config: {},

      plugins: ["Notify", "Loading", "Dialog"],
    },

    animations: "all",

    ssr: {
      pwa: false,
      prodPort: 9000,
      middlewares: ["render"],
    },

    pwa: {
      workboxMode: "GenerateSW",
      injectPwaMetaTags: true,
      swFilename: "sw.js",
      manifestFilename: "manifest.json",
      useCredentialsForManifestTag: false,
    },

    cordova: {},
    capacitor: {
      hideSplashscreen: true,
    },

    electron: {
      inspectPort: 5858,
      bundler: "packager",
      packager: {},
      builder: {
        appId: "src-portfolio",
      },
    },

    bex: {
      contentScripts: ["my-content-script"],
    },
  };
});
