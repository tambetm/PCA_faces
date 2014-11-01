function [ train_averages, average_classes ] = calculate_averages( train_project, train_classes, nr_train_photos, nr_classes )
    train_reshaped = reshape(train_project, nr_train_photos, nr_classes, size(train_project, 2));
    train_averages = squeeze(mean(train_reshaped, 1));
    average_classes = train_classes(1:nr_train_photos:(nr_train_photos * nr_classes));

    global debug width height train_images;
    if debug and size(train_averages, 2) == width * height
        train_images = train_averages;
        figure(5);
        colormap(gray);
        for i = 1:4
            subplot(2,2,i);
            j = randi(size(train_averages, 1));
            imagesc(reshape(train_averages(i, :), width, height));
            title('Averaged faces of a person');
        end
    end    
end
