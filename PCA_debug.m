clear all;
clc;

global debug train_images test_images;
debug = 1;

% load images
nr_classes = 13;
nr_photos = 10;
[images, classes] = load_images(nr_classes, nr_photos);

% partition images into train and test
nr_train_photos = 8;
[train_images, test_images, train_classes, test_classes] = partition_images(images, classes, nr_classes, nr_photos, nr_train_photos);

% normalize training and test set (subtract mean of training set)
[train_norm, train_mean] = normalize_images(train_images);
test_norm = normalize_images(test_images, train_mean);

% compute eigenvector for training set
eigen_train = compute_eigenvectors(train_norm);

% project training and test set to PCA space
train_project = train_norm * eigen_train;
test_project = test_norm * eigen_train;

% compute accuracy for test images
accuracy_pca = compute_accuracy(train_project, test_project, train_classes, test_classes)
accuracy_raw = compute_accuracy(train_norm, test_norm, train_classes, test_classes)

% calculate average face for each person
[project_averages, project_classes] = calculate_averages(train_project, train_classes, nr_train_photos, nr_classes);
[raw_averages, raw_classes] = calculate_averages(train_norm, train_classes, nr_train_photos, nr_classes);

% calculate accuracy with averaged faces
accuracy_avg_pca = compute_accuracy(project_averages, test_project, project_classes, test_classes)
accuracy_avg_raw = compute_accuracy(raw_averages, test_norm, raw_classes, test_classes)
