ARG VARIANT=gcc11
FROM ghcr.io/wolfee001/devcontainers-${VARIANT}:master

COPY . /workspace
RUN sudo chown -R conan /workspace

RUN cd /workspace \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DSTATIC_ANALYZERS=1 \
    && cmake --build . --target install \
    && cd ..

RUN target/hello

RUN cd /workspace/src/node_hello \
    && npm install
    && node index.js