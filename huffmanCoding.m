clc;
clear;
close all;

data = 'INSTITUTE';

% Convert characters to numeric (ASCII)
x = double(data);

% Find unique symbols
symbols_unique = unique(x);

% Count occurrences
count = zeros(1, length(symbols_unique));
for i = 1:length(symbols_unique)
    count(i) = sum(x == symbols_unique(i));
end

% Compute probabilities
prob = count / sum(count);   % This guarantees sum(prob) = 1

% Convert to characters for display
symbols = cell(1, length(symbols_unique));
for i = 1:length(symbols_unique)
    symbols{i} = char(symbols_unique(i));
end

% Sort probabilities (descending)
[prob, idx] = sort(prob, 'descend');
symbols = symbols(idx);

% Huffman coding
[code, avglen] = huffmandict(symbols, prob);

% Codeword lengths
len = zeros(1, length(prob));
for i = 1:length(prob)
    len(i) = length(code{i,2});
end

% Entropy calculation
entr = 0;
for i = 1:length(prob)
    entr = entr - prob(i) * log2(prob(i));
end

% Average codeword length
avglen_huffman = sum(len .* prob);

% Efficiency
eff_huffman = (entr / avglen_huffman) * 100;

% Display results
disp('Data:');
disp(data);

disp('Probabilities:');
disp(prob);

disp('Entropy:');
disp(entr);

disp('Average Code Length:');
disp(avglen_huffman);

disp('Efficiency (%):');
disp(eff_huffman);