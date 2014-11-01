PCA_faces
=========

Face recognition using PCA.

Main starting points:
 - *PCA_debug.m* - general debugging script.
 - *PCA_training_set_size.m* - creates a graph how accuracy depends on training set sizes.
 - *PCA_principal_components.m* - creates a graph how accuracy depends on number of principal components.
 - *PCA_predict.m* - predict class for user-supplied image.

Training set files must be named as `f_<classnr>_<imagenr>.jpg`, e.g. `f_1_01.jpg` or `f_13_10.jpg`. 
There must be the same number of training images for all classes. Classes = persons of course.

All functions include large sections of debugging code, that is normally deactivated when global variable `debug` is not set. You can just ignore these, or make use of them by setting `debug = 1` only before calling functions you want to debug. I haven't figured out yet, how I could move this code outside of the functions, as it often makes use of internal variables. 

I used OpenCV based [face detection script](https://github.com/tambetm/facedetect) for preprocessing images ([facedetect](http://www.thregr.org/~wavexx/software/facedetect/) script provided excellent starting point, thanks Yuri!). It didn't appear to make much difference though, non-preprocessed images achieved even better accuracy rates. I suspect that surroundings helped in our case, because all pictures were taken on the same day with the same clothes.

I also tried comparing distance between image pixels directly and it appeared to work even better than PCA. Of course you pay in processing time, but it was surprising nonetheless.

I also experimented using average of training images for each class. This way you compare distance to class average image only, not every image in training set. It appeared to work fine, especially for raw images - averaged raw images beat full set PCA!
