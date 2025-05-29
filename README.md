# 📱 Application de Notifications

`Test app` Une application Rails transformée en application mobile hybride avec CapacitorJS pour gérer les notifications push natives.

## 🚀 Démarrage rapide

### Prérequis

- **Ruby** (version recommandée : 3.x+)
- **Rails** 7+
- **Node.js** 20+
- **npm** ou **pnpm**

### Installation

1. **Cloner le repository**

   ```bash
   git clone git@github.com:Alexskq/Notification_Test_app.git
   cd notifications
   ```

2. **Installer les dépendances Ruby**

   ```bash
   bundle install
   ```

3. **Installer les dépendances JavaScript**

   ```bash
   npm install
   ```

4. **Initialiser la base de données**

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Démarrer l'application**
   ```bash
   dev
   ```

## 📱 Développement Mobile

### Scripts de développement

```bash
# Synchroniser les changements avec les plateformes mobiles
./scripts/dev.sh sync

# Ouvrir dans Xcode (iOS)
./scripts/dev.sh ios

# Ouvrir dans Android Studio (Android)
./scripts/dev.sh android

# Démarrer le serveur Rails
./scripts/dev.sh serve
```

### Workflow recommandé

1. **Développer** votre application Rails normalement
2. **Tester** dans le navigateur avec `dev`
3. **Synchroniser** avec `./scripts/dev.sh sync`
4. **Tester** sur mobile avec `./scripts/dev.sh ios` ou `./scripts/dev.sh android`

## 🔧 Configuration

### Développement mobile

#### iOS

- **Xcode** (Mac uniquement)
- **Compte développeur Apple** (pour déploiement)

#### Android

- **Android Studio**
- **SDK Android**

### Variables d'environnement

Créer un fichier `.env` avec :

```
# Configuration de base
RAILS_ENV=development

# Configuration des notifications push (optionnel)
# IOS_APNS_KEY_ID=your_key_id
# ANDROID_FCM_SERVER_KEY=your_server_key
```

## 🔔 Fonctionnalités

- **Interface mobile responsive** - Optimisée pour tous les écrans
- **Notifications push natives** - Support iOS et Android
- **Mode hybride** - Combine web et natif
- **Gestion des tokens** - Système automatique de tokens de notification
- **Statistiques** - Suivi des notifications envoyées
- **Nettoyage automatique** - Suppression des anciennes notifications

## 📋 Structure du projet

```
app/
├── controllers/
│   └── notifications_controller.rb  # API et gestion des notifications
├── javascript/
│   └── application.js               # Intégration Capacitor
├── models/
│   └── notification.rb             # Modèle de notification
└── views/
    ├── layouts/
    │   └── application.html.erb     # Layout mobile-optimized
    └── notifications/
        └── index.html.erb           # Interface principale

capacitor.config.json                # Configuration Capacitor
scripts/
└── dev.sh                          # Scripts de développement
```

## 🧪 Tests

```bash
# Lancer tous les tests
rails test

# Tests spécifiques
rails test test/controllers/notifications_controller_test.rb
```

## 🐛 Dépannage

### Problèmes courants

**Si `npx cap` ne fonctionne pas :**

```bash
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
```

**Si les assets ne se chargent pas :**

```bash
bundle exec rails assets:precompile
npx cap sync
```

**Pour nettoyer et reconstruire :**

```bash
npx cap clean
./scripts/dev.sh sync
```

## 🚀 Déploiement

### Web

```bash
bundle exec rails assets:precompile RAILS_ENV=production
rails server -e production
```

### Mobile

1. Configurer les certificats push (APNs pour iOS, FCM pour Android)
2. Générer les builds de production avec Capacitor
3. Publier sur App Store / Google Play

## 📚 Documentation supplémentaire

Pour plus de détails sur la configuration mobile, consultez `README_CAPACITOR.md`.

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push sur la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence [MIT](LICENSE).
