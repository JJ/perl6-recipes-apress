FROM jjmerelo/alpine-perl6:latest
LABEL version="0.0.1" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ADD META6.json Chapter-5/filter-ingredients-proteins.p6 ./
RUN mkdir lib && mkdir data
ADD lib/ lib
ADD data/calories.csv data

RUN apk update && apk upgrade && zef install . \
    && chmod +x filter-ingredients-proteins.p6

ENTRYPOINT [ "./filter-ingredients-proteins.p6" ]

