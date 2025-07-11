fi = inp('Kryptos.txt');
pt11 = fi(1:65);
pt22 = fi(64:436);
pt33 = fi(437:773);
pt44 = fi(774:end);
%%
i1 = char(strcat("EMUFPHZLRFAXYUSDJKZLDKRNSHGNFIVJ",...
                 "YQTQUXQBQVYUVLLTREVJYQTMKYRDMFD" ,...
                 "VFPJUDEEHZWETZYVGWHKKQETGFQJNCE" ,...
                 "GGWHKK?DQMCPFQZDQMMIAGPFXHQRLG"  ,...
                 "TIMVMZJANQLVKQEDAGDVFRPJUNGEUNA" ,...
                 "QZGZLECGYUXUEENJTBJLBQCRTBJDFHRR",...
                 "YIZETKZEMVDUFKSJHKFWHKUWQLSZFTI" ,...
                 "HHDDDUVH?DWKBFUFPWNTDFIYCUQZERE" ,...
                 "EVLDKFEZMOQQJLTTUGSYQPFEUNLAVIDX",...
                 "FLGGTEZ?FKZBSFDQVGOGIPUFXHHDRKF" ,...
                 "FHQNTGPUAECNUVPDJMQCLQUMUNEDFQ"  ,...
                 "ELZZVRRGKFFVOEEXBDMVPNFQXEZLGRE" ,...
                 "DNQFMPNZGLFLPMRJQYALMGNUVPDXVKP" ,...
                 "DQUMEBEDMHDAFMJGZNUPLGESWJLLAETG"));

i2 = char(strcat("ENDYAHROHNLSRHEOCPTEOIBIDYSHNAIA" ,...
                 "CHTNREYULDSLLSLLNOHSNOSMRWXMNE"   ,...
                 "TPRNGATIHNRARPESLNNELEBLPIIACAE"  ,...
                 "WMTWNDITEENRAHCTENEUDRETNHAEOE"   ,...
                 "TFOLSEDTIWENHAEIOYTEYQHEENCTAYCR" ,...
                 "EIFTBRSPAMHHEWENATAMATEGYEERLB"   ,...
                 "TEEFOASFIOTUETUAEOTOARMAEERTNRTI" ,...
                 "BSEDDNIAAHTTMSTEWPIEROAGRIEWFEB"  ,...
                 "AECTDDHILCEIHSITEGOEAOSDDRYDLORIT",...
                 "RKLMLEHAGTDHARDPNEOHMGFMFEUHE"    ,...
                 "ECDMRIPFEIMEHNLSSTTRTVDOHW?OBKR"  ,...
                 "UOXOGHULBSOLIFBBWFLRVQQPRNGKSSO"  ,...
                 "TWTQSJQSSEKZZWATJKLUDIAWINFBNYP"  ,...
                 "VTTMZFPKWGDKZXTJCDIGKUHUAUEKCAR"));

% K1 section
pt1 = i1(1:63);         % Initial Structing
out  = vig('KRYPTOS','PALIMPSEST',pt1);
out = strcat(out,'.');
out = reshape(out.',32,[]).';

% K2 section
pt2 = i1(64:end);       % Initial Structing
q2  = find(pt2=='?');   % Find locations of ?'s
pt2 = erase(pt2,'?');
out2 = vig('KRYPTOS','ABSCISSA',  pt2);
% out2 = strcat(out2,' ');
out2 = reshape(out2.',37,[]).';


% K3 section
pt3 = i2(1:337);        % Initial Structing
q3  = find(pt3=='?');   % Find locations of ?'s
pt3 = erase(pt3,'?');
out3 = transpo(pt3);
% disp(out3);

% K4 section
pt4 = i2(338:end);


% disp(out)
% disp(" ")
% disp(out2)
% disp(" ")
% disp(out3)
% disp(" ")
% disp(out4)
i3 = i2(338:end);

% clear('pt1','pt2','pt3','pt4','i1','i2');
%% Frequency analysis of K4
b = [""];
% for j=1:length(i3)
b = strings([length(i3),length(i3)]);
s = string(num2cell(i3));
for j=1:length(i3)
    b(j,j:end) = s(1:end-j+1);
end

f = [];
count = 0;
for i=1:length(i3)-1
    for j=1:length(i3)
        if b(1,j) == b(i+1,j)
            count = count + 1;
        else
            count = count + 0;
        end
        
    end
    f = [f; count];
    count = 0;
end
%%
% D = transpo2(A)
%%
% [freq_des char_des] = count_letters(i1);
% disp(char_des);
% clear("i1","char_des","freq_des","x","y");
%%

% letter frequency analysis
function [f c] = count_letters(text)

% Convert text to lowercase to make analysis case-insensitive
text = lower(text);

% Get unique characters from the text
unique_chars = unique(text);

% Create a cell array to store letters and frequencies
letter_frequency = cell(length(unique_chars), 2);

% Count occurrences of each character and store in cell array
for i = 1:length(unique_chars)
    letter_frequency{i, 1} = unique_chars(i);
    letter_frequency{i, 2} = sum(text == unique_chars(i));
end

% Sort the results by frequency in descending order
f = sortrows(letter_frequency, 2, 'descend');
c = sortrows(letter_frequency, 1, 'ascend');

end
% Vigenere cipher function
function x = vig(k1,k2,txts)
    full = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    al = full;
    headings = al;
    for i=1:length(k1)
        headings = erase(headings, k1(i));
    end
    headings = strcat(k1,headings);
    total = [];
    for i=1:length(k2)
        lc = find(headings==k2(i));
        temp = strcat(headings(lc:end),headings(1:lc));
        total = strcat(total,temp);
    end
    total = char(total);
    a = [""];
    count = 1;
    for j=1:length(k2)
        for i=1:27
            a(j,i) = string(total(count));
            count = count + 1;
        end
    end  

    i=1;
    k=1;
    r = 1; c = 1;
    out2 = strings([12,33]);
    while i < length(txts)
        tt = a(k,:);
        out2(r,c) = headings(find(tt==txts(i),1,'first'));
    %     disp(headings(find(tt==inpt2(i))))
        k = k + 1;
        c = c + 1;
        if c == 32
            r = r + 1;
            c = 1;
        else
        end
        if k > length(k2)
            k = 1;
        end
        i = i + 1;
    end
    tt = a(k,:);
    out2(r,c) = headings(find(tt==txts(end)));
    x = char(erase(strjoin(out2')," "));
end

%Transposition cipher function
function x = transpo(pt3)
    % Find factors of k3 length
    N = length(pt3);
    K = 1:ceil(sqrt(N));
    D = K(rem(N,K)==0);
    D = [D sort(N./D)];

    sub = reshape(pt3.',16,[]).';   % Reshape into proper rectangle
%     disp(sub)
    sub = rot90(sub,3);             % Rotate 270 deg ccw or 90 cw
%     disp(" ")
%     disp(sub)
    lng = 12;                       % Guessed length of rectangle
    lty = length(pt3);
    tup = strings([28,1]);
    sub = reshape(sub.',1,[]);
    for i=1:28
        see = lty-(lng*(i-1));
        tnd = lty-(lng*i)+1;
%         disp(see)
%         disp(tnd)
%         disp(" ")
        tup(29-i,1) = sub(tnd:see);
    end
%     disp(tup)
    p = '';
    for i =1:size(tup,1)
        p = strcat(p,tup(29-i,1));
    end
    p = char(p);
    p = reshape(p.',12,[]).';   % Reshape into proper rectangle
    p = rot90(p,3);             % Rotate 270 deg ccw or 90 cw
    out3 = fliplr(p);
    x = out3;
end

%Transposition cipher function
function x = transpo2(pt3)
    % Find factors of k3 length
    N = length(pt3);
    K = 1:ceil(sqrt(N));
    D = K(rem(N,K)==0);
    D = [D sort(N./D)];

    sub = reshape(pt3.',16,[]).';   % Reshape into proper rectangle
%     disp(sub)
    sub = rot90(sub,3);             % Rotate 270 deg ccw or 90 cw
%     disp(" ")
%     disp(sub)
    lng = 12;                       % Guessed length of rectangle
    lty = length(pt3);
    tup = strings([28,lng]);
    sub = reshape(sub.',1,[]);
    for i=1:28
        see = lty-(lng*(i-1));
        tnd = lty-(lng*i)+1;
        tup(29-i,:) = sub(tnd:see);
    end
    disp(tup)
    out3 = rot90(tup,3);
%     p = '';
%     for i =1:size(tup,1)
%         p = strcat(p,tup(29-i,:));
%     end
%     p = char(p);
%     p = reshape(p.',12,[]).';   % Reshape into proper rectangle
%     p = rot90(p,3);             % Rotate 270 deg ccw or 90 cw
%     out3 = fliplr(p);
    x = out3;
end
%%

function fileContent = inp(fileName) % MATLAB Code to Import a Text File
    % Specify the file name (ensure the file is in the same folder as the script)
    % fileName = 'example.txt';

    % Open the file in read mode
    fileID = fopen(fileName, 'r');

    % Check if the file opened successfully
    if fileID == -1
        error('Could not open the file. Check the file name and path.');
    end

    % Read the content of the file as text
    fileContent = fread(fileID, '*char')';

    % Close the file
    fclose(fileID);

    % Display the imported text
%     disp('File content:');
%     disp(fileContent);
end
