# Stage 1: Build
FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source and build
COPY . .

# DevOps Traceability: Inject API URL and Build ID into the React App
ARG VITE_API_BASE
ARG VITE_BUILD_ID
ENV VITE_API_BASE=$VITE_API_BASE
ENV VITE_BUILD_ID=$VITE_BUILD_ID

RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
# Copy the static build files to Nginx
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]