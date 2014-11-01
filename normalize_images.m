function [ images_norm, output_mean ] = normalize_images( images, input_mean )

    % scale all pixel values between 0 and 1
    images_scaled = double(images) / 255;
    % calculate mean of training images
    if ~exist('input_mean', 'var')
        input_mean = mean(images_scaled);
        output_mean = input_mean;
    end
    % normalize all pixel values to 0 mean
    images_norm = bsxfun(@minus, images_scaled, input_mean);

    global debug width height;
    if debug
        figure(2);
        colormap(gray);
        subplot(2,2,1);
        imagesc(reshape(images(1,:), width, height));
        title('Image before scaling');
        subplot(2,2,2);
        imagesc(reshape(images_scaled(1,:), width, height));
        title('Image after scaling');
        subplot(2,2,3);
        imagesc(reshape(input_mean, width, height));
        title('Mean image of training set');
        subplot(2,2,4);
        imagesc(reshape(images_norm(1,:), width, height));
        title('Image after subtracting mean');
    end
end
