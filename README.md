# gallen-splunkforwarder

I was frustrated with the state of splunk installers on macOS,
so I made this repository.

Things I don't like about the "official" splunk installer:
- it installs and runs as the logged-in user
- it requires some manual post-installation configuration
- it's easy to misconfigure to run as root on subsequent reboots
- it installs into `/Applications/SplunkForwarder.app`
  - it's not really an app, it's a daemon
  - the running daemon modifies lots of files in there,
    which is strange for something inside `/Applications`

Some other tarball installers install in `/opt/splunkforwarder`,
which seems much more sensible for a daemon. Unfortunately, the ones
I've seen install and run as `root:wheel`, which feels like a
security problem. Those other installers also don't necessarily
handle the custom configuration very well.

So this project uses AutoPkg to create an installer that:
- installs in `/opt/splunkforwarder`
- creates user/group `_splunk:_splunk` if they don't exist
- installs and runs as `_splunk:_splunk`
- include `conf` files in the package that splunk needs to work
- lets you name the package for your organizations configuration

This repo includes a sample `myorg_splunk_local` directory that
shows the `conf` files that splunk needs to run properly. Please
refer to the splunk documentation for the contents of those files,
and configuring them for your organization.

This repo also includes a `Makefile` that shows how I build the
package (using `autopkg`). It may be useful to you, but it's not
necessary.
