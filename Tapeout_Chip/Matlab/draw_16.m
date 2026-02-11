clear all; close all;
Nt = 2;
Nr = 2;
M = 4;
SNR_DB = [0:5:25]; 
SNR = 10 .^ (SNR_DB./10); 

% prune unwanted ber
% total_ser_average(:, 2:2:end) = []; 

total_ber_average = cell2mat(struct2cell(load('Sorted_Nt=2_Nr=2_4QAM_Num_cc=10000_Num_ii=10.mat','total_ber_average')));
semilogy(SNR_DB, total_ber_average(1:length(SNR_DB)), 'b-<');
hold on;
total_ber_average = cell2mat(struct2cell(load('Unsorted_Nt=2_Nr=2_4QAM_Num_cc=10000_Num_ii=10.mat','total_ber_average')));
semilogy(SNR_DB, total_ber_average(1:length(SNR_DB)), 'g-*');
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel('SNR');
ylabel('Average BER');
%title(M + "\_QAM");
axis([min(SNR_DB) max(SNR_DB) 0.00001 1]);
str6 = strcat('Sorted');
str5 = strcat('Unsorted');

legend(str6, str5);
hold on;
grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%