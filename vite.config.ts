// vite.config.js
import { fileURLToPath } from 'url';
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    rollupOptions: {
      input: [
        fileURLToPath(new URL('./.config/waybar/style.css', import.meta.url))
      ],
    },
  },
});
