FROM ruby:2.7

ENV LANG en_US.utf8
RUN mkdir /app
WORKDIR /app

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && apt-get install -qq -y build-essential libpq-dev wget curl --fix-missing --no-install-recommends g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

RUN apt-get install git && apt-get install npm -y && \
    npm install -g yarn

# Custom .bashrc/.profile
RUN echo 'export PATH="./bin:$PATH"' >> ~/.bashrc
RUN echo "cd /app" >> ~/.profile

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /tmp/.ruby* /tmp/.bundle /var/tmp/*

RUN gem install bundler

ADD . /app

ADD ./config/dev_startup.sh /opt/dev_startup.sh

