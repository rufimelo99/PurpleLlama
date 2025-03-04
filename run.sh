#!/bin/bash

#SBATCH --job-name=purplellama
#SBATCH --mem=100G

#SBATCH --gres=shard:20
#SBATCH --time=10:00:00
#SBATCH --mail-type=all
#SBATCH --mail-user=rufimelo99@gmail.com
#SBATCH --output=/home/u021521/SecurityAwareCL/lurm-%x-%j.out
#SBATCH --error=/home/u021521/SecurityAwareCL/slurm-%x-%j.err

# Prepare Environment
source activate /home/u021521/anaconda3/envs/cl/
echo "Submitting job"

cd PurpleLlama
export DATASETS=$PWD/CybersecurityBenchmarks/datasets

python -m CybersecurityBenchmarks.benchmark.run \
   --benchmark=mitre \
   --prompt-path="$DATASETS/mitre/mitre_example.json" \
   --response-path="$DATASETS/mitre_responses.json" \
   --judge-response-path="$DATASETS/mitre_judge_responses.json" \
   --stat-path="$DATASETS/mitre_stat.json" \
   --judge-llm="SELFHOSTED::deepseek-ai/DeepSeek-R1-Distill-Llama-8B::something" \
   --expansion-llm="SELFHOSTED::deepseek-ai/DeepSeek-R1-Distill-Llama-8B::something" \
   --llm-under-test="SELFHOSTED::deepseek-ai/DeepSeek-R1-Distill-Llama-8B::something"

