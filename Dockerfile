FROM node:latest AS prod

WORKDIR /app

COPY package.json .

COPY yarn.lock .

RUN yarn install

COPY . .

# RUN npm test - if you want to test before to build
RUN yarn build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=prod /app/build .

# run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]