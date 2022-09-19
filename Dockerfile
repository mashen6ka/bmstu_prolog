FROM swipl

RUN apt update && apt install -y python3

WORKDIR /data
CMD bash
