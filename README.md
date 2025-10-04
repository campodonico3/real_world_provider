# 🍔 Real World Provider - Delivery App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-0175C2?logo=dart)
![Provider](https://img.shields.io/badge/Provider-6.1.5-E91E63)
![License](https://img.shields.io/badge/License-MIT-green)

**Una aplicación de delivery moderna para Chiclayo, Lambayeque 🇵🇪**

[Características](#-características) • [Arquitectura](#-arquitectura) • [Instalación](#-instalación) • [API](#-api-backend) • [Capturas](#-capturas-de-pantalla)

</div>

---

## 📱 Sobre el Proyecto

**Real World Provider** es una aplicación de delivery full-stack desarrollada con Flutter, diseñada específicamente para conectar a los usuarios de Chiclayo con sus restaurantes y comercios favoritos. La aplicación ofrece una experiencia de usuario fluida y moderna, con gestión de estado mediante Provider y navegación declarativa con GoRouter.

### 🎯 Objetivo

Facilitar el proceso de pedido de comida y productos en Chiclayo, ofreciendo:
- 🛒 Carrito de compras inteligente con descuentos automáticos
- 🔐 Autenticación segura con JWT
- 📍 Gestión de direcciones de entrega
- 🎨 Interfaz moderna e intuitiva
- ⚡ Experiencia rápida y fluida

---

## ✨ Características

### 🔐 Autenticación y Seguridad
- ✅ Login y registro de usuarios
- ✅ Autenticación JWT con refresh automático
- ✅ Persistencia de sesión con SharedPreferences
- ✅ Recuperación de contraseña con OTP
- ✅ Social login (Google & Apple) - Próximamente

### 🛍️ Sistema de Compras
- ✅ Carrito de compras con persistencia
- ✅ Incremento/decremento de cantidades
- ✅ Sistema de descuentos automáticos
- ✅ Cálculo de subtotales y totales en tiempo real
- ✅ Advertencias de descuentos suspendidos

### 🏠 Navegación y UX
- ✅ Navegación con StatefulShellRoute (tabs persistentes)
- ✅ Navegación declarativa con GoRouter
- ✅ Redirects automáticos basados en autenticación
- ✅ Splash screen personalizado
- ✅ Bottom navigation bar personalizado

### 🎨 Interfaz de Usuario
- ✅ Diseño Material 3
- ✅ Tema personalizado con colores corporativos
- ✅ Responsive design (390x844 y 428x926)
- ✅ Animaciones fluidas
- ✅ Feedback visual inmediato

### 📍 Gestión de Ubicación
- ✅ Múltiples direcciones de entrega
- ✅ Dirección predeterminada
- ✅ Instrucciones de entrega personalizadas
- ✅ Tipos de dirección (Casa, Trabajo, Otro)

---

## 🏗️ Arquitectura

### 📐 Patrón de Diseño

La aplicación sigue una **arquitectura limpia en capas** con separación clara de responsabilidades:

```
┌─────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                  │
│  - Screens (UI)                                         │
│  - Widgets (Components)                                 │
│  - Consume Providers con Consumer/watch                │
└─────────────────────────────────────────────────────────┘
                         ↕️
┌─────────────────────────────────────────────────────────┐
│                  BUSINESS LOGIC LAYER                   │
│  - Providers (State Management)                         │
│  - AuthProvider, CartProvider, DiscountProvider         │
│  - Orquesta servicios y notifica a la UI               │
└─────────────────────────────────────────────────────────┘
                         ↕️
┌─────────────────────────────────────────────────────────┐
│                       DATA LAYER                        │
│  - Services (API & Storage)                             │
│  - AuthService, ProductService                          │
│  - HTTP Clients, SharedPreferences                      │
└─────────────────────────────────────────────────────────┘
                         ↕️
┌─────────────────────────────────────────────────────────┐
│                      MODEL LAYER                        │
│  - User, Product, CartItem, Address                     │
│  - fromJson/toJson, validaciones                        │
└─────────────────────────────────────────────────────────┘
```

### 🗂️ Estructura del Proyecto

```
lib/
├── core/
│   ├── router/
│   │   ├── router.dart              # Configuración de GoRouter
│   │   └── routers.dart             # Constantes de rutas
│   └── theme/
│       └── app_colors.dart          # Tema y colores
│
├── models/
│   ├── user_model.dart              # Usuario y Address
│   ├── product_model.dart           # Productos
│   └── cart_model.dart              # Carrito
│
├── providers/
│   ├── auth_provider.dart           # Gestión de autenticación
│   ├── cart_provider.dart           # Gestión del carrito
│   └── discount_provider.dart       # Gestión de descuentos
│
├── services/
│   └── auth_service1.dart           # API de autenticación
│
├── screens/
│   ├── splash_screen.dart           # Pantalla de carga
│   ├── sign_in_screen.dart          # Login
│   ├── sign_up_screen.dart          # Registro
│   ├── otp_screen.dart              # Verificación OTP
│   ├── home_screen.dart             # Pantalla principal
│   ├── product_screen.dart          # Lista de productos
│   ├── product_details_screen.dart  # Detalle de producto
│   └── cart_screen.dart             # Carrito de compras
│
├── widgets/
│   ├── input_field_widget.dart      # Campo de texto
│   ├── primary_button_widget.dart   # Botón principal
│   ├── categories_widget.dart       # Categorías
│   ├── ofertas_widget.dart          # Ofertas
│   ├── discount_widget.dart         # Widget de descuento
│   └── ...                          # Otros widgets
│
├── layout/
│   └── layout_scaffold.dart         # Shell con bottom nav
│
└── main.dart                         # Punto de entrada
```

---

## 🚀 Instalación

### Prerrequisitos

- Flutter SDK 3.8.1+
- Dart SDK 3.8.1+
- Android Studio / VS Code
- Dispositivo Android/iOS o emulador

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/real_world_provider.git
cd real_world_provider
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Configurar el backend

Edita `lib/services/auth_service1.dart` y cambia la URL del backend:

```dart
static const String _baseUrl = 'http://TU_IP:3000/api';
```

> **Nota:** Si usas el emulador de Android, usa `10.0.2.2` en lugar de `localhost`

### 4. Ejecutar la aplicación

```bash
# En modo debug
flutter run

# En modo release
flutter run --release
```

---

## 🔌 API Backend

### Endpoints Requeridos

#### Autenticación

**POST** `/api/auth/login`
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Respuesta:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "3",
      "name": "Kevin Anthony",
      "email": "anthony@gmail.com",
      "phone": null,
      "profileImg": null
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  },
  "message": "Login exitoso"
}
```

**POST** `/api/auth/register`
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "phone": "+51999888777"
}
```

**Respuesta:**
```json
{
  "success": true,
  "data": {
    "user": { ... },
    "token": "..."
  },
  "message": "Usuario registrado exitosamente"
}
```

### Headers Requeridos

```
Content-Type: application/json
Accept: application/json
Authorization: Bearer {token}  // Para rutas protegidas
```

---

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.5+1
  
  # Routing
  go_router: ^16.2.1
  
  # HTTP & Storage
  http: ^1.5.0
  shared_preferences: ^2.5.3
  
  # UI
  flutter_svg: ^2.2.1
  flutter_native_splash: ^2.4.6
  
  # Firebase (opcional)
  firebase_core: ^4.1.1
  firebase_auth: ^6.1.0
```

---

## 🎨 Tema y Diseño

### Colores Principales

```dart
Color(0xFFF28B82)  // Primary - Rosa suave
Color(0xFFFFF7EE)  // Background - Crema
Color(0xFF3D405B)  // Text Dark - Azul oscuro
Color(0xFFF28482)  // Accent - Coral
Color(0xFFF5CAC3)  // Secondary - Rosa pastel
```

### Tipografía

- **Font Family:** Unbounded
- **Weights:** Light (300), Regular (400), Medium (500), SemiBold (600), Bold (700)

---

## 🔐 Gestión de Estado

### AuthProvider

Maneja toda la lógica de autenticación:

```dart
// Login
final success = await context.read<AuthProvider>().login(
  email: email,
  password: password,
);

// Obtener usuario actual
final user = context.watch<AuthProvider>().user;

// Verificar autenticación
final isAuth = context.watch<AuthProvider>().isAuthenticated;

// Logout
await context.read<AuthProvider>().logout();
```

### CartProvider

Gestiona el carrito de compras:

```dart
// Agregar producto
context.read<CartProvider>().addToCart(product);

// Incrementar cantidad
context.read<CartProvider>().incrementQuantity(productId);

// Obtener total
final total = context.watch<CartProvider>().totalPrice;

// Vaciar carrito
context.read<CartProvider>().clearCart();
```

### DiscountProvider

Maneja descuentos y promociones:

```dart
// Aplicar descuento
context.read<DiscountProvider>().applyDiscount(
  percentage: 10,
  minimumAmount: 50,
);

// Calcular total con descuento
final total = context.watch<DiscountProvider>()
  .calculateFinalTotal(subtotal);
```

---

## 🗺️ Navegación

### Rutas Principales

```dart
Routes.splash       // /splash
Routes.login        // /login
Routes.register     // /register
Routes.otp          // /otp
Routes.homePage     // /home
Routes.locationPage // /location
Routes.myCartPage   // /myCart
Routes.profilePage  // /profile
```

### Navegación Programática

```dart
// Push
context.push('/product-details');

// Go (reemplaza)
context.go('/home');

// Pop
context.pop();
```

### Navegación Declarativa

El router redirige automáticamente basado en el estado de autenticación:

```dart
if (!isAuthenticated && !isAuthFlow) {
  return Routes.login;  // Redirigir a login
}

if (isAuthenticated && isAuthFlow) {
  return Routes.homePage;  // Redirigir a home
}
```

---

## 🧪 Testing

### Ejecutar Tests

```bash
# Todos los tests
flutter test

# Tests específicos
flutter test test/providers/auth_provider_test.dart

# Con coverage
flutter test --coverage
```

### Ejemplo de Test

```dart
void main() {
  test('Login actualiza estado correctamente', () async {
    final provider = AuthProvider();
    
    await provider.login(
      email: 'test@test.com',
      password: '12345678',
    );
    
    expect(provider.isAuthenticated, true);
    expect(provider.user, isNotNull);
    expect(provider.errorMessage, isNull);
  });
}
```

---

## 📱 Capturas de Pantalla

### Autenticación
<div align="center">
  <img src="screenshots/splash.png" width="200" />
  <img src="screenshots/login.png" width="200" />
  <img src="screenshots/register.png" width="200" />
</div>

### Pantallas Principales
<div align="center">
  <img src="screenshots/home.png" width="200" />
  <img src="screenshots/products.png" width="200" />
  <img src="screenshots/cart.png" width="200" />
</div>

---

## 🛠️ Desarrollo

### Ejecutar en modo debug

```bash
flutter run
```

### Build para producción

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

### Linting

```bash
flutter analyze
```

### Formato de código

```bash
dart format .
```

---

## 🐛 Troubleshooting

### Error: "createdAt cannot be null"

**Solución:** El modelo User ahora maneja campos faltantes automáticamente. Asegúrate de tener la última versión del código.

### Error: "Connection refused"

**Solución:** Verifica que:
1. El backend esté corriendo
2. La URL en `auth_service1.dart` sea correcta
3. Si usas emulador, usa `10.0.2.2` en lugar de `localhost`

### Error: "Provider not found"

**Solución:** Asegúrate de envolver tu app con `ChangeNotifierProvider` en `main.dart`:

```dart
return ChangeNotifierProvider(
  create: (_) => AuthProvider(),
  child: MaterialApp.router(...),
);
```

---

## 🚧 Roadmap

### Versión 1.1
- [ ] Búsqueda de productos
- [ ] Filtros por categoría
- [ ] Historial de pedidos
- [ ] Notificaciones push
- [ ] Seguimiento de pedidos en tiempo real

### Versión 1.2
- [ ] Métodos de pago (Yape, Plin, Tarjeta)
- [ ] Programa de puntos/recompensas
- [ ] Chat con soporte
- [ ] Valoraciones y reseñas
- [ ] Cupones de descuento

### Versión 2.0
- [ ] App para restaurantes (partner app)
- [ ] App para repartidores
- [ ] Panel de administración web
- [ ] Analytics y reportes

---

## 🤝 Contribuir

Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Guías de Contribución

- Sigue el estilo de código existente
- Agrega tests para nuevas funcionalidades
- Actualiza la documentación
- Asegúrate de que `flutter analyze` no muestre errores

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

## 👥 Equipo

**Developer:** [Tu Nombre]
- Email: tu.email@example.com
- GitHub: [@tu-usuario](https://github.com/tu-usuario)
- LinkedIn: [Tu LinkedIn](https://linkedin.com/in/tu-perfil)

---

## 🙏 Agradecimientos

- Flutter Team por el increíble framework
- Provider package por la gestión de estado
- GoRouter por la navegación declarativa
- La comunidad de Flutter por el soporte

---

## 📞 Soporte

Si tienes preguntas o necesitas ayuda:

- 📧 Email: soporte@realworldprovider.com
- 💬 Discord: [Únete a nuestro servidor](https://discord.gg/tu-servidor)
- 🐛 Issues: [GitHub Issues](https://github.com/tu-usuario/real_world_provider/issues)

---

<div align="center">

**Hecho con ❤️ en Chiclayo, Perú 🇵🇪**

⭐ Si te gusta el proyecto, dale una estrella en GitHub!

</div>
