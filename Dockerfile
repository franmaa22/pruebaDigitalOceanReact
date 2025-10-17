# Etapa 1: Build de la app
FROM node:25 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servir con NGINX
FROM nginx:alpine

# Copiar el build al directorio de NGINX
COPY --from=build /app/build /usr/share/nginx/html

# Copiar config opcional si querés hacer rewrite de rutas
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
