FROM node:20-slim as node

# install build toolchain
RUN apt-get update \
  && apt-get install --no-install-recommends -y dumb-init \
  && rm -rf /var/lib/apt/lists/*

# set entrypoint to `dumb-init` as it handles being pid 1 and forwarding signals
# so that you dont need to bake that logic into your node app
ENTRYPOINT ["dumb-init", "--"]

WORKDIR /usr/app

# install a specific NPM version
RUN npm install -g npm@10.2.4

COPY package*.json ./

RUN npm set progress=false \
  && npm ci

COPY . .

# webpack-dev-server (3000)
EXPOSE 3000

CMD ["npm", "start"]
