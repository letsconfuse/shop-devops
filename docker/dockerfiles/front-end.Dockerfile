# Stage 1: Build & Install Dependencies
FROM node:14-alpine AS builder
ENV NODE_ENV="production"
WORKDIR /usr/src/app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

# Stage 2: Production Image
FROM node:14-alpine
ENV NODE_ENV="production"
ENV PORT=8079
EXPOSE 8079

# Create a non-root user and group for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && mkdir -p /usr/src/app && chown -R appuser:appgroup /usr/src/app

WORKDIR /usr/src/app

# Copy dependencies and source with proper permissions
COPY --from=builder --chown=appuser:appgroup /usr/src/app/node_modules ./node_modules
COPY --chown=appuser:appgroup . .

USER appuser

# Start the app
CMD ["npm", "start"]
