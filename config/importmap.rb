# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Capacitor
pin "@capacitor/core", to: "https://cdn.jsdelivr.net/npm/@capacitor/core@latest/dist/index.esm.js"
pin "@capacitor/push-notifications", to: "https://cdn.jsdelivr.net/npm/@capacitor/push-notifications@latest/dist/index.esm.js"
