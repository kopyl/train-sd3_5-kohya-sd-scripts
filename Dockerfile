FROM python:3.10.15-slim

ENV PYTHONUNBUFFERED=1
ENV TOKENIZERS_PARALLELISM=false

# models directory contains 4 Stable Diffusion 3.5 Large models from https://huggingface.co/stabilityai/stable-diffusion-3.5-large:
    # sd3.5_large.safetensors
    # clip_l.safetensors
    # clip_g.safetensors
    # t5xxl_fp16.safetensors
COPY models /models
# sd-scripts: https://github.com/kohya-ss/sd-scripts/tree/e425996a5953f0479384e70b6490e751c2d00b1f
COPY sd-scripts /sd-scripts

WORKDIR /sd-scripts
RUN pip install -r requirements.txt
WORKDIR /
RUN pip install opencv-python-headless==4.10.0.84
RUN pip install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu124

COPY run-training.sh /run-training.sh
COPY dataset-config.toml /dataset-config.toml
COPY sample_prompts.txt /sample_prompts.txt

COPY Dockerfile .
COPY README.md .

CMD ["bash", "run-training.sh"]