%Image Processing Application
function assignment1_21l6053
    % figure / window for the GUI
    fig = uifigure('Name', 'Image Processing GUI', 'Position', [100 100 700 600]);

    % browse button added in fig window
    % on pushing the browse button, loadtheImage function will load the image
    browseButton = uibutton(fig, 'push', 'Text', 'Browse','Position', [100, 500, 100, 30], 'ButtonPushedFcn', @(btn, event) loadtheImage());   

    % Axes to display the loaded image
    axes = uiaxes(fig, 'Position', [350 50 300 500]);

    % Function to load the image
    function loadtheImage()
        %specified paths
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp)'});
        %if any file is not selected
        if isequal(file, 0)
            disp('No file selected');
        else
            %if a file is selected
            %read the file path
            img = imread(fullfile(path, file)); 
            % Display the image in the axes
            imshow(img, 'Parent', axes);  
        end
    end
end
