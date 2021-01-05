clc
noise = 0.2*randn(1,2000);
mean(noise)
var(noise)
%initialize the convolution operator for test
g = randn(1,1000);
%obtain "observed" data
y = conv(g,noise);
%generate initial deconvolution data
h = randn(1,1000);
%generate data matrix
y_hat = mean(y)
L = numel(h)-1;
kurtosis(noise);
%NxL+1 matrix where N = N'-L
data_mat = [];
for n = 1:L+1
    temp = [];
    for m = 1:numel(y)-L
        temp = [temp, y(L+1+m-n)-y_hat];
    end
    data_mat = [data_mat,temp.'];
end


%one iteration test
B = data_mat*pinv(data_mat);
for n = 1:500
    C = (data_mat*h.').^3;
    D = B*C;
    sum = 0;
    for m = 1:numel(D)
        sum = sum + abs(D(m))^2;
    end
h = 1/sqrt(sum) * pinv(data_mat)*(data_mat*h.').^3;
h = h.';
end

sum = 0;
for n = 1:numel(h)
    sum = sum +h(n);
end
sum = mean(y)*sum;

%update
x_hat = data_mat*h.' + sum*ones(numel(y)-L,1);

stem(0:99,x_hat(1:100))
figure
stem(0:99,noise(1:100))


% stem(0:99,y(1:100))
% figure
% stem(0:99,noise(1:100))


