FROM alpine

RUN apk add --no-cache python3 python3-dev gcc gfortran musl-dev
RUN pip3 install biopython
