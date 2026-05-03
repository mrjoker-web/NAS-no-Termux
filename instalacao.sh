#!/data/data/com.termux/files/usr/bin/bash

# ============================================
#   Termux NAS Setup Script
#   Powered by FileBrowser
#   https://github.com/mrjoker-web
# ============================================

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}"
echo "  ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗    ███╗   ██╗ █████╗ ███████╗"
echo "     ██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝    ████╗  ██║██╔══██╗██╔════╝"
echo "     ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝     ██╔██╗ ██║███████║███████╗"
echo "     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗     ██║╚██╗██║██╔══██║╚════██║"
echo "     ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗    ██║ ╚████║██║  ██║███████║"
echo "     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝"
echo -e "${NC}"
echo -e "${CYAN}  Termux NAS — Turn your Android into a file server${NC}"
echo -e "${CYAN}  https://github.com/mrjoker-web/${NC}"
echo ""

# Check Termux
if [ ! -d "/data/data/com.termux" ]; then
  echo -e "${RED}[ERROR] This script must run inside Termux.${NC}"
  exit 1
fi

echo -e "${YELLOW}[1/5] Updating packages...${NC}"
pkg update -y && pkg upgrade -y

echo -e "${YELLOW}[2/5] Installing FileBrowser...${NC}"
pkg install wget -y

# Detect arch
ARCH=$(uname -m)
if [[ "$ARCH" == "aarch64" ]]; then
  FB_ARCH="arm64"
elif [[ "$ARCH" == "armv7l" ]]; then
  FB_ARCH="armv7"
else
  FB_ARCH="arm64"
fi

echo -e "${CYAN}    Detected architecture: ${ARCH} → downloading ${FB_ARCH} binary${NC}"

FB_VERSION="2.31.2"
FB_URL="https://github.com/filebrowser/filebrowser/releases/download/v${FB_VERSION}/linux-${FB_ARCH}-filebrowser.tar.gz"

wget -q --show-progress -O /tmp/filebrowser.tar.gz "$FB_URL"
tar -xzf /tmp/filebrowser.tar.gz -C $PREFIX/bin filebrowser
chmod +x $PREFIX/bin/filebrowser
rm /tmp/filebrowser.tar.gz

echo -e "${GREEN}    FileBrowser installed!${NC}"

echo -e "${YELLOW}[3/5] Setting up storage access...${NC}"
termux-setup-storage
sleep 2

echo -e "${YELLOW}[4/5] Configuring FileBrowser...${NC}"
DB_PATH="$HOME/fb.db"

# Init config
filebrowser -d "$DB_PATH" config init
filebrowser -d "$DB_PATH" config set --address 0.0.0.0
filebrowser -d "$DB_PATH" config set --port 8080
filebrowser -d "$DB_PATH" config set --root /sdcard

echo ""
echo -e "${CYAN}  Set your admin credentials:${NC}"
read -p "  Username [admin]: " FB_USER
FB_USER=${FB_USER:-admin}

while true; do
  read -s -p "  Password (min 12 chars): " FB_PASS
  echo ""
  if [ ${#FB_PASS} -ge 12 ]; then
    break
  fi
  echo -e "${RED}  Password too short! Minimum 12 characters.${NC}"
done

filebrowser -d "$DB_PATH" users add "$FB_USER" "$FB_PASS" --perm.admin
echo -e "${GREEN}    User created!${NC}"

echo -e "${YELLOW}[5/5] Creating start script...${NC}"
cat > "$HOME/start-nas.sh" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "Starting Termux NAS..."
IP=$(ip addr show wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
echo ""
echo "  Local:   http://127.0.0.1:8080"
if [ -n "$IP" ]; then
  echo "  Network: http://${IP}:8080"
fi
echo ""
filebrowser -d ~/fb.db
EOF
chmod +x "$HOME/start-nas.sh"

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        ✅  SETUP COMPLETE!               ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""

IP=$(ip addr show wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
echo -e "  ${CYAN}Access locally:${NC}  http://127.0.0.1:8080"
if [ -n "$IP" ]; then
  echo -e "  ${CYAN}Access on network:${NC} http://${IP}:8080"
fi
echo ""
echo -e "  To start the NAS anytime, run:"
echo -e "  ${YELLOW}bash ~/start-nas.sh${NC}"
echo ""
