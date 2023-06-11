FROM node:alpine
ENV NODE_OPTIONS=--openssl-legacy-provider
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.25.0

#label zgodny z OCI
LABEL org.opencontainers.image.source=https://github.com/icheredn/zadanie2

EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
