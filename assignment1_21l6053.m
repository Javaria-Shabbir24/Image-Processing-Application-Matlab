%Image Processing Application
function assignment1_21l6053
    % image variable initialized
    img = []; 
    % Default format is .jpg
    saveFormat = '.jpg'; 
    % Default flip direction
    flipDirection = 'Vertical'; 
    % Default combine mode
    combineMode = 'Side-by-Side'; 
    %filepath
    filePath = [];
    % figure / window for the GUI
    fig = uifigure('Name', 'Image Processing GUI', 'Position', [100 100 800 600]);

    % browse button added in fig window
    % on pushing the browse button, loadtheImage function will load the image
    browseButton = uibutton(fig, 'push', 'Text', 'Browse','Position', [150, 500, 100, 30], 'ButtonPushedFcn', @(btn, event) loadtheImage());   

    % Axes to display the loaded image
    axes = uiaxes(fig, 'Position', [350 50 370 500]);

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
            % Store the file path
            filePath = fullfile(path, file); 
            % Display the image in the axes
            imshow(img, 'Parent', axes);  
        end
    end
% Function to set the save format
    function setSaveFormat(selectedformat)
        saveFormat = selectedformat;
    end
% Dropdown for file formats while saving the picture
% selected format is set to saved format using function setSaveFormat
    saveDropdown = uidropdown(fig,'Items', {'.jpg', '.png', '.bmp', '.tiff'},'Position', [150, 450, 100, 30],  'ValueChangedFcn', @(dd, event) setSaveFormat(dd.Value));

% Save button added to save the loaded file
% on pushing the save button, save image function is triggered
    saveButton = uibutton(fig, 'push', 'Text', 'Save', 'Position', [150, 400, 100, 30], 'ButtonPushedFcn', @(btn, event) saveImage());
% Function to save the image
    function saveImage()
        if isempty(img) 
            % if no image loaded
            disp('No image to save');
            return;
        end
        [file, path] = uiputfile({['*' saveFormat], ['Image Files (*' saveFormat ')']}, 'Save Image'); %save image with saved format
        if isequal(file, 0) % if no file path selected
            disp('No file selected for saving');
        else
            imwrite(img, fullfile(path, file)); %save image if path selected
        end
    end
% Image Information Button added
% when the button is pushed showImageInfo function is called
    infoButton = uibutton(fig, 'push', 'Text', 'Image Info', 'Position', [150, 350, 100, 30], 'ButtonPushedFcn', @(btn, event) showImageInfo());

% Function to show image information
    function showImageInfo()
        if isempty(img)
            %if no image is selected
            disp('No image to display info');
            return;
        end
        % image format
        infoofimage = imfinfo(filePath);
        format = infoofimage.Format;
        % Original file size
        % details about the file & directory
        originalFileInfo = dir(filePath); 
        % getting the size of file in bytes
        originalFileSize = originalFileInfo.bytes; 
        % Compressed file size
        % Temporary path for the compressed image
        compressedFileName = fullfile(tempdir, 'compressed_image.jpg');
        % image is compressed with jpg format and 70% quality
        imwrite(img, compressedFileName, 'jpg', 'Quality', 70);
        compressedFileInfo = dir(compressedFileName);
        % getting the size of file in bytes
        compressedFileSize = compressedFileInfo.bytes;
        % Compression ratio
        compressionRatio = originalFileSize / compressedFileSize;
        % Display Information
        info = sprintf('Height: %d pixels\nWidth: %d pixels\nFormat: %s\nOriginal File Size: %d bytes\nCompressed File Size: %d bytes\nCompression Ratio:%.2f\n', size(img, 1), size(img, 2), format, originalFileSize,compressedFileSize,compressionRatio);
        uialert(fig, info, 'Image Information'); % alert message displaying the image information
    end


end
