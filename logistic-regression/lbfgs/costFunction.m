function [J, grad] = costFunction(X, y, log_params, K, D, lambda)
% Cost Function of Logistic Regresstion
    theta = reshape(log_params, K - 1, D);
    N = size(X, 1);
    J = 0;
    grad_params = zeros(K - 1, D);
    
%     for i = 1:N
%         tmp_sum = 1;
%         for j = 1:K-1
%             tmp_sum = tmp_sum + exp(theta(j, :) * X(i, :)');
%         end
%         if y(i) ~= 10
%             J = J + theta(y(i), :) * X(i, :)' - log(tmp_sum);
%         else
%             J = J - log(tmp_sum);
%         end
%     end
    
    
%     for k=1:K-1
%         for i = 1:N
%             tmp_sum = 1;
%             for j = 1:K-1
%                 tmp_sum = tmp_sum + exp(theta(j, :) * X(i, :)');
%             end
%             grad(k, :) = grad(k, :) + ((y(i) == k) - exp(theta(k, :) * X(i, :)') / tmp_sum) * X(i, :);
%         end
%     end
%     

%     Calculate Gradient 
    theta_X = exp(theta * X');
    log_sum = 1.0 + sum(theta_X);
    prob_X = theta_X ./ repmat(log_sum, K - 1, 1);
    delta_X = zeros(K - 1, N);
    
    for k = 1:K-1
        delta_X(k, :) = ((y == k)' - prob_X(k, :));
    end
    
    grad_params = delta_X * X - lambda * theta;
    grad = -1.0 * [grad_params(:)];

% Calculate JCost
    Ix = find(y ~= K);
    Iy = y(Ix);
    idx = sub2ind([K - 1 N], Iy, Ix);
    tmp = zeros(1, N);
    theta_X2 = theta * X';
    tmp(Ix) = theta_X2(idx);
    J = sum((tmp - log(log_sum)), 2);
    J = - 1.0 * J + 0.5 * lambda * sum(sum(theta .^ 2));
end
