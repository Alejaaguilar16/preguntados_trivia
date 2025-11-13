# Preguntados Trivia

**Preguntados Trivia** 
Es una aplicación móvil totalmente desarrollada en **Flutter**, que permite a todos los usuarios disfrutar de un increible juego de preguntas y respuestas, con temporizador y retroalimentación visual (respuestas correctas en verde e incorrectas en rojo).  
La app fue creada aplicando **arquitectura limpia (Clean Architecture)** y el **patrón de diseño Repository**, junto con manejo de estado mediante **Riverpod**.

# Descripción general

El objetivo de este juego es poder responder correctamente una serie de preguntas en el menor tiempo posible.  
Si el jugador responde correctamente, la opción se resalta en verde; si falla, se marca en rojo.  
Al finalizar todas las preguntas o agotar el tiempo, la aplicación muestra un mensaje final y permite reiniciar o salir del juego.

La aplicación incluye:
- Pantalla de **Login** con autocompletado simulado de usuarios
- Pantalla **Home** para iniciar la partida
- Pantalla **GamePage** con el juego de trivia, temporizador, retroalimentación visual, botón de reinicio y botón de salida
- Fondos personalizados con imágenes o GIFs para una mejor la experiencia

# Arquitectura limpia

El proyecto está estructurado con **Clean Architecture**, en tres capas:

lib/
├── data/
│ ├── models/ #los modelos de datos (estructura de pregunta)
│ ├── repositories/ #Implementación del repositorio (fuente local)
│
├── domain/
│ ├── entities/ #Entidades principales (Pregunta)
│ ├── repositories/ #Contrato (abstract class del repositorio)
│ ├── usecases/ #Casos de uso (obtener preguntas)
│
├── presentation/
│ ├── controllers/ #Controladores de estado (GameController)
│ ├── pages/ # LoginPage, HomePage, GamePage
│ ├── widgets/ # Widgets reutilizables
│
├── main.dart #Punto de entrada de la app


# Comunicación entre capas
1. **Presentation** maneja la UI, interacción del usuario y estado
2. **Domain** contiene la lógica de negocio pura y los casos de uso
3. **Data** provee datos desde una fuente local en este caso una lista simulada

Cada capa depende de la anterior solo mediante **abstracciones** (interfaces), lo que permite bajo acoplamiento y alta mantenibilidad

# Patrón de diseño aplicado
 **patrón Repository** para aislar la lógica de obtención de datos del resto de la aplicación

- El dominio define una interfaz `PreguntasRepository` con `Future<List<Pregunta>> getPreguntas()`
- La capa `data` implementa esta interfaz en `PreguntasRepositoryImpl`, simulando la obtención de datos locales
- Esto permite cambiar fácilmente la fuente de datos (por ejemplo, conectando a una API REST o base de datos local) sin afectar las demás capas

* Justificación 
 Seleccione este patrón porque mejora la mantenibilidad, facilita las pruebas unitarias y desacopla la lógica de negocio del origen de los datos

# Manejo de estado

Con **Riverpod** un gestor moderno y eficiente para Flutter

- `StateNotifierProvider` para manejar el estado del juego (`GameController`)
- El controlador gestiona:
  - La pregunta actual
  - El tiempo restante
  - Las respuestas correctas/incorrectas
  - Las acciones de reinicio y finalización

> Esto permite separar completamente la lógica del estado del árbol de widgets, haciendo el código más limpio y escalable

# Persistencia y datos

Datos **locales simulados**, almacenados en la capa `data` (una lista de preguntas tipo JSON) 

Puede ampliarse para usar:
- **SharedPreferences** (para guardar puntajes o usuario)
- **API REST** (para obtener preguntas dinámicas)
- **Base de datos local** (con Hive o Sqflite)

# Lógica

Ej:
- Validación de respuestas correctas/incorrectas
- Control de temporizador (10 segundos por pregunta)
- Reinicio automático o salida al agotar tiempo o fallar dos veces
- Retroalimentación visual mediante cambio de color
- Control de flujo 

# Instrucciones de ejecución
Requisitos

Flutter SDK
Dart SDK
Android Studio o VS Code con el plugin de Flutter
Emulador/Android o un dispositivo físico conectado

Clonar el repositorio: git clone https://github.com/Alejaaguilar16/preguntados_trivia.git
cd preguntados_trivia
Instalar dependencias: flutter pub get
Ejecutar la app: flutter run
Ejecutar las pruebas unitarias: flutter test

# Pruebas unitarias

El proyecto incluye pruebas unitarias en la carpeta `/test`:

# `game_controller_test.dart`
Verifica que el controlador:
- Cargue preguntas correctamente
- Avance de pregunta al responder
- Detecte respuestas correctas e incorrectas

# `widget_test.dart`
Prueba el arranque básico de la app (`MyApp`) y validaciones iniciales de la interfaz

ejectndo las pruebas con:
```bash
flutter test *00:06 +3: All tests passed!*


# Video demostrativo

Flujo principal de la aplicación
Cómo se refleja la arquitectura limpia en el código
Dónde y cómo se aplicó el patrón Repository
Interacción con el juego: login-inicio-trivia-reinicio/salida

# Autora

María Alejandra Patiño Aguilar
Proyecto final de Flutter/Arquitectura Limpia y Patrón de Diseño