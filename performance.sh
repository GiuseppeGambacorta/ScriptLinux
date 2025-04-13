#!/bin/bash

# Verifica se lo script è eseguito come root
if [ "$(id -u)" -ne 0 ]; then
    echo "Questo script deve essere eseguito come root. Usa sudo."
    exit 1
fi

echo "Installazione di cpufrequtils in corso..."
apt update && apt install -y cpufrequtils

# Leggi la frequenza massima e impostala come minima
MAX_FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
echo "Frequenza massima rilevata: $MAX_FREQ"

echo "Impostazione frequenza minima = massima ($MAX_FREQ) per tutte le CPU..."
sudo cpufreq-set -d $MAX_FREQ

echo "Impostazione del governor 'performance' per tutte le CPU..."
sudo cpufreq-set -g performance

# Verifica dell'impostazione
echo -e "\nVerifica delle impostazioni:"
echo "Governor attuale:"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo -e "\nFrequenza minima impostata:"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq

echo -e "\nFrequenza massima disponibile:"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq

echo -e "\nFrequenza CPU attuale:"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

echo -e "\nImpostazioni completate. La CPU è configurata per funzionare sempre alla massima frequenza."
