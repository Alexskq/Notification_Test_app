// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// Intégration Capacitor
import { Capacitor } from "@capacitor/core";
import { PushNotifications } from "@capacitor/push-notifications";

// Fonction pour initialiser Capacitor
function initCapacitor() {
  if (Capacitor.isNativePlatform()) {
    console.log("Application native détectée");
    initNativePushNotifications();
  } else {
    console.log("Application web détectée");
    // Garde la logique web push existante
  }
}

// Initialisation des notifications push natives
async function initNativePushNotifications() {
  try {
    // Demander la permission
    let permStatus = await PushNotifications.checkPermissions();

    if (permStatus.receive === "prompt") {
      permStatus = await PushNotifications.requestPermissions();
    }

    if (permStatus.receive !== "granted") {
      throw new Error("Permissions de notification refusées");
    }

    // Enregistrer les listeners
    PushNotifications.addListener("registration", (token) => {
      console.log("Token de notification reçu: ", token.value);
      // Envoyer le token au serveur Rails
      sendTokenToServer(token.value);
    });

    PushNotifications.addListener("registrationError", (error) => {
      console.error("Erreur d'enregistrement: ", error);
    });

    PushNotifications.addListener(
      "pushNotificationReceived",
      (notification) => {
        console.log("Notification reçue: ", notification);
        // Afficher une alerte ou mettre à jour l'UI
        showNotificationAlert(notification);
      }
    );

    PushNotifications.addListener(
      "pushNotificationActionPerformed",
      (notification) => {
        console.log("Action sur notification: ", notification);
      }
    );

    // Enregistrer pour les notifications
    await PushNotifications.register();
  } catch (error) {
    console.error("Erreur lors de l'initialisation des notifications:", error);
  }
}

// Envoyer le token au serveur Rails
async function sendTokenToServer(token) {
  try {
    const response = await fetch("/notifications", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          ?.getAttribute("content"),
      },
      body: JSON.stringify({
        endpoint: `capacitor://${token}`,
        keys: {
          auth: "capacitor-auth-key",
          p256dh: "capacitor-p256dh-key",
        },
        token: token,
      }),
    });

    if (response.ok) {
      console.log("Token envoyé avec succès au serveur");
    }
  } catch (error) {
    console.error("Erreur lors de l'envoi du token:", error);
  }
}

// Afficher une alerte pour les notifications reçues
function showNotificationAlert(notification) {
  if (Capacitor.isNativePlatform()) {
    // Sur mobile, on peut afficher une alerte native
    const message = `Nouvelle notification: ${notification.body}`;
    if (window.alert) {
      window.alert(message);
    }
  }
}

// Initialiser quand le DOM est prêt
document.addEventListener("DOMContentLoaded", () => {
  initCapacitor();
});
