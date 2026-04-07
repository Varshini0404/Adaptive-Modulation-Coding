% Clear environment
clc; clear; close all;

% Parameters
SNR_dB = 0:2:20; % Signal-to-Noise Ratio (in dB)
SNR = 10.^(SNR_dB/10); % Convert SNR from dB to linear scale

% Modulation schemes: BPSK, QPSK, 16-QAM, 64-QAM
modulations = {'BPSK', 'QPSK', '16-QAM', '64-QAM'};
ber_fixed = zeros(length(modulations), length(SNR_dB)); % BER for fixed modulations
ber_adaptive = zeros(1, length(SNR_dB)); % BER for adaptive modulation
throughput_fixed = zeros(length(modulations), length(SNR_dB)); % Throughput for fixed modulations
throughput_adaptive = zeros(1, length(SNR_dB)); % Throughput for adaptive modulation

% Theoretical BER for different modulation schemes (AWGN channel)
for i = 1:length(modulations)
    switch modulations{i}
        case 'BPSK'
            ber_fixed(i, :) = 0.5 * erfc(sqrt(SNR)); % BPSK BER
            throughput_fixed(i, :) = 1 * (1 - ber_fixed(i, :)); % Throughput: 1 bps/Hz
        case 'QPSK'
            ber_fixed(i, :) = 0.5 * erfc(sqrt(SNR/2)); % QPSK BER
            throughput_fixed(i, :) = 2 * (1 - ber_fixed(i, :)); % Throughput: 2 bps/Hz
        case '16-QAM'
            ber_fixed(i, :) = 3/4 * erfc(sqrt(SNR/10)); % 16-QAM BER approximation
            throughput_fixed(i, :) = 4 * (1 - ber_fixed(i, :)); % Throughput: 4 bps/Hz
        case '64-QAM'
            ber_fixed(i, :) = 7/12 * erfc(sqrt(SNR/42)); % 64-QAM BER approximation
            throughput_fixed(i, :) = 6 * (1 - ber_fixed(i, :)); % Throughput: 6 bps/Hz
    end
end

% Adaptive modulation logic
for j = 1:length(SNR_dB)
    if SNR_dB(j) < 6
        % BPSK
        ber_adaptive(j) = 0.5 * erfc(sqrt(SNR(j)));
        throughput_adaptive(j) = 1 * (1 - ber_adaptive(j));
    elseif SNR_dB(j) < 12
        % QPSK
        ber_adaptive(j) = 0.5 * erfc(sqrt(SNR(j)/2));
        throughput_adaptive(j) = 2 * (1 - ber_adaptive(j));
    elseif SNR_dB(j) < 18
        % 16-QAM
        ber_adaptive(j) = 3/4 * erfc(sqrt(SNR(j)/10));
        throughput_adaptive(j) = 4 * (1 - ber_adaptive(j));
    else
        % 64-QAM
        ber_adaptive(j) = 7/12 * erfc(sqrt(SNR(j)/42));
        throughput_adaptive(j) = 6 * (1 - ber_adaptive(j));
    end
end

% Plot BER vs. SNR
figure;
semilogy(SNR_dB, ber_fixed(1, :), 'b-o', 'LineWidth', 1.5); hold on;
semilogy(SNR_dB, ber_fixed(2, :), 'r-s', 'LineWidth', 1.5);
semilogy(SNR_dB, ber_fixed(3, :), 'g-^', 'LineWidth', 1.5);
semilogy(SNR_dB, ber_fixed(4, :), 'k-d', 'LineWidth', 1.5);
semilogy(SNR_dB, ber_adaptive, 'm-*', 'LineWidth', 2);
grid on; xlabel('SNR (dB)'); ylabel('BER');
title('BER vs. SNR for Fixed and Adaptive Modulation');
legend('BPSK (Fixed)', 'QPSK (Fixed)', '16-QAM (Fixed)', '64-QAM (Fixed)', 'Adaptive Modulation');
ylim([1e-5 1]);

% Plot Throughput vs. SNR
figure;
plot(SNR_dB, throughput_fixed(1, :), 'b-o', 'LineWidth', 1.5); hold on;
plot(SNR_dB, throughput_fixed(2, :), 'r-s', 'LineWidth', 1.5);
plot(SNR_dB, throughput_fixed(3, :), 'g-^', 'LineWidth', 1.5);
plot(SNR_dB, throughput_fixed(4, :), 'k-d', 'LineWidth', 1.5);
plot(SNR_dB, throughput_adaptive, 'm-*', 'LineWidth', 2);
grid on; xlabel('SNR (dB)'); ylabel('Throughput (bps/Hz)');
title('Throughput vs. SNR for Fixed and Adaptive Modulation');
legend('BPSK (Fixed)', 'QPSK (Fixed)', '16-QAM (Fixed)', '64-QAM (Fixed)', 'Adaptive Modulation');
ylim([0 6.5]);
%% Constellation Diagrams for Octave

% Number of points to plot
N = 1000;

figure;

% ---- BPSK ----
data = randi([0 1], N, 1);
bpsk = 2*data - 1; % Map 0->-1, 1->+1
subplot(2,2,1);
plot(real(bpsk), zeros(size(bpsk)), 'o');
title('BPSK Constellation');
xlabel('In-Phase'); ylabel('Quadrature'); grid on; axis equal;

% ---- QPSK ----
data = randi([0 3], N, 1);
qpsk = (1/sqrt(2)) * ((mod(data,2)*2-1) + 1j*(floor(data/2)*2-1));
subplot(2,2,2);
plot(real(qpsk), imag(qpsk), 'o');
title('QPSK Constellation');
xlabel('In-Phase'); ylabel('Quadrature'); grid on; axis equal;

% ---- 16-QAM ----
data = randi([0 15], N, 1);
I = 2*(mod(data,4)-1.5);
Q = 2*(floor(data/4)-1.5);
qam16 = (I + 1j*Q)/sqrt(10);
subplot(2,2,3);
plot(real(qam16), imag(qam16), 'o');
title('16-QAM Constellation');
xlabel('In-Phase'); ylabel('Quadrature'); grid on; axis equal;

% ---- 64-QAM ----
data = randi([0 63], N, 1);
I = 2*(mod(data,8)-3.5);
Q = 2*(floor(data/8)-3.5);
qam64 = (I + 1j*Q)/sqrt(42);
subplot(2,2,4);
plot(real(qam64), imag(qam64), 'o');
title('64-QAM Constellation');
xlabel('In-Phase'); ylabel('Quadrature'); grid on; axis equal;



