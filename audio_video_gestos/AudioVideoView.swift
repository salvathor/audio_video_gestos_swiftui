import SwiftUI
import AVKit   // AVKit nos da `VideoPlayer` y también incluye AVFoundation (`AVPlayer`)

/// Ejemplo de reproducción de AUDIO y VIDEO.
///
/// Conceptos clave:
/// - `AVPlayer`: el "motor" que reproduce un archivo multimedia (audio o video).
/// - `VideoPlayer`: vista de SwiftUI que muestra un `AVPlayer` con controles de video.
/// - Para audio no hace falta una vista: basta con llamar a `play()` / `pause()`.
struct AudioVideoView: View {

    // MARK: - Video

    /// Reproductor de video. Usamos un video de ejemplo público de Apple (streaming HLS).
    /// `@State` hace que SwiftUI conserve el reproductor aunque la vista se redibuje.
    @State private var videoPlayer = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8")!
    )

    // MARK: - Audio

    /// Reproductor de audio con una canción MP3 de ejemplo de libre uso.
    /// Si quieres usar un archivo propio, arrástralo al proyecto y usa:
    /// `Bundle.main.url(forResource: "cancion", withExtension: "mp3")`
    @State private var audioPlayer = AVPlayer(
        url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
    )

    /// Guarda si el audio está sonando, para cambiar el texto y el ícono del botón.
    @State private var isAudioPlaying = false

    /// Volumen del audio (0.0 = silencio, 1.0 = máximo).
    @State private var volume: Float = 0.5

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // ---------- SECCIÓN VIDEO ----------
                    Text("🎬 Video")
                        .font(.title2.bold())

                    // `VideoPlayer` ya incluye los controles (play, pausa, barra de tiempo, pantalla completa).
                    VideoPlayer(player: videoPlayer)
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .clipShape(.rect(cornerRadius: 12))

                    // También podemos controlar el video desde nuestros propios botones.
                    HStack {
                        Button("Reproducir", systemImage: "play.fill") {
                            videoPlayer.play()
                        }
                        Button("Pausar", systemImage: "pause.fill") {
                            videoPlayer.pause()
                        }
                        Button("Reiniciar", systemImage: "backward.end.fill") {
                            // `seek(to:)` mueve la reproducción a un tiempo concreto. `.zero` = el inicio.
                            videoPlayer.seek(to: .zero)
                        }
                    }
                    .buttonStyle(.bordered)

                    Divider()

                    // ---------- SECCIÓN AUDIO ----------
                    Text("🎵 Audio")
                        .font(.title2.bold())

                    // Un solo botón que alterna entre reproducir y pausar.
                    Button {
                        if isAudioPlaying {
                            audioPlayer.pause()
                        } else {
                            audioPlayer.play()
                        }
                        isAudioPlaying.toggle()   // Cambia true ↔ false
                    } label: {
                        Label(
                            isAudioPlaying ? "Pausar audio" : "Reproducir audio",
                            systemImage: isAudioPlaying ? "pause.circle.fill" : "play.circle.fill"
                        )
                        .font(.title3)
                    }
                    .buttonStyle(.borderedProminent)

                    // Control deslizante para el volumen.
                    HStack {
                        Image(systemName: "speaker.fill")
                        Slider(value: $volume, in: 0...1)
                        Image(systemName: "speaker.wave.3.fill")
                    }
                    // Cada vez que el slider cambia, aplicamos el nuevo volumen al reproductor.
                    .onChange(of: volume) { _, newValue in
                        audioPlayer.volume = newValue
                    }

                    Text("Volumen: \(Int(volume * 100))%")
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            .navigationTitle("Audio y Video")
        }
        .onAppear {
            // Aplicamos el volumen inicial cuando aparece la pantalla.
            audioPlayer.volume = volume
        }
        .onDisappear {
            // Buena práctica: detener la reproducción al salir de la pantalla.
            videoPlayer.pause()
            audioPlayer.pause()
            isAudioPlaying = false
        }
    }
}

#Preview {
    AudioVideoView()
}
