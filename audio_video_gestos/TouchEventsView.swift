import SwiftUI

/// Ejemplo de EVENTOS TÁCTILES (gestos) en SwiftUI.
///
/// Gestos que veremos:
/// - Toque simple (tap)
/// - Doble toque (double tap)
/// - Mantener presionado (long press)
/// - Arrastrar (drag)
/// - Pellizcar para hacer zoom (magnify)
/// - Girar con dos dedos (rotate)
struct TouchEventsView: View {

    /// Mensaje que describe el último gesto detectado.
    @State private var message = "Toca, arrastra o pellizca el círculo"

    /// Color del círculo (cambia con los toques).
    @State private var color: Color = .blue

    /// Desplazamiento del círculo mientras se arrastra.
    @State private var offset: CGSize = .zero

    /// Escala (tamaño) del círculo para el gesto de pellizcar.
    @State private var scale: CGFloat = 1.0

    /// Ángulo de rotación para el gesto de girar.
    @State private var rotation: Angle = .zero

    /// Lista de colores para ir cambiando con cada toque.
    private let colors: [Color] = [.blue, .green, .orange, .purple, .pink, .red]

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {

                // Texto que nos dice qué gesto ocurrió.
                Text(message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(height: 60)

                Spacer()

                // La figura sobre la que aplicamos los gestos.
                Circle()
                    .fill(color.gradient)
                    .frame(width: 150, height: 150)
                    .overlay {
                        Image(systemName: "hand.point.up.left.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    // Los modificadores visuales usan los valores de estado.
                    .scaleEffect(scale)
                    .rotationEffect(rotation)
                    .offset(offset)

                    // 1️⃣ DOBLE TOQUE
                    // Importante: se declara ANTES del toque simple; si no,
                    // el toque simple "ganaría" siempre.
                    .onTapGesture(count: 2) {
                        message = "👆👆 ¡Doble toque! Tamaño restablecido"
                        withAnimation(.spring) {
                            scale = 1.0
                            rotation = .zero
                        }
                    }

                    // 2️⃣ TOQUE SIMPLE: cambia a un color aleatorio.
                    .onTapGesture {
                        message = "👆 Toque simple: cambié de color"
                        withAnimation {
                            color = colors.randomElement() ?? .blue
                        }
                    }

                    // 3️⃣ MANTENER PRESIONADO (al menos 1 segundo).
                    .onLongPressGesture(minimumDuration: 1) {
                        message = "✋ Mantuviste presionado 1 segundo"
                        withAnimation {
                            color = .gray
                        }
                    }

                    // 4️⃣ ARRASTRAR
                    .gesture(
                        DragGesture()
                            // `onChanged` se llama continuamente mientras el dedo se mueve.
                            .onChanged { value in
                                offset = value.translation
                                message = "↔️ Arrastrando: x \(Int(offset.width)), y \(Int(offset.height))"
                            }
                            // `onEnded` se llama cuando se levanta el dedo.
                            .onEnded { _ in
                                message = "Soltaste el círculo, vuelve al centro"
                                withAnimation(.spring) {
                                    offset = .zero
                                }
                            }
                    )

                    // 5️⃣ PELLIZCAR (zoom) y 6️⃣ GIRAR, al mismo tiempo.
                    // `simultaneousGesture` permite que funcionen junto con los demás gestos.
                    .simultaneousGesture(
                        MagnifyGesture()
                            .onChanged { value in
                                // `magnification` es 1.0 al inicio; >1 agranda, <1 achica.
                                scale = value.magnification
                                message = "🤏 Zoom: \(String(format: "%.1f", scale))x"
                            }
                    )
                    .simultaneousGesture(
                        RotateGesture()
                            .onChanged { value in
                                rotation = value.rotation
                                message = "🔄 Girando: \(Int(rotation.degrees))°"
                            }
                    )

                Spacer()

                // Pequeña guía para el usuario.
                VStack(alignment: .leading, spacing: 6) {
                    Text("• Toque: cambia el color")
                    Text("• Doble toque: restablece tamaño y giro")
                    Text("• Mantener 1 s: color gris")
                    Text("• Arrastrar: mueve el círculo")
                    Text("• Pellizcar / girar con dos dedos")
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Eventos táctiles")
        }
    }
}

#Preview {
    TouchEventsView()
}
