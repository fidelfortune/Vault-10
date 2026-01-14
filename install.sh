#!/bin/bash
set -e

# === CONFIGURACIÓN ===
VAULT_IMG="/srv/vault10.img"
VAULT_NAME="vault10"
MOUNT_POINT="/mnt/vault10"
PIPGUARD_PATH="/usr/local/bin/pipguard"
VAULT_SIZE_MB=200

REAL_USER=$(logname)
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
DESKTOP_DIR="$REAL_HOME/Escritorio"

# === COMPROBACIÓN ROOT ===
if [ "$EUID" -ne 0 ]; then
  echo "❌ Ejecuta este script con sudo"
  exit 1
fi

echo "🔐 Instalando Vault-10..."

# === CARPETAS BASE ===
mkdir -p /srv
mkdir -p "$MOUNT_POINT"

# === CREAR IMAGEN CIFRADA SI NO EXISTE ===
if [ ! -f "$VAULT_IMG" ]; then
  dd if=/dev/zero of="$VAULT_IMG" bs=1M count="$VAULT_SIZE_MB" status=none
  cryptsetup luksFormat "$VAULT_IMG"
fi

# === ABRIR LUKS ===
cryptsetup open "$VAULT_IMG" "$VAULT_NAME"

# === FORMATEAR SI NO TIENE FS ===
if ! blkid /dev/mapper/"$VAULT_NAME" >/dev/null 2>&1; then
  mkfs.ext4 /dev/mapper/"$VAULT_NAME"
fi

# === MONTAR ===
mount /dev/mapper/"$VAULT_NAME" "$MOUNT_POINT"
chown -R "$REAL_USER":"$REAL_USER" "$MOUNT_POINT"

# === CREAR PIPGUARD ===
cat > "$PIPGUARD_PATH" << 'EOF'
#!/bin/bash

VAULT_IMG="/srv/vault10.img"
VAULT_NAME="vault10"
MOUNT_POINT="/mnt/vault10"
REAL_USER=$(logname)

if mountpoint -q "$MOUNT_POINT"; then
    echo "🔒 Cerrando Vault-10..."
    umount "$MOUNT_POINT" || exit 1
    cryptsetup close "$VAULT_NAME" || exit 1
    echo "✅ Vault-10 cerrada"
else
    echo "🔐 Abriendo Vault-10..."
    cryptsetup open "$VAULT_IMG" "$VAULT_NAME" || exit 1
    mount /dev/mapper/"$VAULT_NAME" "$MOUNT_POINT" || exit 1
    chown -R "$REAL_USER":"$REAL_USER" "$MOUNT_POINT"
    echo "✅ Vault-10 abierta"
fi
EOF

chmod 755 "$PIPGUARD_PATH"
chown root:root "$PIPGUARD_PATH"

# === ENLACE EN EL ESCRITORIO ===
if [ -d "$DESKTOP_DIR" ]; then
  ln -sf "$MOUNT_POINT" "$DESKTOP_DIR/Vault10"
fi

# === CERRAR VAULT TRAS INSTALAR ===
umount "$MOUNT_POINT"
cryptsetup close "$VAULT_NAME"

echo "✅ Vault-10 instalada correctamente"
echo "👉 Usa: sudo pipguard"

