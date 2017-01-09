FROM node:6.9

MAINTAINER Jason Raimondi <jason@raimondi.us>

RUN apt-get update \
    && apt-get install -y software-properties-common apt-transport-https curl ca-certificates bash supervisor \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /var/www/html

COPY ./bin/run.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run.sh

CMD /usr/local/bin/run.sh