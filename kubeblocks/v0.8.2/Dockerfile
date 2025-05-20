FROM scratch

COPY --from=docker.io/labring/kubeblocks:v0.8.2   . .
COPY --from=docker.io/labring/kubeblocks-apecloud-mysql:v0.8.2   . .
COPY --from=docker.io/labring/kubeblocks-postgresql:v0.8.2   . .
COPY --from=docker.io/labring/kubeblocks-mongodb:v0.8.2   . .
COPY --from=docker.io/labring/kubeblocks-redis:v0.8.2   . .
COPY registry registry
COPY entrypoint.sh entrypoint.sh
COPY crds crds
CMD ["bash entrypoint.sh"]