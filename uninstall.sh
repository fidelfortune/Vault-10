#!/bin/bash

VAULT_IMG="/srv/vault10.img"
VAULT_NAME="vault10"
MOUNT_POINT="/mnt/vault10"
PIPGUARD="/usr/local/bin/pipguard"
DESKTOP_LINK="$HOME/Escritorio/Vault10"

echo "⛔ Desinstalando Vault-10..."

# Cerrar la bóveda si está montada
if mountpoint -q "$MOUNT_POINT"; then
    echo "🔒 Cerrando Vault-10..."
    umount "$MOUNT_POINT"
fi

# Cerrar LUKS si sigue abierto
if cryptsetup status "$VAULT_NAME" >/dev/null 2>&1; then
    cryptsetup close "$VAULT_NAME"
fi

# Eliminar enlace del escritorio
[ -L "$DESKTOP_LINK" ] && rm "$DESKTOP_LINK"

# Eliminar pipguard
[ -f "$PIPGUARD" ] && rm "$PIPGUARD"

# Eliminar punto de montaje (solo la carpeta)
[ -d "$MOUNT_POINT" ] && rmdir "$MOUNT_POINT" 2>/dev/null

# Preguntar si se elimina la imagen cifrada
echo
read -p "¿Eliminar definitivamente la bóveda (vault10.img)? [s/N]: " RESP
if [[ "$RESP" == "s" || "$RESP" == "S" ]]; then
    rm -f "$VAULT_IMG"
    echo "🗑️ Bóveda eliminada"
else
    echo "📦 Bóveda conservada en $VAULT_IMG"
fi

echo "✅ Vault-10 desinstalada correctamente"
