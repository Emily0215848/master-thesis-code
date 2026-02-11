function K_Best(Num_cc,Num_ii,Nt, Nr, N, SNR_DB, SNR, symbol_set, symbol_pattern, EE, M, m, Constellation_Mapping_Table, L, K)

total_ber = zeros(1,length(SNR));

ctrl_ZFMMSE = 1;
for cc = 1:Num_cc
    cc
    randn('seed',cc);  %change seed for AWGN
    rand('seed',cc);   %change seed for uniform
    ber = zeros(1,length(SNR));
    layer8 = zeros(1,length(SNR));

    for ss = 1:length(SNR)
        for ii = 1:Num_ii
            bb = round(rand(1,L)); %% Information Bits
            s = zeros(Nt,1);
            
            for kk = 1 : Nt
                for jj = 1 : M
                    if(bb(:,1+(kk-1)*log2(M):kk*log2(M)) == Constellation_Mapping_Table(jj,1:log2(M)))
                        s(kk,1) = Constellation_Mapping_Table(jj,end);
                        break;
                    end
                end
            end
            H = 1/sqrt(2) .* (randn(N,N) + 1j*randn(N,N));
            HH = [real(H) -imag(H); imag(H) real(H)];
            n = sqrt(0.5/SNR(ss)) * ( randn(N,1) + 1j*randn(N,1) ); %AWGN
            s = s / sqrt(EE);
            y = H * s + n;
            yy = [real(y); imag(y)];
            SS = zeros(1,2*Nt);
            for pp = 1:2*Nt
                SS(pp)  = pp;
            end
            %%%%%%%%%%way1%%%%%%%%%%%%%%%%
            %for pp = 1: 2*Nr
            %    for kk = pp: 2*Nt
            %        abs_HH(kk) = norm(HH((pp:2*Nr),kk));
            %    end
            %    [~,S] = min(abs_HH(pp:2*Nt));
            %    SS([pp S+pp-1]) = SS([S+pp-1 pp]); 
            %    HH(:,[pp S+pp-1]) = HH(:,[S+pp-1 pp]); 
            %end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%way2-last%%%%%%%%%%%%%%%%
            %for pp = 2*Nr:-1: 1
            %    for kk = 1 : pp
            %        abs_HH(kk) = norm(HH((pp:2*Nr),kk));
            %    end
            %    [~,S] = max(abs_HH(1 : pp));
            %    SS([pp S]) = SS([S pp]); 
            %    HH(:,[pp S]) = HH(:,[S pp]); 
            %end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %[GG SS] = sort(abs_HH);%GG是排序結果SS是索引
            %for kk = 1: 2*Nt
            %    HH_k(:,kk) = HH(:,SS(kk));%2Nr*2Nt
            %end
            %%%%%%%%%%MMSE%%%%%%%%%%%%%%%%%%%%%%%
            %norm_GG = zeros(1,8);
            %if ctrl_ZFMMSE == 1
            %   QQ = HH' * HH + (1/SNR(ss))* eye(2*N);
            %   GG = inv(QQ) * HH' ; % MMSE
            %if ctrl_ZFMMSE == 1
            %   QQ = HH' * HH + (1/SNR(ss))* eye(2*N);
            %   GG = inv(QQ) * HH' ; % MMSE
            %elseif ctrl_ZFMMSE == 2
            %   QQ = inv(HH' * HH);
            %   GG = QQ*HH'; % ZF
            %end
            
            %for gg = 1 : 2*N
            %    norm_GG(gg) = norm( GG(gg,:) )^2;%norm只要算4個，因為前後對稱       
            %end  % for gg = 1 : Nt
            %[gg,SS] = sort(norm_GG,"descend");%雜訊power由大排到小，因為R是從最後一列開始偵測
            %HH_k = HH(:,SS);
            %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%QR_decomposition%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [arg_rr,SS] = cordic_QR_new([HH yy],6,SS);%2Nr*(2Nt+1)[yy_hat,R] = CORDIC_bin(yy, HH_k,6)
            RR_k   = arg_rr(1:2*Nt,1:2*Nt);%2Nt*2Nt
           
            yy_k   = arg_rr(1:2*Nt,end);%2Nt*1
            %s8 = yy_k(8)/RR_k(8,8);
            %s8 = judge(s8,M,1);
            %[Q, RR_k] = qr(HH_k);
            %yy_k = Q' * yy_k;
            %%%%%%%%%%%%%%%%%%%%%%%%%K_best core%%%%%%%%%%%%%%%%%%%%%%%%%%
            %K_best = zeros(2*N, K); % initialized k's best path value
            %K_best(2*Nt,1) = judge(yy_k(2*Nt,1), RR_k(2*Nt,2*Nt), M);

            %interference = sum(RR_k(2*Nt-1,2*Nt) * K_best(2*Nt, 1));
            %Li = yy_k(2*Nt-1) - interference;
            %K_best(2*Nt-1,1) = judge(Li, RR_k(2*Nt-1,2*Nt-1), M);
            
            
            s_hat = KB_0527(yy_k, RR_k, N, symbol_pattern / sqrt(EE), K, SS, M);
            
            %for kk = 1:2*Nt
            %    Sign_y = sign_func(yy_k(ss));
            %end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            s_e = (s_hat * sqrt(EE));
            s_hat = Slicing(real(s_e),M,Nt) + 1j*Slicing(imag(s_e),M,Nt); %sort by SS
           
            bb_hat =zeros(1,L); %% Information Bits
            for kk = 1 : Nt
                for jj = 1 : M
                    if(Constellation_Mapping_Table(jj,end) ==  s_hat(kk))
                        bb_hat(:,1+(kk-1)*log2(M):kk*log2(M)) = Constellation_Mapping_Table(jj,1:log2(M));
                        break;
                    end
                end
            end

            ber(1,ss) = ber(1,ss) + sum(bb_hat ~= bb);
           

        end %for ii = 1:100
    end  %for ss = 1:length(SNR)
    
    total_ber = total_ber + ber;
   

end  %for cc = 1:Num

total_ber_average = total_ber/Num_cc/Num_ii/L;
figure,
semilogy(SNR_DB, total_ber_average, 'b-*');
xlabel('SNR');
ylabel('Average BER');
title(M + "\_QAM");
hold on;
grid;
axis([min(SNR_DB) max(SNR_DB) 0.001 1]);
str2 = strcat('K-best Nt-',num2str(Nt),' Nr-',num2str(Nr));
legend(str2);
hold on;
eval (['save ' 'K-best-Sorted-Rii-KB_0527_1_norm_' '_Nt=' num2str(Nt) '_Nr=' num2str(Nr) '_' num2str(M) 'QAM' '_Num_cc=' num2str(Num_cc) '_Num_ii=' num2str(Num_ii) '_K=' num2str(K) '.mat  total_ber_average SNR_DB']);
end