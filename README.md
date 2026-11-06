# MyApp – Ejemplos para principiantes: Audio/Video y Eventos táctiles

App de ejemplo hecha con **SwiftUI** para aprender dos temas básicos del desarrollo en iOS:

1. **Audio y Video**: cómo reproducir multimedia con `AVPlayer` y `VideoPlayer`.
2. **Eventos táctiles**: cómo responder a toques y gestos (tap, long press, drag, zoom, rotación).

La app tiene dos pestañas en la parte inferior, una para cada ejemplo.

---

## 📁 Estructura del proyecto

| Archivo | Qué contiene |
| --- | --- |
| `MyApp/MyApp.swift` | Punto de entrada de la app (`@main`). Abre `ContentView`. |
| `MyApp/ContentView.swift` | Pantalla principal con un `TabView` de dos pestañas. |
| `MyApp/AudioVideoView.swift` | Ejemplo de reproducción de video y audio. |
| `MyApp/TouchEventsView.swift` | Ejemplo de gestos táctiles sobre un círculo. |

---

## 🎬 Ejemplo 1: Audio y Video (`AudioVideoView.swift`)

### Conceptos

| Concepto | Para qué sirve |
| --- | --- |
| `import AVKit` | Framework de Apple para reproducir multimedia. |
| `AVPlayer` | El "motor" que reproduce audio o video desde una URL. |
| `VideoPlayer(player:)` | Vista de SwiftUI que muestra el video con controles. |
| `play()` / `pause()` | Inician o detienen la reproducción. |
| `seek(to: .zero)` | Vuelve al inicio del archivo. |
| `volume` | Volumen del reproductor, de `0.0` a `1.0`. |

### Qué hace la pantalla
- Muestra un **video** de ejemplo de Apple con botones propios para reproducir, pausar y reiniciar.
- Reproduce una **canción MP3** con un botón que alterna entre reproducir y pausar.
- Tiene un **slider** para cambiar el volumen del audio.
- Al salir de la pantalla (`onDisappear`) detiene todo.

> 💡 **Usar archivos propios:** arrastra un `.mp3` o `.mp4` al proyecto (marca "Copy items if needed") y crea el reproductor así:
> ```swift
> if let url = Bundle.main.url(forResource: "cancion", withExtension: "mp3") {
>     let player = AVPlayer(url: url)
> }
> ```

---

## 👆 Ejemplo 2: Eventos táctiles (`TouchEventsView.swift`)

Todos los gestos se aplican a un **círculo** y un texto arriba indica qué gesto se detectó.

| Gesto | Modificador / tipo | Resultado en la app |
| --- | --- | --- |
| Toque simple | `.onTapGesture { }` | Cambia el color del círculo. |
| Doble toque | `.onTapGesture(count: 2) { }` | Restablece tamaño y rotación. |
| Mantener presionado | `.onLongPressGesture(minimumDuration: 1) { }` | Pone el círculo gris. |
| Arrastrar | `DragGesture()` | Mueve el círculo; al soltarlo vuelve al centro. |
| Pellizcar | `MagnifyGesture()` | Agranda o achica el círculo. |
| Girar | `RotateGesture()` | Gira el círculo con dos dedos. |

### Ideas importantes
- **`@State`** guarda los valores que cambian (color, posición, escala, ángulo). Al modificarlos, SwiftUI redibuja la vista automáticamente.
- **`onChanged`** se ejecuta *mientras* el gesto ocurre; **`onEnded`**, cuando el dedo se levanta.
- El **doble toque se declara antes** que el toque simple; si no, el toque simple lo "taparía".
- **`simultaneousGesture`** permite que el zoom y la rotación funcionen junto con los otros gestos.
- **`withAnimation`** hace que los cambios se vean suaves.

---

## ▶️ Cómo ejecutar

1. Abre el proyecto en **Xcode**.
2. Elige un simulador de iPhone (o tu dispositivo) como destino.
3. Pulsa **Run** (⌘R).

### Notas
- El audio y el video se cargan **desde Internet**, así que el dispositivo o simulador necesita conexión.
- En el **simulador**, para pellizcar o girar mantén presionada la tecla **Option (⌥)** y arrastra con el ratón para simular dos dedos.
- Los gestos `MagnifyGesture` y `RotateGesture` requieren iOS 17 o posterior.

---

## 🧪 Ejercicios sugeridos

1. Agrega un botón para **silenciar** el audio (`audioPlayer.isMuted = true`).
2. Cambia la URL del video por la de otro video.
3. Haz que el círculo **se quede** donde lo sueltas en lugar de volver al centro.
4. Agrega un sonido cuando se toque el círculo.
