Vault-10

Vault-10 es un sistema de bóveda personal cifrada para Linux, diseñado para crear un espacio privado, persistente y controlado por el usuario mediante herramientas estándar del sistema.

No es una aplicación gráfica.
No es un servicio en la nube.
No depende de terceros.

Es tu bóveda, en tu máquina, bajo tu control.

🧠 ¿Qué es Vault-10?

Vault-10 crea un contenedor cifrado (LUKS) que se monta y desmonta bajo demanda.
Cuando está cerrada, los datos son inaccesibles.
Cuando está abierta, funciona como una carpeta normal del sistema.

El objetivo es simplicidad, control y transparencia, evitando soluciones complejas o propietarias.

🔐 Características principales

Contenedor cifrado mediante LUKS

Apertura y cierre manual bajo demanda

Sin servicios residentes en segundo plano

Sin telemetría

Sin dependencias gráficas

Compatible con distribuciones Linux basadas en Debian/Ubuntu

Instalación y desinstalación limpias

📂 ¿Cómo funciona?

Se crea un archivo de imagen cifrado (vault10.img)

Al abrir la bóveda, se monta como un directorio accesible

Al cerrarla, se desmonta y el cifrado queda activo

El acceso requiere siempre la contraseña definida por el usuario

🛠️ Instalación

Vault-10 se instala mediante un script de instalación incluido en este repositorio.

install.sh


El proceso:

Crea la bóveda cifrada

Configura el punto de montaje

Deja el sistema listo para su uso

🚪 Uso

Para abrir o cerrar la bóveda:

sudo pipguard


El mismo comando sirve para:

Abrir la bóveda si está cerrada

Cerrar la bóveda si está abierta

🧹 Desinstalación

Vault-10 puede eliminarse completamente del sistema usando:

uninstall.sh


Esto elimina:

Configuración

Scripts

Punto de montaje

⚠️ Atención: si decides borrar la imagen cifrada, los datos se perderán de forma irreversible.

⚠️ Advertencia

Vault-10 no es un sistema de recuperación.
Si pierdes la contraseña, los datos no se pueden recuperar.

Úsalo con responsabilidad.

📜 Licencia

Este proyecto se distribuye bajo la licencia incluida en el archivo LICENSE.


Preparar una descripción corta para la página de GitHub

Pensar en una vía futura de monetización sin romper la filosofía del proyecto
