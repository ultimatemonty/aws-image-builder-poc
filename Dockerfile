FROM node:14 as build

WORKDIR /app

COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock

RUN yarn install --pure-lockfile
COPY . .
RUN yarn build

FROM nginx

# copy the compiled app
COPY ./config/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
