FROM --platform=linux/x86_64 node:14.15.4-slim

RUN apt-get update
RUN apt-get install -y locales vim tmux
RUN locale-gen ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG ja_JP.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /home/node/app && chown node:node /home/node/app
WORKDIR /home/node/app

# ARG USERNAME=node

# RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
#     && mkdir /commandhistory \
#     && touch /commandhistory/.bash_history \
#     && chown -R $USERNAME /commandhistory \
#     && echo $SNIPPET >> "/home/$USERNAME/.bashrc"

USER node

COPY --chown=node:node package.json ./
RUN yarn install --ignore-optional && yarn cache clean
COPY --chown=node:node . .

CMD ["sh", "run.sh"]
