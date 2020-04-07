FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         python3-dev \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

RUN python3 -m pip --no-cache-dir install --upgrade \
    numpy \
    tqdm \
    matplotlib \
    torch \
    torchvision \
    torchaudio

RUN python3 -m pip --no-cache-dir install --upgrade \
    jupyter \
    jupyter_http_over_ws \
    ipykernel==5.1.1 \
    nbformat==4.4.0 && \
    jupyter serverextension enable --py jupyter_http_over_ws


RUN mkdir /workspace
WORKDIR /workspace
RUN chmod -R a+rwx .

EXPOSE 8888

RUN python3 -m ipykernel.kernelspec

CMD ["bash", "-c", "jupyter notebook --notebook-dir=/workspace --ip 0.0.0.0 --no-browser --allow-root"]
