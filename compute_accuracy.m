function [ accuracy ] = compute_accuracy( train_project, test_project, train_classes, test_classes )
    % find closest training image for each test image
    for i = 1:size(test_project, 1)
        min_distance = Inf;
        for j = 1:size(train_project, 1)
            distance = norm(train_project(j, :) - test_project(i, :));
            if distance < min_distance
                min_distance = distance;
                predicted_classes(i) = train_classes(j);
                closest(i) = j;
            end       
        end
    end
    hits = (test_classes == predicted_classes);
    accuracy = sum(hits) / size(test_project, 1);

    global debug width height train_images test_images;
    if debug
        figure(6);
        colormap(gray);
        misses = (find(hits == 0));
        counter = 1;
        for i = misses(1:min([2 end]))
            subplot(2, 2, counter);
            imagesc(reshape(test_images(i, :), width, height));
            title('Test image');
            subplot(2, 2, counter + 1);
            imagesc(reshape(train_images(closest(i), :), width, height));
            title('Wrongly classified as');
            counter = counter + 2;
        end
    end
end
