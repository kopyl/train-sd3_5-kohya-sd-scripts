accelerate launch \
  --mixed_precision bf16 \
  sd-scripts/sd3_train.py \
  --pretrained_model_name_or_path models/sd3.5_large.safetensors \
  --clip_l models/clip_l.safetensors \
  --clip_g models/clip_g.safetensors \
  --t5xxl models/t5xxl_fp16.safetensors  \
  --save_model_as safetensors \
  --sdpa \
  --seed 1 \
  --gradient_checkpointing \
  --mixed_precision bf16 \
  --save_precision fp16 \
  --highvram \
  --cache_text_encoder_outputs_to_disk \
  --cache_latents_to_disk \
  --optimizer_type adafactor \
  --optimizer_args "relative_step=False" "scale_parameter=False" "warmup_init=False" "weight_decay=0.01" \
  --lr_scheduler constant \
  --max_grad_norm 0.0 \
  --full_bf16 \
  --vae_batch_size 4 \
  --dataset_config dataset-config.toml \
  --output_dir output \
  --apply_t5_attn_mask \
  --sample_prompts sample_prompts.txt \
  --output_name "${OUTPUT_MODEL_NAME:-finetuned-model}" \
  --save_every_n_epochs "${SAVE_EVERY_N_EPOCHS:-70}" \
  --max_train_epochs "${MAX_TRAIN_EPOCHS:-300}" \
  --sample_every_n_epochs "${SAMPLE_EVERY_N_EPOCHS:-10}"  \
  --learning_rate "${LEARNING_RATE:-1.1e-5}"