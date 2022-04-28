ARG base=ubuntu
FROM $base as builder

# docker build -t aws .

RUN apt-get update && apt-get install -y unzip curl
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
FROM scratch
LABEL LAYER_PATH=/usr/local/bin/aws
LABEL LAYER_ARCH=x86_64
COPY --from=builder /usr/local/bin/aws /usr/local/bin/aws
