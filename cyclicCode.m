clc;
clear;

n = 7;
k = 4;

pol = cyclpoly(n, k);

M = de2bi(0:2^k-1, k, 'left-msb');

if k >= n
    error('Message length (k) must be less than codeword length (n).');
end



factors = gfprimfd(n-k, 'min', 2);

if isempty(factors)
    error('No generator polynomial found for the given (n, k).');
end

g = factors(1, :);

messages = de2bi(0:2^k-1, k, 'left-msb');

codewords = zeros(2^k, n);

for i = 1:2^k
    message_poly = messages(i, :);
    codeword_poly = mod(conv(message_poly, g), 2);
    codeword_poly = codeword_poly(1:n);
    codewords(i, :) = codeword_poly;
end

cyclic_code = codewords;

disp('Messages and Codewords:');
disp([messages codewords]);