PCA_faces
=========

Face recognition using PCA.

Main starting points:
 - PCA_debug.m - general debugging script.
 - PCA_training_set_size.m - creates a graph how accuracy depends on training set sizes.
 - PCA_principal_components.m - creates a graph how accuracy depends on number of principal components.
 - PCA_predict.m - predict class for user-supplied image.

Training set files must be named as f_<classnr>_<imagenr>.jpg, e.g. f_1_01.jpg or f_13_10.jpg. 
There must be the same number of training images for all classes. Classes = persons of course.
