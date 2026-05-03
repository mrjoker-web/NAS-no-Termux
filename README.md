<div align="center">

```
████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗    ███╗   ██╗ █████╗ ███████╗
   ██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝    ████╗  ██║██╔══██╗██╔════╝
   ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝     ██╔██╗ ██║███████║███████╗
   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗     ██║╚██╗██║██╔══██║╚════██║
   ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗    ██║ ╚████║██║  ██║███████║
   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
```

### `// Turn your Android into a NAS — Powered by FileBrowser`

**Termux · FileBrowser · Android · ARM64 · Self-hosted**

[![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)](.)
[![Android](https://img.shields.io/badge/Termux-3DDC84?style=for-the-badge&logo=android&logoColor=white)](.)
[![FileBrowser](https://img.shields.io/badge/FileBrowser-2.31.2-0085C7?style=for-the-badge)](https://filebrowser.org)
[![Architecture](https://img.shields.io/badge/arch-ARM64%20%7C%20ARMv7-f0b800?style=for-the-badge)](.)
[![License](https://img.shields.io/badge/license-MIT-52c98b?style=for-the-badge)](.)

</div>

---

## `> about`

**Termux NAS** transforma o teu dispositivo Android num servidor de ficheiros NAS caseiro — com interface web moderna, acesso em rede local e autenticação segura.

Um único script. Sem root. Sem configurações complicadas.

```bash
bash setup.sh
# → FileBrowser instalado e configurado
# → Acesso em http://<IP>:8080
# → O teu Android é agora um NAS
```

---

## `> what is it`

```
┌────────────────────────────────────────────────────────────┐
│                    TERMUX NAS                              │
│                                                            │
│   Android + Termux                                         │
│        │                                                   │
│        ▼                                                   │
│   FileBrowser (porta 8080)                                 │
│        │                                                   │
│        ├── PC  →  http://192.168.1.X:8080                  │
│        ├── Telemóvel  →  http://192.168.1.X:8080           │
│        └── Qualquer dispositivo na rede local              │
│                                                            │
│   Acesso a:  /sdcard  (fotos, docs, músicas, tudo)         │
└────────────────────────────────────────────────────────────┘
```

---

## `> features`

```
✅ Instalação automática do FileBrowser v2.31.2
✅ Detecção automática de arquitectura (ARM64 / ARMv7)
✅ Configuração do utilizador admin com password segura
✅ Acesso a todo o storage do Android (/sdcard)
✅ Interface web moderna — upload, download, partilha
✅ Script de arranque rápido (start-nas.sh)
✅ Sem root necessário
✅ Funciona em qualquer rede Wi-Fi local
```

---

## `> requirements`

```
✅ Android 7.0+
✅ Termux (F-Droid — versão recomendada)
✅ Wi-Fi activo
✅ ~50MB de espaço livre
```

> ⚠️ Instala o Termux pelo **F-Droid** — a versão da Play Store está desactualizada.

---

## `> install`

```bash
# 1. Clona o repositório
git clone https://github.com/gnu23-sys/termux-nas.git
cd termux-nas

# 2. Dá permissão e corre
chmod +x setup.sh
bash setup.sh
```

O script faz tudo automaticamente:

```
[1/5] Actualiza pacotes Termux
[2/5] Instala FileBrowser (binário para a tua arch)
[3/5] Configura acesso ao storage (/sdcard)
[4/5] Cria utilizador admin com a tua password
[5/5] Cria script de arranque rápido
```

---

## `> usage`

### Iniciar o NAS

```bash
bash ~/start-nas.sh
```

```
Starting Termux NAS...

  Local:    http://127.0.0.1:8080
  Network:  http://192.168.1.XXX:8080
```

### Aceder no browser

```
No telemóvel  →  http://127.0.0.1:8080
Em qualquer dispositivo na rede  →  http://192.168.1.XXX:8080
```

### Parar o NAS

```bash
# No terminal onde está a correr:
Ctrl + C
```

---

## `> filebrowser interface`

O FileBrowser oferece uma interface web completa:

```
┌──────────────────────────────────────────────────────────┐
│  📁 /sdcard                                              │
├──────────────────────────────────────────────────────────┤
│  📁 DCIM          📁 Download       📁 Documents         │
│  📁 Music         📁 Pictures       📁 WhatsApp          │
│                                                          │
│  [↑ Upload]  [📋 Copy]  [✂ Move]  [🗑 Delete]  [⬇ DL]  │
└──────────────────────────────────────────────────────────┘
```

**Funcionalidades do FileBrowser:**
- Upload e download de ficheiros
- Criação e edição de ficheiros de texto
- Partilha de ficheiros por link
- Gestão de utilizadores
- Visualização de imagens e vídeos
- Interface responsiva — funciona no telemóvel

---

## `> security`

```
✅ Autenticação obrigatória (username + password)
✅ Password mínimo de 12 caracteres (enforced pelo script)
✅ Bind em 0.0.0.0 — apenas rede local (sem exposição WAN)
⚠  Não expor a porta 8080 para a internet sem HTTPS
⚠  Usar em redes Wi-Fi de confiança
```

**Para maior segurança:**

```bash
# Mudar a porta default
filebrowser -d ~/fb.db config set --port 9999

# Restringir ao IP local apenas
filebrowser -d ~/fb.db config set --address 127.0.0.1
```

---

## `> architecture support`

| Dispositivo | Arch | Binário |
|------------|------|---------|
| A maioria dos Android modernos | aarch64 | linux-arm64 |
| Android mais antigos (32-bit) | armv7l | linux-armv7 |
| Detecção automática | ✅ | Script detecta e descarrega correcto |

---

## `> troubleshooting`

```bash
# FileBrowser não inicia — verificar se já está a correr
pkill filebrowser

# Porta 8080 em uso — mudar porta
filebrowser -d ~/fb.db config set --port 8181
bash ~/start-nas.sh

# Sem acesso ao /sdcard
termux-setup-storage
# → Aceita a permissão no pop-up do Android

# Ver IP da rede
ip addr show wlan0 | grep 'inet '

# Reset completo
rm ~/fb.db
bash setup.sh
```

---

## `> roadmap`

```
✅ Instalação automática FileBrowser
✅ Detecção de arquitectura ARM64 / ARMv7
✅ Configuração de utilizador admin
✅ Script de arranque rápido
✅ Acesso a /sdcard completo
🔄 HTTPS com certificado self-signed
🔄 Auto-start com Termux:Boot
🔄 Suporte a múltiplos utilizadores
🔄 Backup automático para pasta definida
🔄 Notificação Termux quando o NAS inicia
```

---

## `> auto-start (opcional)`

Para o NAS iniciar automaticamente com o Termux:

```bash
# Instala Termux:Boot (F-Droid)
# Depois:
mkdir -p ~/.termux/boot
cat > ~/.termux/boot/start-nas.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
termux-wake-lock
bash ~/start-nas.sh
EOF
chmod +x ~/.termux/boot/start-nas.sh
```

---

## `> author`

<div align="center">

Feito por **[mrjoker-web](https://github.com/mrjoker-web/Readme)**

[![GitHub](https://img.shields.io/badge/GitHub-gnu23--sys-181717?style=for-the-badge&logo=github)](https://github.com/mrjoker-web/Readme)

*Se achares útil, deixa uma ⭐ — ajuda o projeto a crescer!*

</div>

---

## `> license`

```
MIT License — usa, modifica e distribui à vontade.
Dá crédito se achares que merece. ⭐
```


## `> screenshot`

<div align="center">

![Termux NAS — FileBrowser Interface](https://i.imgur.com/XO4oYqk.jpeg)

*FileBrowser v2.31.2 — Interface web acessível em toda a rede local*

</div>
