% comparison of different numbers of principal components

clear all;
clc;

% load images
nr_classes = 13;
nr_photos = 10;
[images, classes] = load_images(nr_classes, nr_photos);

nr_train_photos = 1;
for nr_principal_components = 1:(nr_classes * nr_train_photos)
    % try 10 random partitionings
    for trial = 1:10
        % partition images into train and test
        [train_images, test_images, train_classes, test_classes] = partition_images(images, classes, nr_classes, nr_photos, nr_train_photos);

        % normalize training and test set (subtract mean)
        [train_norm, train_mean] = normalize_images(train_images);
        test_norm = normalize_images(test_images, train_mean);

        % compute eigenvector for training set
        eigen_train = compute_eigenvectors(train_norm);
        % remove least important eigenvectors
        % NB! Important ones are at the end!
        eigen_train = eigen_train(:, (end - nr_principal_components + 1):end);

        % project training and test set to reduced space
        train_project = train_norm * eigen_train;
        test_project = test_norm * eigen_train;

        % compute accuracy for test images
        accuracy(nr_principal_components, trial) = compute_accuracy(train_project, test_project, train_classes, test_classes);
    end
    disp([num2str(nr_principal_components) '/' num2str(nr_classes * nr_train_photos)]);
end

plot(mean(accuracy, 2));
ylabel('Accuracy');
xlabel('Nr of principal components');
title('Relationship between accuracy and number of principal components');
