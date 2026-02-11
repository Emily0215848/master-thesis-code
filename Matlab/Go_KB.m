clear all ; close all ;
Num_cc = 1000; % trials %M=16, 10000 %M=other, 1000
Num_ii = 10; %trammit datas
N = 4;
Nt = N; %發
Nr = N; %收 

M= 64; 
d = 2; 
EE =(M-1)*((d^2)/2)/3; % Energy %符元平均能量Es=E{|s_i|^2}

if M==256
    SNR_DB = [0:2:24];
    K = 8;
else
    SNR_DB = [0:2:20];
    K = 2;
end
SNR = 10 .^ (SNR_DB./10); %SNR DB轉倍率

m = log2(M);
%K = 8;
L = m*Nt;
codebook = graycode(M);

if M == 4
    symbol_set = [1+j*1, -1+j*1, -1-j*1, 1-j*1]; %QPSK
    symbol_pattern = -sqrt(M)+1:2:sqrt(M)-1; % symbol_pattern = [-1, 1] ;
elseif M == 16
    symbol_set = [-3+j*3, -1+j*3, 1+j*3, 3+j*3];
    symbol_set = [symbol_set 3+j*1, 1+j*1, -1+j*1, -3+j*1];
    symbol_set = [symbol_set -3-j*1, -1-j*1, 1-j*1, 3-j*1];
    symbol_set = [symbol_set 3-j*3, 1-j*3, -1-j*3, -3-j*3]; %16QAM
    symbol_pattern = -sqrt(M)+1:2:sqrt(M)-1; % symbol_pattern = [-3, -1, 1, 3] ;
elseif M == 64
    symbol_set = [-7+j*7, -5+j*7, -3+j*7, -1+j*7, 1+j*7, 3+j*7, 5+j*7, 7+j*7];
    symbol_set = [symbol_set 7+j*5, 5+j*5, 3+j*5, 1+j*5, -1+j*5, -3+j*5, -5+j*5, -7+j*5];
    symbol_set = [symbol_set -7+j*3, -5+j*3, -3+j*3, -1+j*3, 1+j*3, 3+j*3, 5+j*3, 7+j*3];
    symbol_set = [symbol_set 7+j*1, 5+j*1, 3+j*1, 1+j*1, -1+j*1, -3+j*1, -5+j*1, -7+j*1];
    symbol_set = [symbol_set -7+j*-1, -5+j*-1, -3+j*-1, -1+j*-1, 1+j*-1, 3+j*-1, 5+j*-1, 7+j*-1];
    symbol_set = [symbol_set 7+j*-3, 5+j*-3, 3+j*-3, 1+j*-3, -1+j*-3, -3+j*-3, -5+j*-3, -7+j*-3];
    symbol_set = [symbol_set -7+j*-5, -5+j*-5, -3+j*-5, -1+j*-5, 1+j*-5, 3+j*-5, 5+j*-5, 7+j*-5];
    symbol_set = [symbol_set 7+j*-7, 5+j*-7, 3+j*-7, 1+j*-7, -1+j*-7, -3+j*-7, -5+j*-7, -7+j*-7]; %64QAM
    symbol_pattern = -sqrt(M)+1:2:sqrt(M)-1; % symbol_pattern = [-7, -5, -3, -1, 1, 3, 5, 7] 
elseif M == 256
    symbol_set = [-15+j*15, -13+j*15, -11+j*15, -9+j*15, -7+j*15, -5+j*15, -3+j*15, -1+j*15, 1+j*15, 3+j*15, 5+j*15, 7+j*15, 9+j*15, 11+j*15, 13+j*15, 15+j*15];
    symbol_set = [symbol_set 15+j*13, 13+j*13, 11+j*13, 9+j*13, 7+j*13, 5+j*13, 3+j*13, 1+j*13, -1+j*13, -3+j*13, -5+j*13, -7+j*13, -9+j*13, -11+j*13, -13+j*13, -15+j*13];
    symbol_set = [symbol_set -15+j*11, -13+j*11, -11+j*11, -9+j*11, -7+j*11, -5+j*11, -3+j*11, -1+j*11, 1+j*11, 3+j*11, 5+j*11, 7+j*11, 9+j*11, 11+j*11, 13+j*11, 15+j*11];
    symbol_set = [symbol_set 15+j*9, 13+j*9, 11+j*9, 9+j*9, 7+j*9, 5+j*9, 3+j*9, 1+j*9, -1+j*9, -3+j*9, -5+j*9, -7+j*9, -9+j*9, -11+j*9, -13+j*9, -15+j*9];
    symbol_set = [symbol_set -15+j*7, -13+j*7, -11+j*7, -9+j*7, -7+j*7, -5+j*7, -3+j*7, -1+j*7, 1+j*7, 3+j*7, 5+j*7, 7+j*7, 9+j*7, 11+j*7, 13+j*7, 15+j*7];
    symbol_set = [symbol_set 15+j*5, 13+j*5, 11+j*5, 9+j*5, 7+j*5, 5+j*5, 3+j*5, 1+j*5, -1+j*5, -3+j*5, -5+j*5, -7+j*5, -9+j*5, -11+j*5, -13+j*5, -15+j*5];
    symbol_set = [symbol_set -15+j*3, -13+j*3, -11+j*3, -9+j*3, -7+j*3, -5+j*3, -3+j*3, -1+j*3, 1+j*3, 3+j*3, 5+j*3, 7+j*3, 9+j*3, 11+j*3, 13+j*3, 15+j*3];
    symbol_set = [symbol_set 15+j*1, 13+j*1, 11+j*1, 9+j*1, 7+j*1, 5+j*1, 3+j*1, 1+j*1, -1+j*1, -3+j*1, -5+j*1, -7+j*1, -9+j*1, -11+j*1, -13+j*1, -15+j*1]; %64QAM
    symbol_set = [symbol_set -15+j*-1, -13+j*-1, -11+j*-1, -9+j*-1, -7+j*-1, -5+j*-1, -3+j*-1, -1+j*-1, 1+j*-1, 3+j*-1, 5+j*-1, 7+j*-1, 9+j*-1, 11+j*-1, 13+j*-1, 15+j*-1];
    symbol_set = [symbol_set 15+j*-3, 13+j*-3, 11+j*-3, 9+j*-3, 7+j*-3, 5+j*-3, 3+j*-3, 1+j*-3, -1+j*-3, -3+j*-3, -5+j*-3, -7+j*-3, -9+j*-3, -11+j*-3, -13+j*-3, -15+j*-3];
    symbol_set = [symbol_set -15+j*-5, -13+j*-5, -11+j*-5, -9+j*-5, -7+j*-5, -5+j*-5, -3+j*-5, -1+j*-5, 1+j*-5, 3+j*-5, 5+j*-5, 7+j*-5, 9+j*-5, 11+j*-5, 13+j*-5, 15+j*-5];
    symbol_set = [symbol_set 15+j*-7, 13+j*-7, 11+j*-7, 9+j*-7, 7+j*-7, 5+j*-7, 3+j*-7, 1+j*-7, -1+j*-7, -3+j*-7, -5+j*-7, -7+j*-7, -9+j*-7, -11+j*-7, -13+j*-7, -15+j*-7];
    symbol_set = [symbol_set -15+j*-9, -13+j*-9, -11+j*-9, -9+j*-9, -7+j*-9, -5+j*-9, -3+j*-9, -1+j*-9, 1+j*-9, 3+j*-9, 5+j*-9, 7+j*-9, 9+j*-9, 11+j*-9, 13+j*-9, 15+j*-9];
    symbol_set = [symbol_set 15+j*-11, 13+j*-11, 11+j*-11, 9+j*-11, 7+j*-11, 5+j*-11, 3+j*-11, 1+j*-11, -1+j*-11, -3+j*-11, -5+j*-11, -7+j*-11, -9+j*-11, -11+j*-11, -13+j*-11, -15+j*-11];
    symbol_set = [symbol_set -15+j*-13, -13+j*-13, -11+j*-13, -9+j*-13, -7+j*-13, -5+j*-13, -3+j*-13, -1+j*-13, 1+j*-13, 3+j*-13, 5+j*-13, 7+j*-13, 9+j*-13, 11+j*-13, 13+j*-13, 15+j*-13];
    symbol_set = [symbol_set 15+j*-15, 13+j*-15, 11+j*-15, 9+j*-15, 7+j*-15, 5+j*-15, 3+j*-15, 1+j*-15, -1+j*-15, -3+j*-15, -5+j*-15, -7+j*-15, -9+j*-15, -11+j*-15, -13+j*-15, -15+j*-15]; %64QAM
    symbol_pattern = -sqrt(M)+1:2:sqrt(M)-1; % symbol_pattern = [-15, -13, -11, -9, -7, -5, -3, -1, 1, 3, 5, 7, 9, 11, 13, 15] 
end                                          % symbol_pattern = [15, 13, 11, 9, 7, 5, 3, 1, -1, -3, -5, -7, -9, -11, -13, -15]    
Constellation_Mapping_Table = [codebook symbol_set.'];

K_Best(Num_cc,Num_ii,Nt, Nr, N, SNR_DB, SNR, symbol_set, symbol_pattern, EE, M, m, Constellation_Mapping_Table, L, K);