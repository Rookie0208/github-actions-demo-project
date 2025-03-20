FROM node:16-alpine

WORKDIR /app

COPY package*.json .

RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm install --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

COPY . .

RUN npm run build

EXPOSE 3000

CMD [ "npm", "start" ]
