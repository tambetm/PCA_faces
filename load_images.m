function [ images, classes ] = load_images( nr_classes, nr_photos )
    images = [];
    classes = [];
    for i=1:nr_classes
        for j=1:nr_photos
            file=['f_' int2str(i) '_' sprintf('%02d', j) '.jpg'];
            image = imread(file);
            images = [images; reshape(image, 1, numel(image))];
            classes = [classes i];
        end
    end
    
    global debug width height;
    if debug
        % record width and height of images for debugging
        [width, height] = size(image);
    end
end
