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
        % image is compressed with jpg format and 50% quality
        imwrite(img, compressedFileName, 'jpg', 'Quality', 50);
        compressedFileInfo = dir(compressedFileName);
        % getting the size of file in bytes
        compressedFileSize = compressedFileInfo.bytes;
        % Compression ratio
        compressionRatio = originalFileSize / compressedFileSize;
        % Display Information
        info = sprintf('Height: %d pixels\nWidth: %d pixels\nFormat: %s\nOriginal File Size: %d bytes\nCompressed File Size: %d bytes\nCompression Ratio:%.2f\n', size(img, 1), size(img, 2), format, originalFileSize,compressedFileSize,compressionRatio);
        uialert(fig, info, 'Image Information'); % alert message displaying the image information
    end
    % Conversion of grayscale image to black and white
    % When the button is pushed, convertToBlackAndWhite function is triggered
    BlackandWhiteButton = uibutton(fig, 'push', 'Text', 'Convert to Black and White','Position', [120, 300, 160, 30], 'ButtonPushedFcn', @(btn, event) convertToBlackAndWhite());

    % Function to convert image to black and white
    function convertToBlackAndWhite()
        if isempty(img)
            disp('No image to convert');
            return;
        end
        img = rgb2gray(img);
        imshow(img, 'Parent', axes);
    end
    % Crop Button added
    % When the button is pushed, cropImage function is triggered
    cropButton = uibutton(fig, 'push', 'Text', 'Crop', 'Position', [150, 250, 100, 30], 'ButtonPushedFcn', @(btn, event) cropImage());
    % Function to crop the image
    function cropImage()
    % if no image is selected
    if isempty(img)
        disp('No image to crop');
        return;
    end

    % Prompt for the cropping dialog box
    prompt = {'Enter the x-coordinate of the top-left corner:','Enter the y-coordinate of the top-left corner:', 'Enter the width of the crop rectangle:', 'Enter the height of the crop rectangle:'};
    % Dialog box title
    dlgtitle = 'Input';
    % Open the input dialog and retrieve user input as a cell array
    answer = inputdlg(prompt, dlgtitle);

    % Convert user input from strings to numeric values
    if ~isempty(answer)
        xmin = str2double(answer{1}); % x-coordinate
        ymin = str2double(answer{2}); % y-coordinate
        width = str2double(answer{3}); % width
        height = str2double(answer{4}); % height
        % Cropping by setting the specified width and height
        xmax = xmin + width - 1; % cropped width
        ymax = ymin + height - 1; % cropped height
        % error handling
        % Image dimensions
        [imgHeight, imgWidth, ~] = size(img); 
        % if cropped width exceed the original width
        if xmax > imgWidth
            xmax = imgWidth; % set cropped equal to original width size
        end
        % if cropped height exceed the original height
        if ymax > imgHeight
            ymax = imgHeight; % set cropped equal to original height size
        end
        % cropping (height, width, all shades)
        croppedImg = img(ymin:ymax, xmin:xmax, :);
        % Display the cropped image
        imshow(croppedImg, 'Parent', axes);
    
    else
        disp('User canceled the input.');
    end
    end
    % Resize button added
    % When the button is pushed, cropImage function is triggered
    resizeButton = uibutton(fig, 'push', 'Text', 'Resize', 'Position', [150, 200, 100, 30], 'ButtonPushedFcn', @(btn, event) resizeImage());

    % Function to resize the image
    function resizeImage()
        if isempty(img)
            disp('No image to resize');
            return;
        end
        prompt = {'Enter new width:', 'Enter new height:'};
        dlgtitle = 'Resize';
        dims = inputdlg(prompt, dlgtitle, [1 35; 1 35]);
        if ~isempty(dims)
            newWidth = str2double(dims{1});
            newHeight = str2double(dims{2});
            img = imresize(img, [newHeight newWidth]);
            imshow(img, 'Parent', axes);
        end
    end



end
