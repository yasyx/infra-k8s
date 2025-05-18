FROM scratch

COPY --from=docker.io/kubeblocks:v0.8.2   . .
COPY --from=docker.io/kubeblocks/kubeblocks-apecloud-mysql:v0.8.2   . .
COPY --from=docker.io/kubeblocks/kubeblocks-postgresql:v0.8.2   . .
COPY --from=docker.io/kubeblocks/kubeblocks-mongodb:v0.8.2   . .
COPY --from=docker.io/kubeblocks/kubeblocks-redis:v0.8.2   . .
COPY --from=docker.io/kubeblocks/kubeblocks-csi-s3:v0.31.4   . .

COPY entrypoint.sh entrypoint.sh
CMD ["bash entrypoint.sh"]