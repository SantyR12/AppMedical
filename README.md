# SGP — Sistema de Gestión de Pacientes

App de historia clínica electrónica para entornos hospitalarios.  
**Universidad Cooperativa de Colombia · Sprint 2 · 2025**

---

## Equipo

| Integrante | Módulo | Tests |
|---|---|---|
| Santiago Ramos | Historia clínica, búsqueda de pacientes, notas SOAP | T-06, T-07, T-08, T-09 |
| Samuel Guerrero | Autenticación, MFA, roles, seguridad | T-01, T-02, T-03, T-04, T-05 |
| Paulo | Alergias, medicamentos, prescripciones, DoseValidator | T-10, T-11 |

---

## Stack

| Capa | Tecnología |
|---|---|
| App | Flutter 3.x / Dart 3.8 |
| Estado | `flutter_riverpod` — StateNotifier por módulo |
| HTTP | `dio` con interceptor JWT |
| Modelos | `freezed` + `json_annotation` |
| Navegación | `go_router` con guard por rol |
| Tests | `flutter_test` + `mockito` 5.x null-safe |
| Almacenamiento | `flutter_secure_storage` (JWT / refresh token) |

---

## Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/SantyR12/AppMedical.git
cd AppMedical

# 2. Instalar dependencias
flutter pub get

# 3. Correr la app (modo desarrollo — usa repositorios mock)
flutter run
```

---

## Tests — Sprint 2

### Correr TODOS los tests del sprint

```bash
flutter test \
  test/paulo/paulo_alergias_test.dart \
  test/samuel/samuel_auth_test.dart \
  test/santiago/santiago_historial_test.dart \
  test/tests/samuel_auth_test.dart
```

**Resultado esperado: 34/34 tests passed**

---

### Correr por integrante

**Santiago — Historia clínica (T-06 a T-09)**
```bash
flutter test test/santiago/santiago_historial_test.dart
```

| Test | Historia de usuario | Qué verifica |
|---|---|---|
| T-06 | APA-39 | Crear historia clínica con campos completos |
| T-07 | APA-40 | Control de acceso por rol (médico / enfermero / admin) |
| T-08 | APA-41 | Búsqueda por número de documento exacto |
| T-09 | APA-42 | Búsqueda por nombre parcial (mínimo 3 caracteres) |

---

**Samuel — Auth y seguridad (T-01 a T-05)**
```bash
flutter test test/samuel/samuel_auth_test.dart test/tests/samuel_auth_test.dart
```

| Test | Historia de usuario | Qué verifica |
|---|---|---|
| T-01 | APA-34 | Login exitoso con credenciales válidas |
| T-02 | APA-35 | Bloqueo tras 5 intentos fallidos |
| T-03 | APA-36 | OTP válido completa la autenticación (MFA) |
| T-04 | APA-37 | OTP expirado es rechazado |
| T-05 | APA-38 | Logout limpia sesión y tokens |

---

**Paulo — Alergias y medicamentos (T-10, T-11)**
```bash
flutter test test/paulo/paulo_alergias_test.dart
```

| Test | Historia de usuario | Qué verifica |
|---|---|---|
| T-10 | APA-43 | Banner de alergia grave visible en perfil del paciente |
| T-11 | APA-44 | Alerta al prescribir con alergia activa + DoseValidator |

---

### Captura de pantalla de los resultados

Para obtener la salida limpia que se muestra en los informes:

```bash
# Todos los tests con salida detallada
flutter test \
  test/paulo/paulo_alergias_test.dart \
  test/samuel/samuel_auth_test.dart \
  test/santiago/santiago_historial_test.dart \
  test/tests/samuel_auth_test.dart \
  --reporter expanded 2>&1 | tee resultados_tests.txt
```

El archivo `resultados_tests.txt` queda en la raíz del proyecto con el log completo.

---

### Regenerar mocks (solo si cambia una interfaz de repositorio)

```bash
dart run build_runner build --delete-conflicting-outputs
```

Archivos generados:
- `test/paulo/paulo_alergias_test.mocks.dart`
- `test/samuel/samuel_auth_test.mocks.dart`
- `test/santiago/santiago_historial_test.mocks.dart`
- `test/tests/samuel_auth_test.mocks.dart`

---

## Estructura del proyecto

```
lib/
├── core/                          # Router, tema, Dio client, token store
├── features/
│   ├── auth/                      # Login, MFA, registro, roles
│   │   ├── domain/models/         # UserModel, LoginRequest, LoginResponse
│   │   ├── domain/repositories/   # IAuthRepository
│   │   ├── data/repositories/     # AuthRepository (real + mock)
│   │   ├── presentation/screens/  # LoginScreen, MfaScreen, RegisterScreen
│   │   └── providers/             # AuthStateNotifier, SessionProvider
│   ├── historial/                 # Historia clínica, pacientes, notas SOAP
│   │   ├── domain/models/         # PatientModel, ClinicalRecordModel
│   │   ├── domain/repositories/   # IHistorialRepository
│   │   ├── data/repositories/     # HistorialRepository (real + mock)
│   │   ├── presentation/screens/  # PatientSearchScreen, PatientDetailScreen
│   │   └── providers/             # HistorialNotifier, PatientSearchNotifier
│   ├── medicamentos_alergias/     # Alergias, prescripciones, MAR
│   │   ├── domain/models/         # AllergyModel, PrescriptionModel, MARModel
│   │   ├── domain/utils/          # DoseValidator
│   │   ├── data/repositories/     # AllergyRepository, PrescriptionRepository
│   │   ├── presentation/screens/  # AllergyFormScreen, PrescriptionFormScreen
│   │   └── providers/             # AllergyListNotifier, PrescriptionProvider
│   └── diagnosticos/              # CIE-10, lista de problemas activos
test/
├── paulo/                         # Tests T-10, T-11 (alergias)
├── samuel/                        # Tests T-01, T-02, T-03 (auth base)
├── santiago/                      # Tests T-06, T-07, T-08, T-09 (historial)
└── tests/                         # Tests T-04, T-05 (auth seguridad — Samuel)
```

---

## Ramas y flujo de trabajo

```
main
 └── develop          ← integración continua
      └── local/sprint2-completo   ← rama final Sprint 2 (esta)
```

Para hacer PR a `main`:
1. Verificar que todos los tests pasen (ver sección Tests arriba)
2. Abrir PR desde `local/sprint2-completo` → `main` en GitHub
3. Incluir capturas de `flutter test --reporter expanded` en la descripción del PR
