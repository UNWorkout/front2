# Primera etapa de construcción nombrada como "builder"
FROM cirrusci/flutter:3.3.7 AS builder
WORKDIR /app
COPY . .
RUN flutter pub get
RUN flutter build web

# Segunda etapa para ejecutar nginx y servir el contenido construido
FROM nginx:alpine
COPY --from=builder /app/build/web /
