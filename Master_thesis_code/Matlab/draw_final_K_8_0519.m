clear all; close all;
Nt = 4;
Nr = 4;
M = 64;
SNR_DB = [0:2:20]; 
SNR = 10 .^ (SNR_DB./10); 

% prune unwanted ber
% total_ser_average(:, 2:2:end) = []; 

total_ber_average = cell2mat(struct2cell(load('K-best-Sorted-Rii-0519_1_K2_Nt=4_Nr=4_64QAM_Num_cc=1000_Num_ii=10_K=4.mat','total_ber_average')));%1~8
semilogy(SNR_DB, total_ber_average(1:length(SNR_DB)), 'b-*');%第一、二層只選最近的點(等同Slicing)，第三層之後都是K=2
hold on;

total_ber_average = cell2mat(struct2cell(load('K-best-Sorted-Rii-0519_4_K2_Nt=4_Nr=4_64QAM_Num_cc=1000_Num_ii=10_K=4.mat','total_ber_average')));%8~1
semilogy(SNR_DB, total_ber_average(1:length(SNR_DB)), 'r-s');%第一層只選最近的點(等同Slicing)，第二層之後都是K=2
hold on;

total_ber_average = cell2mat(struct2cell(load('K-best-Sorted-Rii-0519_3_K2_Nt=4_Nr=4_64QAM_Num_cc=1000_Num_ii=10_K=4.mat','total_ber_average')));%8~1
semilogy(SNR_DB, total_ber_average(1:length(SNR_DB)), 'b-s');%第一層只選最近的點(等同Slicing)，第二層之後都是K=2
hold on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel('SNR (dB)');
ylabel('Average BER');
%title("K-best Nt=Nr=4 K=10 " + M + "\_QAM");
axis([min(SNR_DB) max(SNR_DB) 0.001 1]);

%str1 = strcat('MMSE');
%str11 = strcat('Traditional K-Best K=8');
%str10 = strcat('K-Best Sorted-Rii K=8');%sorting 1norm KB2norm
%str13 = strcat('K-Best Sorted-Rii K=2');
str15 = strcat('1');%Partial QR-Slicing with K-Best Sorted-Rii
str16 = strcat('4');%
str17 = strcat('3');%
legend(str15,str16,str17);
legend('Location', 'southwest'); % 将图例移动到左下角
hold on;
grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%