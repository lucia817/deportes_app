# SportLink

Aplicación Flutter para encontrar planes y compañeros de deporte.

## Ejecutar en local

Instala Flutter y Google Chrome. Desde la carpeta del proyecto ejecuta:

```powershell
flutter pub get
flutter run -d chrome
```

## Publicar en Firebase Hosting

Necesitas acceso al proyecto Firebase `sportlink-df8bf` y Firebase CLI:

```powershell
firebase login
flutter build web --release
firebase deploy --only hosting
```

La web publicada está en https://sportlink-df8bf.web.app.
