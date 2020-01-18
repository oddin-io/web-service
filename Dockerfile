FROM ruby:2.5.0

MAINTAINER Bruno Felipe Leal Delfino <bruno.delfino1995@gmail.com>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && apt-get install -qq -y \
  build-essential libpq-dev postgresql-client-9.6 \
  --fix-missing --no-install-recommends

RUN apt-get update
RUN apt-get install -y python3 python-pip
RUN pip install nltk psycopg2
# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /home/app

# Set the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# Expose the server port
EXPOSE 3000

CMD rails server -p 3000 -b 0.0.0.0
