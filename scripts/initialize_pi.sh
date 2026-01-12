# --- 4. VS CODE TUNNEL SETUP (Hardened v2) ---
ARCH=$(uname -m)
case $ARCH in
    x86_64)  PLAT="cli-linux-x64" ;;
    aarch64) PLAT="cli-linux-arm64" ;;
    *)       echo "❌ Unsupported arch: $ARCH"; exit 1 ;;
esac

echo "💻 Installing VS Code CLI ($ARCH)..."
URL="https://update.code.visualstudio.com/latest/$PLAT/stable"

curl -Lk "$URL" --output vscode_cli.tar.gz

# Check for a healthy file size (> 5MB)
FILESIZE=$(stat -c%s "vscode_cli.tar.gz")
if [ "$FILESIZE" -lt 5000000 ]; then
    echo "❌ Error: VS Code download failed (Size: $FILESIZE bytes)."
    exit 1
fi

tar -xf vscode_cli.tar.gz
sudo mv code /usr/local/bin/
rm vscode_cli.tar.gz

# Required for background persistence
sudo loginctl enable-linger $USER

echo "🔧 Registering Tunnel Service..."
# Simplified command: Provider is handled during the 'code tunnel user login' step
code tunnel service install --accept-server-license-terms --name "$(hostname)"