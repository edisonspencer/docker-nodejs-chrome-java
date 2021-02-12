FROM selenium/standalone-chrome-debug:3.141.59
LABEL name="nodejs-chrome-java"

USER root

# Install Java 8
RUN set -x \
    && apt-get update \
    && apt-get install -y \
        ca-certificates-java \
        openjdk-8-jre-headless \
        openjdk-8-jre \
        openjdk-8-jdk-headless \
        openjdk-8-jdk \
    && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install node 15 and npm
RUN set -x \
    && curl -sL https://deb.nodesource.com/setup_15.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g npm@7.3.0 \
    && apt-get clean

# Make node available
RUN set -x \
    && touch ~/.bashrc \
    && echo 'alias nodejs=node' > ~/.bashrc

# Install PhantomJS
RUN set -x \
	&& apt-get update \
    && apt-get install -y \
        phantomjs \
    && apt-get clean

# Set PhantomJS to run headless
ENV QT_QPA_PLATFORM offscreen

RUN mkdir /logs
RUN touch /logs/selenium.log

RUN echo "" \
	&& echo "Dependencies version in this build:" \
	&& echo "" \
	&& echo "node.js" \
	&& node -v \
	&& echo "" \
	&& echo "npm" \
	&& npm -v \
	&& echo "" \
	&& echo "ChromeDriver" \
	&& chromedriver --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/g' \
	&& echo "" \
	&& echo "Java" \
	&& java -version 2>&1 | head -1 | sed 's/.*"\(.*\)"/\1/g' \
	&& echo "" \
	&& echo "PhantomJS" \
	&& phantomjs -v 2>&1 | tail -1 | sed 's/.*"\(.*\)"/\1/g' \
	&& echo ""