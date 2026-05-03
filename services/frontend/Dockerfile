FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies first (Cached layer)
COPY package*.json ./
RUN npm install

# Copy source and build
COPY . .
# Optional: Pass API URL during build
ARG VITE_API_BASE
ENV VITE_API_BASE=$VITE_API_BASE
RUN npm run build

FROM nginx:alpine
# Add custom nginx config if you use React Router later
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]