clear all;
clc;

global debug images image;
debug = 1;

% load images
nr_classes = 13;
nr_photos = 10;
[images, classes] = load_images(nr_classes, nr_photos);
debug = 0;

% normalize training and test set (subtract mean of training set)
[images_norm, images_mean] = normalize_images(images);

% compute eigenvector for training set
eigen_images = compute_eigenvectors(images_norm);

% project training and test set to reduced space
images_project = images_norm * eigen_images;

% read image
image = imread('noised.jpg');
image = reshape(image, 1, numel(image));
image_norm = normalize_images(image, images_mean);

% project image to PCA space
image_project = image_norm * eigen_images;

debug = 1;

% predict class for this image based on projection
class = predict_class(image_project, images_project, classes)

% predict class for this image based on raw images
class = predict_class(image_norm, images_norm, classes)
