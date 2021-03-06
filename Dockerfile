# This Dockerfile is a multistep Dockerfile.
# The first step is the build step - building the Node.js app from source.
# The second step is the run step - running the app via nginx.

# Build
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build # This will create a 'build' directory in WORKDIR.

# Run
FROM nginx
# This makes AWS Elastic Beanstalk expose the specified port.
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
