# Deployment

Currently deployed to a Raspberry Pi running Raspbian which uses `systemd`. Your deployment stack may vary.

## Requirements install

Installed `rvm` using instructions from their website. Then ran `rvm install 2.6`. Didn't create a gemset.

`youtube-dl` and `redis` had to be installed from source as per their website instructions. `apt-get` didn't install new enough versions, and I didn't want to fight with finding an APT repo to get binaries from.

`bundle install` ran with no issues, and a quick check with `foreman start` indicated all was well.

## nginx install and setup

Installed nginx with `apt-get`. Ensured server was running and serving requests.

Created a config file (`arrdio.conf`) and copied it to `/etc/nginx/sites-available`. Linked it to `sites-enabled`. Removed the link to the `default` site in `sites-enabled`.

## Systemd setup

Created two service scripts. One for the puma app serving (`arrdio-puma.service`), and one for the sidekiq job worker (`arrdio-sidekiq.service`).

Then I copied the service files, reloaded, and enabled them.

```
sudo cp arrdio-puma.service /etc/systemd/system/arrdio-puma.service
sudo systemctl daemon-reload
sudo systemctl enable arrdio-puma
sudo systemctl start arrdio-puma
```

```
sudo cp arrdio-sidekiq.service /etc/systemd/system/arrdio-sidekiq.service
sudo systemctl daemon-reload
sudo systemctl enable arrdio-sidekiq
sudo systemctl start arrdio-sidekiq
```

Both are logging to `/var/log/syslog`. Probably need to create their own log files in the future.