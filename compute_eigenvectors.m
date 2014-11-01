function [ eigen_train ] = compute_eigenvectors( train_norm )
    % calculate "fake" covariance matrix
    C = train_norm * train_norm';
    % calculate "fake" eigenvectors and eigenvalues
    [V,D] = eig(C);
    % calculate real eigenvectors
    eigen_train = train_norm' * V;

    global debug width height;
    if debug
        figure(3);
        colormap(gray);
        subplot(2,2,1);
        imagesc(reshape(eigen_train(:, 1), width, height));
        title('First eigenvector (least relevant)');
        subplot(2,2,2);
        imagesc(reshape(eigen_train(:, 2), width, height));
        title('Second eigenvector');
        subplot(2,2,3);
        imagesc(reshape(eigen_train(:, end-1), width, height));
        title('Before last');
        subplot(2,2,4);
        imagesc(reshape(eigen_train(:, end), width, height));
        title('Last eigenvector (most relevant)');
    
        train_project = train_norm * eigen_train;
        train_reconst = train_project * eigen_train';

        figure(4);
        colormap(gray);
        subplot(2,2,1);
        i = randi(size(train_norm, 1));
        j = randi(size(train_norm, 1));
        imagesc(reshape(train_norm(i, :), width, height));
        title('Original image (normalized)');
        subplot(2,2,2);
        imagesc(reshape(train_norm(j, :), width, height));
        title('Original image (normalized)');
        subplot(2,2,3);
        imagesc(reshape(train_reconst(i, :), width, height));
        title('Reconstructed eigenface');
        subplot(2,2,4);
        imagesc(reshape(train_reconst(j, :), width, height));
        title('Reconstructed eigenface');
    end    
end
