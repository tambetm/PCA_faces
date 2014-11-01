function [ class, min_distance ] = predict_class( image_project, train_project, train_classes )
    % find correct class
    min_distance = Inf;
    for j = 1:size(train_project, 1)
        distance = norm(train_project(j, :) - image_project);
        if distance < min_distance
            min_distance = distance;
            class = train_classes(j);
            closest = j;
        end       
    end

    global debug image images width height;
    if debug
        figure;
        colormap(gray);
        subplot(1, 2, 1);
        imagesc(reshape(image, width, height));
        title('Supplied image');
        subplot(1, 2, 2);
        imagesc(reshape(images(closest, :), width, height));
        title('Classified as');
    end
end
