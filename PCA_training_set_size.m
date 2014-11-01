% comparison of different training set sizes

clear all;
clc;

% load images
nr_classes = 13;
nr_photos = 10;
[images, classes] = load_images(nr_classes, nr_photos);

for nr_train_photos = 1:(nr_photos - 1)
    % try 10 random partitionings
    for trial = 1:10
        % partition images into train and test
        [train_images, test_images, train_classes, test_classes] = partition_images(images, classes, nr_classes, nr_photos, nr_train_photos);

        % normalize training and test set (subtract mean)
        [train_norm, train_mean] = normalize_images(train_images);
        test_norm = normalize_images(test_images, train_mean);

        % compute eigenvector for training set
        eigen_train = compute_eigenvectors(train_norm);

        % project training and test set to reduced space
        train_project = train_norm * eigen_train;
        test_project = test_norm * eigen_train;

        % compute accuracy for test images
        accuracy(nr_train_photos, trial, 1) = compute_accuracy(train_project, test_project, train_classes, test_classes);
        accuracy(nr_train_photos, trial, 2) = compute_accuracy(train_norm, test_norm, train_classes, test_classes);

        % calculate average faces for everybody
        [project_averages, project_classes] = calculate_averages(train_project, train_classes, nr_train_photos, nr_classes);
        [raw_averages, raw_classes] = calculate_averages(train_norm, train_classes, nr_train_photos, nr_classes);

        % compute accuracy with average faces
        accuracy(nr_train_photos, trial, 3) = compute_accuracy(project_averages, test_project, project_classes, test_classes);
        accuracy(nr_train_photos, trial, 4) = compute_accuracy(raw_averages, test_norm, raw_classes, test_classes);
    end
    disp([num2str(nr_train_photos) '/' num2str(nr_photos - 1)]);
end

plot(1:nr_photos-1, mean(accuracy(:,:,2),2), 'r', ...
    1:nr_photos-1, mean(accuracy(:,:,1),2), 'b', ...
    1:nr_photos-1, mean(accuracy(:,:,4),2), 'g', ...
    1:nr_photos-1, mean(accuracy(:,:,3),2), 'y');
legend('Raw image space', 'PCA projected space', ...
    'Averaged raw images', 'Averaged PCA images', ...
    'Location', 'northwest');
ylabel('Accuracy');
xlabel('Nr of training images');
title('Relationship between accuracy and number of training images');
