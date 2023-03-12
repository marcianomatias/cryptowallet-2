# syntax=docker/dockerfile
FROM ruby:2.4.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /cryptowallet
COPY Gemfile /cryptowallet/Gemfile
COPY Gemfile.lock /cryptowallet/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH