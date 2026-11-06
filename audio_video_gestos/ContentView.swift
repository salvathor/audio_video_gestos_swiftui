import SwiftUI

/// Pantalla principal de la app.
/// Usa un `TabView` (pestañas) para separar los dos ejemplos:
/// 1. Audio y Video
/// 2. Eventos táctiles (gestos)
struct ContentView: View {
    var body: some View {
        TabView {
            // Cada `Tab` es una pestaña en la barra inferior.
            Tab("Audio y Video", systemImage: "play.rectangle") {
                AudioVideoView()
            }

            Tab("Táctil", systemImage: "hand.tap") {
                TouchEventsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
