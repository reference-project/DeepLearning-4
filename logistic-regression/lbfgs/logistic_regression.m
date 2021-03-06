function [theta, tr_perf, te_perf, Jcost] = logistic_regression(tr_X, tr_y, te_X, te_y, lambda, learning_rate)
% logistic regression
    K = 10;
    D = size(tr_X, 2);

    theta = zeros(K - 1, D);
    
    log_params = [theta(:)];
    
    options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % sparseAutoencoderCost.m satisfies this.
    options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
    options.display = 'on';


    [opt_params, Jcost] = minFunc( @(p) costFunction(tr_X, tr_y, p, K, D, lambda), ...
                              log_params, options);
    theta = reshape(opt_params, K - 1, D);
    tr_perf = predict_accuracy(tr_X, tr_y, theta);
    te_perf = predict_accuracy(te_X, te_y, theta);
%    
%     maxIters = 5000;
%     
%     tr_perf = zeros(maxIters, 1);
%     te_perf = zeros(maxIters, 1);
%     Jcost = zeros(maxIters, 1);
% 
%     for iter = 1:maxIters
%         [J, grad] = costFunction(tr_X, tr_y, theta, lambda);
%         grad = grad - lambda * theta;
%         
% %         gradient ascent
%         theta = theta + learning_rate * grad; 
% 
%     %     testN = size(te_X, 1);
%     %     predict_prob = zeros(K, testN);
%     % 
%     %     predict_prob(1:K-1, :) = exp(theta * te_X');
%     %     predict_prob(K, :) = ones(1, size(te_X, 1));
%     %     predict_prob = predict_prob ./ repmat(sum(predict_prob), K, 1);
%     % 
%     %     [~, classes] = max(predict_prob);
%         tr_perf(iter) = predict_accuracy(tr_X, tr_y, theta);
%         te_perf(iter) = predict_accuracy(te_X, te_y, theta);
%         Jcost(iter) = J;
%         
%         if iter < 20 || mod(iter, 100) == 0
%             fprintf('Iteration = %d, Jcost = %8.5f, tr_perf = %8.5f, te_perf = %8.5f\n', iter, J, tr_perf(iter), te_perf(iter));
%         end
% 
%     end

end

