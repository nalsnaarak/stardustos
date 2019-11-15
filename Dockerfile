FROM debian:sid

RUN apt-get update -y >/dev/null 2>&1 && \
	apt-get install -y build-essential grub xorriso gcc gdb python cmake zip unzip curl cppcheck rubygems cscope doxygen graphviz git xvfb x11vnc qemu-system openbox >/dev/null 2>&1 

ENV WINDOW_MANAGER="openbox"

RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify
COPY data/novnc-index.html /opt/novnc/index.html

COPY data/start-vnc-session.sh /usr/bin/
RUN chmod +x /usr/bin/start-vnc-session.sh

RUN useradd builder -m -u 1000 && \
	passwd -d builder

RUN gem install mdl

USER builder
WORKDIR /usr/src

RUN echo "export DISPLAY=:0" >> ~/.bashrc
RUN echo "[ ! -e /tmp/.X0-lock ] && (/usr/bin/start-vnc-session.sh &> /tmp/display-\${DISPLAY}.log)" >> ~/.bashrc

CMD ["./scripts/build.sh"]
