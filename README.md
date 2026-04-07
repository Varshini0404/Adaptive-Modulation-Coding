# 📡 Adaptive Modulation and Coding (AMC) Simulation

## 📌 Overview

This project simulates **Adaptive Modulation** in a digital communication system over an AWGN channel.

It compares:

* Fixed Modulation Schemes (BPSK, QPSK, 16-QAM, 64-QAM)
* Adaptive Modulation based on SNR

## ⚙️ Features

* BER vs SNR analysis
* Throughput vs SNR comparison
* Adaptive modulation switching logic
* Constellation diagrams for all modulation schemes

## 📊 Modulation Schemes Used

* BPSK
* QPSK
* 16-QAM
* 64-QAM

## 🧠 Adaptive Logic

* SNR < 6 dB → BPSK
* 6–12 dB → QPSK
* 12–18 dB → 16-QAM
* > 18 dB → 64-QAM

## 📈 Outputs

* BER vs SNR graph (log scale)
* Throughput vs SNR graph
* Constellation diagrams

## 🛠️ Tools Used

* MATLAB / GNU Octave

## 🚀 How to Run

1. Open MATLAB or Octave
2. Run the script:

   ```matlab
   adaptive_modulation
   ```

## 📷 Sample Results

(Add your screenshots here)

## 👩‍💻 Author

Varshini (ECE Student)
