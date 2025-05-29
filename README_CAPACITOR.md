# 📱 Application Notifications avec Capacitor

Cette application Rails a été transformée en application mobile hybride avec CapacitorJS.

## 🚀 Installation terminée

✅ **CapacitorJS** est installé et configuré
✅ **Plateformes iOS et Android** ajoutées
✅ **Plugin Push Notifications** installé
✅ **Interface mobile-friendly** créée
✅ **Scripts de développement** disponibles

## 📱 Développement

### Scripts utiles

```bash
# Synchroniser les changements
./scripts/dev.sh sync

# Ouvrir dans Xcode (iOS)
./scripts/dev.sh ios

# Ouvrir dans Android Studio
./scripts/dev.sh android

# Démarrer le serveur Rails
./scripts/dev.sh serve
```

### Workflow de développement

1. **Développer** votre application Rails normalement
2. **Tester** dans le navigateur avec `rails server`
3. **Synchroniser** avec `./scripts/dev.sh sync`
4. **Tester** sur mobile avec `./scripts/dev.sh ios` ou `./scripts/dev.sh android`

## 🔧 Configuration

### Fichiers importants

- `capacitor.config.json` - Configuration Capacitor
- `app/javascript/application.js` - Intégration des notifications natives
- `app/views/layouts/application.html.erb` - Layout mobile-optimized
- `app/controllers/notifications_controller.rb` - Support tokens Capacitor

### Features implementées

- 📱 **Interface mobile responsive**
- 🔔 **Notifications push natives**
- 🌐 **Mode hybride web/natif**
- 📊 **Statistiques des notifications**
- 🧹 **Nettoyage automatique**

## 📋 Prérequis pour le développement mobile

### iOS

- **Xcode** (Mac uniquement)
- **Compte développeur Apple** (pour déploiement)

### Android

- **Android Studio**
- **SDK Android**

## 🎯 Prochaines étapes

1. **Configurer les certificats push** :

   - iOS : Configurer APNs dans Apple Developer Console
   - Android : Configurer FCM dans Firebase Console

2. **Personnaliser l'icône et le splash screen**

3. **Tester sur des appareils réels**

4. **Publier sur les stores**

## 🐛 Dépannage

### Si `npx cap` ne fonctionne pas

```bash
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
```

### Si les assets ne se chargent pas

```bash
bundle exec rails assets:precompile
npx cap sync
```

### Pour nettoyer et reconstruire

```bash
npx cap clean
./scripts/dev.sh sync
```
