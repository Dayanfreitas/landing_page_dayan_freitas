# --------------- Builder stage ---------------
FROM alpine:3.22.0 as builder

WORKDIR /app

RUN apk add --no-cache hugo

COPY . .

RUN hugo build

# --------------- Runtime stage ---------------
FROM nginx:alpine as runtime

WORKDIR /app
RUN apk add --no-cache hugo


ENV HUGO_ENV=production
COPY --from=builder /app /app

EXPOSE 1313
# RUN hugo server
CMD ["hugo", "server", "--bind", "0.0.0.0", "--port", "1313"]