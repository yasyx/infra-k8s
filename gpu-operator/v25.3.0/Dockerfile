FROM scratch
COPY registry registry
COPY gpu-operator charts/gpu-operator
COPY nvidia-grafana charts/nvidia-grafana
COPY install.sh install.sh
COPY values.yaml values.yaml
CMD ["bash install.sh"]