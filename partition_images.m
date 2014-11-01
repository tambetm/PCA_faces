function [ train_images, test_images, train_classes, test_classes ] = partition_images( images, classes, nr_classes, nr_photos, nr_train_photos )
    train_images = [];
    test_images = [];
    train_classes = [];
    test_classes = [];
    for i = 1:nr_classes
        % random permutation of photos in this class
        % NB! Different permutation for each class!
        partition = randperm(nr_photos);
        train_partition = partition(1:nr_train_photos);
        train_images = [train_images; images((i - 1) * nr_photos + train_partition, :)];
        train_classes = [train_classes classes((i - 1) * nr_photos + train_partition)];
        test_partition = partition(nr_train_photos + 1:end);
        test_images = [test_images; images((i - 1) * nr_photos + test_partition, :)];
        test_classes = [test_classes classes((i - 1) * nr_photos + test_partition)];
    end
    
    global debug width height;
    if debug
        figure(1);
        colormap(gray);
        subplot(2,2,1);
        imagesc(reshape(train_images(1,:), width, height));
        title('First training image');
        subplot(2,2,2);
        imagesc(reshape(train_images(3,:), width, height));
        title('Third training image');
        subplot(2,2,3);
        imagesc(reshape(test_images(1, :), width, height));
        title('First test image');
        subplot(2,2,4);
        imagesc(reshape(test_images(3,:), width, height));
        title('Third test image');
    end
end
