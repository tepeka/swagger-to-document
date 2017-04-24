#!/usr/bin/env sh
docker run --rm -it -v $(pwd)/documents/:/documents tepeka/swagger-to-document
