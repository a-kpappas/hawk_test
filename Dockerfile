# Defines the tag for OBS and build script builds:
#!BuildTag: hawk_test
# Use the repositories defined in OBS for installing packages
#!UseOBSRepositories
FROM	opensuse/tumbleweed

RUN	zypper -n install -y --no-recommends \
		MozillaFirefox-branding-upstream \
		chromium \
		python3 \
		python3-paramiko \
		python3-pip \
		python3-PyVirtualDisplay \
		python3-selenium \
		shadow \
		xdpyinfo \
		xorg-x11-server && \
	zypper -n clean -a

COPY	geckodriver /usr/local/bin/
RUN	chmod +x /usr/local/bin/geckodriver

RUN	useradd -l -m -d /test test

COPY	*.py /

ENV     PYTHONPATH /
ENV	PYTHONUNBUFFERED 1
ENV	DBUS_SESSION_BUS_ADDRESS /dev/null

WORKDIR	/test

USER	test
ENTRYPOINT ["/usr/bin/python3", "/hawk_test.py"]
