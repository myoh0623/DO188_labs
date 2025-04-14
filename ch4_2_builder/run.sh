podman build -f Dockerfiles/nextjs_nginx.Dockerfile -t nextjs-nginx .
podman run -d -p 8080:8080 nextjs-nginx
curl http://localhost:8080