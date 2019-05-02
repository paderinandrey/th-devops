FROM ruby:2.6.2

WORKDIR /app

# Add app files into docker image
COPY ./ .

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -qy nodejs

ENV DB_HOST db
ENV DB_PORT 5432
ENV DB_NAME demo_app
ENV DB_USER demo_user
ENV DB_PASSWORD demo_user
ENV RAILS_ENV production1

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