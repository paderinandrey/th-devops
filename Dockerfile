FROM ruby:2.6.2

WORKDIR /app

# Add app files into docker image
COPY ./ .


RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -qy nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -  && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get install -qy yarn

ENV DB_HOST db
ENV DB_PORT 5432
ENV DB_NAME demo_app
ENV DB_USER demo_user
ENV DB_PASSWORD demo_user
ENV RAILS_ENV production

# install bundler
RUN gem install bundler -v '1.17.2'
COPY Gemfile* ./
RUN bundle install

RUN cp config/database.yml.sample config/database.yml


COPY ./wait-for-it.sh /
COPY ./start.sh /
RUN chmod +x /wait-for-it.sh
RUN chmod +x /start.sh

RUN /wait-for-it.sh $DB_HOST:$DB_PORT -t 5 -- /start.sh $RAILS_ENV

# Bundle installs with binstubs to our custom /bundle/bin volume path.
# Let system use those stubs.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=2
ENV PATH="${BUNDLE_BIN}:${PATH}"
