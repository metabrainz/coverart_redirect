Artwork URL redirect service
============================

This service will redirect from `coverartarchive.org` URLs to `archive.org`
URLs, taking into account MBID redirects caused by release merges.

For example, this URL:

    https://coverartarchive.org/release/5b07fe49-39a9-47a6-97b3-e5005992fb2a/front.jpg

should redirect to:

    https://archive.org/download/mbid-5b07fe49-39a9-47a6-97b3-e5005992fb2a/mbid-5b07fe49-39a9-47a6-97b3-e5005992fb2a-2270157148.jpg

## Development setup

There are two ways of setting up the server: with and without Docker.
The first option might be easier if you're just getting started. The second
requires having a MusicBrainz database set up on your machine.

### Option 1: Docker-based

Make sure you have [Docker](https://www.docker.com/) and
[Docker Compose](https://github.com/docker/compose) installed.
To start the development server and its dependencies, run:

    $ docker-compose -f docker/docker-compose.dev.yml up --build

After all Docker images start you should be able to access the web server at `localhost:8080`.

**Note:** Keep in mind that any changes that you make won't show up until the
server container is recreated. To do that you can simply stop the server
(Ctrl + C) and run the command above again.

### Option 2: Manual

artwork-redirect works with *Python 3.8+*, so make sure that you have it
installed. Create a
[virtual environment](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments)
if necessary.

Install all required packages using [pip](https://pip.pypa.io):

    $ pip install -r requirements.txt

Copy *config.default.ini* to *config.ini* and adjust configuration values.
You'd want to set up a connection to the instance of PostgreSQL with a
MusicBrainz database that you should already have running.

Finally, run the *artwork_redirect_server.py* script to start the server.

All logging goes to stdout, including stacktraces, so it's suitable for
running inside of daemontools.

## Testing

*Currently some tests depend on an actual MusicBrainz database running in the background, so make sure to follow the setup process first.* We use
[Pytest](https://pytest.org) as a test runner. All tests can be run with the
following command:

    $ pytest

There are more ways to use Pytest (for example, to run only tests for a
specific module). Check their documentation to see what kinds of additional
options you have.

With **Docker** you can run all the tests like this:

    $ docker-compose -f docker/docker-compose.test.yml up --build

You should see test results in the output.
