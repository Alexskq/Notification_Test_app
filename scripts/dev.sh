#!/bin/bash

# Script de développement pour Capacitor
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

case "$1" in
    "sync")
        echo "🔄 Synchronisation des assets..."
        bundle exec rails assets:precompile
        npx cap sync
        ;;
    "ios")
        echo "📱 Ouverture d'iOS..."
        bundle exec rails assets:precompile
        npx cap sync
        npx cap open ios
        ;;
    "android")
        echo "🤖 Ouverture d'Android..."
        bundle exec rails assets:precompile
        npx cap sync
        npx cap open android
        ;;
    "serve")
        echo "🌐 Démarrage du serveur de développement..."
        bundle exec rails server -p 3000
        ;;
    *)
        echo "Usage: $0 {sync|ios|android|serve}"
        echo "  sync    - Synchronise les assets avec Capacitor"
        echo "  ios     - Ouvre le projet iOS dans Xcode"
        echo "  android - Ouvre le projet Android dans Android Studio"
        echo "  serve   - Démarre le serveur Rails"
        exit 1
        ;;
esac 