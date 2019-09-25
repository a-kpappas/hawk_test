# Defines the tag for OBS and build script builds:
#!BuildTag: hawk_test
# Use the repositories defined in OBS for installing packages
#!UseOBSRepositories
FROM	opensuse/leap:15.1

RUN	zypper ar http://download.opensuse.org/repositories/mozilla/openSUSE_Leap_15.1/mozilla.repo && \
RUN	zypper --gpg-auto-import-keys -n install -y --no-recommends \
		MozillaFirefox \
		chromium \
		file \
		python3 \
		python3-paramiko \
		python3-PyVirtualDisplay \
		python3-selenium \
		shadow \
		xdpyinfo \
		xorg-x11-fonts \
		xorg-x11-server && \
	zypper -n clean -a

COPY	geckodriver /usr/local/bin/
COPY	chromedriver /usr/local/bin/
RUN	chmod +x /usr/local/bin/*

RUN	useradd -l -m -d /test test

COPY	*.py /

ENV     PYTHONPATH /
ENV	PYTHONUNBUFFERED 1
ENV	DBUS_SESSION_BUS_ADDRESS /dev/null

WORKDIR	/test

USER	test
ENTRYPOINT ["/usr/bin/python3", "/hawk_test.py"]
