#!/bin/bash

# Konfiguration
GH_BIN="$HOME/bin/gh"
REPO_NAME="tablet-handbuch"
DIR="$HOME/Tablet-Handbuch"

echo "------------------------------------------------"
echo "🚀 Tablet-Handbuch GitHub-Installer"
echo "------------------------------------------------"

cd "$DIR" || exit

# 1. GitHub Login prüfen
echo "🔑 Prüfe GitHub-Anmeldung..."
if ! "$GH_BIN" auth status &>/dev/null; then
    echo "Bitte melde dich kurz bei GitHub an:"
    "$GH_BIN" auth login --web -h github.com
fi

# 2. Git initialisieren falls nötig
if [ ! -d ".git" ]; then
    git init
    git branch -M main
fi

git add .
git commit -m "Automatisch erstellt: Tablet-Handbuch PWA" 2>/dev/null

# 3. Repository auf GitHub erstellen
echo "📦 Erstelle Repository auf GitHub..."
if "$GH_BIN" repo view "$REPO_NAME" &>/dev/null; then
    echo "✅ Repository existiert bereits."
else
    "$GH_BIN" repo create "$REPO_NAME" --public --source=. --remote=origin --push
    echo "✅ Repository erstellt und hochgeladen."
fi

# 4. GitHub Pages aktivieren
echo "🌐 Aktiviere GitHub Pages..."
"$GH_BIN" repo edit "$REPO_NAME" --enable-pages --pages-branch main

# 5. Abschluss
USER=$("$GH_BIN" api user -q .login)
URL="https://$USER.github.io/$REPO_NAME/"

echo "------------------------------------------------"
echo "🎉 FERTIG!"
echo "------------------------------------------------"
echo "Die Anleitung deiner Mutter ist nun erreichbar unter:"
echo ""
echo "🔗 $URL"
echo ""
echo "Anleitung für das Tablet:"
echo "1. Öffne den Link oben in Chrome auf dem Tablet."
echo "2. Tippe auf das Menü (3 Punkte) -> 'App installieren'."
echo "------------------------------------------------"
