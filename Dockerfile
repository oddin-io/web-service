FROM ruby:2.3

MAINTAINER Bruno Felipe Leal Delfino <bruno.delfino1995@gmail.com>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && apt-get install -qq -y apt-utils build-essential libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

# Put gem's folder in PATH
ENV PATH $PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /ws-oddin

# Set the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
RUN gem install bundler && bundle install --without test development

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# Environment variables for RAILS
ENV RAILS_PORT 3000
ENV RAILS_ENV production
ENV SECRET_KEY_BASE 8d64f274d380cdf8b69183dcd817ffdecdda25c119f23301722519fce387b0a9baefb817f956d3b1346ef55ec364aa6200690b9932e84c4c181d87c50ae884e2

CMD rails server -p $RAILS_PORT
