FROM openjdk:8-jdk
LABEL name="nodejs-chrome-java"

RUN apt-get update && \
    apt-get install -y \
        npm \
        unzip \
        chromium \
        chromium-driver \
        phantomjs \
    && apt-get clean

# Set PhantomJS to run headless
ENV QT_QPA_PLATFORM offscreen