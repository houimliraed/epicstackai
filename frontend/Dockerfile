FROM node:22 AS build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npm run build


FROM nginx:alpine  
RUN rm -rf /usr/share/nginx/html/*

# Copy React build to nginx folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose NGINX port (80)
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]