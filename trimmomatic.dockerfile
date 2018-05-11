FROM alpine as builder

ARG VERSION=0.36

WORKDIR /root

RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-$VERSION.zip 
RUN unzip Trimmomatic-$VERSION.zip Trimmomatic-$VERSION/trimmomatic-$VERSION.jar
RUN echo -e '#!/bin/sh\njava -jar /usr/local/share/trimmomatic.jar $@' > trimmomatic
RUN chmod u+x trimmomatic

FROM anapsix/alpine-java:7

ARG VERSION=0.36

COPY --from=builder /root/Trimmomatic-$VERSION/trimmomatic-$VERSION.jar /usr/local/share/trimmomatic.jar
COPY --from=builder /root/trimmomatic /usr/local/bin/trimmomatic

ENTRYPOINT ["/usr/local/bin/trimmomatic"]
