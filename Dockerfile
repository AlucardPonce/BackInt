FROM node:18-alpine

# Instalar dumb-init para manejar señales
RUN apk add --no-cache dumb-init

# Crear usuario no-root
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar solo dependencias de producción
RUN npm ci --only=production

# Copiar código fuente
COPY . .

# Cambiar al usuario no-root
USER nodejs

# Exponer puerto
EXPOSE 4000

# Usar dumb-init
ENTRYPOINT ["dumb-init", "--"]

# Comando de inicio
CMD ["node", "src/server.js"]