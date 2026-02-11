clear all ; close all ;
Num_cc = 10000; % trials
Num_ii = 10; %trammit datas
N = 2;
Nt = N; %發
Nr = N; %收
SNR_DB = [0:5:25];
SNR = 10 .^ (SNR_DB./10); %SNR DB轉倍率

M= 4; 
d = 2; 
EE =(M-1)*((d^2)/2)/3; % Energy 

m = log2(M);
K = 8;
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
end   
Constellation_Mapping_Table = [codebook symbol_set.'];

K_Best(Num_cc,Num_ii,Nt, Nr, N, SNR_DB, SNR, symbol_set, symbol_pattern, EE, M, m, Constellation_Mapping_Table, L, K);