function gray_code = graycode(M) 
    gray_code = [0, 1].'; % initialize with BPSK
    for i = 1 : log2(M)-1
        gray_code = [gray_code ; flipud(gray_code)]; % mirror the gray_code
        mirror_length = length(gray_code(:, i)); % calculate vector length after mirroring
        padding_one = zeros(mirror_length, 1); % mirror upper side padding 0
        padding_one(mirror_length/2+1 : end) = 1; % mirror lower side padding 1
        gray_code = [padding_one gray_code]; % padding col vector at left side
    end
end