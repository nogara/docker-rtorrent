docker-rtorrent
---------------
This container runs rtorrent and rutorrent (using nginx and php-fpm).

Running manually
----------------
    docker build -t edgard/rtorrent .
    docker run -d --name rtorrent -p 80:80 -p 63256:63256 -v /srv/rtorrent:/data edgard/rtorrent

Running with make tasks
-----------------------
* **build**: build image
* **start**: start container in background
* **test**: start temporary test container *rtorrent-test*
* **test-stop**: stop and remove temporary test container
* **run**: start interactive container
* **push**: push image to docker hub

Check *Makefile* for additional information.

Login info
----------
Configure user/pass starting container with:
> -e USER=admin -e PASS=verysecurepassword

Otherwise a 'admin' user with a random password will be created and you can get it from the logs.

rTorrent configuration
----------------------
If you want to use your own rtorrent config file or if you use the data directory mounted on host, you need to create the file at:
> $DATADIR/config/rtorrent.rc
