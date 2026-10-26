
FROM node:22-alpine

WORKDIR /app

# Enable pnpm inside the container
RUN corepack enable

# Install dependencies first for better build caching
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --allow-build=esbuild

# Copy the application source
COPY . .

# The app's start script expects a .env file
RUN cp .env.sample .env

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["pnpm", "start"]
