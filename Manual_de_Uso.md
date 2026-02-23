# Walkthrough: Visor Estudiantil Ultra-Rápido (Automatizado)

He completado la optimización final del sistema. Ahora la carga es 100% automática para los profesores y extremadamente fácil para la administración.

## Sistema para la Administración
Ya no tienes que subir archivos manualmente a la web. Sigue estos pasos:
1. **Organiza**: Pon las fotos en `fotos/[Nivel]`.
2. **Nombra**: El archivo debe ser `Cédula - Apellidos y Nombres.jpg` (ej: `123-Pérez Juan.jpg`).
3. **Actualiza**: Haz clic derecho en el archivo `actualizar_lista.ps1` y selecciona "Ejecutar con PowerShell". Esto generará el archivo `estudiantes.js` automáticamente.

## Sistema para los Profesores
Para el usuario final, la experiencia es instantánea:
1. Abre `index.html`.
2. Los estudiantes aparecen de inmediato sin necesidad de seleccionar carpetas ni dar permisos.
3. El buscador permite localizar por cédula o nombre al instante.

## Resumen Técnico
- **Parser**: Separa automáticamente la cédula (antes del primer guion) del nombre.
- **Carga Automática**: Usa `estudiantes.js` como base de datos local pre-generada.
- **Modo Administración**: Existe un botón oculto ("Modo Administración") por si necesitas hacer pruebas manuales sin el script.
