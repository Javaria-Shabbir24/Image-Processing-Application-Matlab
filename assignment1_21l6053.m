%Image Processing Application
function assignment1_21l6053
    % figure / window for the GUI
    fig = uifigure('Name', 'Image Processing GUI', 'Position', [100 100 900 700]);

    % browse button added in fig window
    % on pushing the browse button, loadtheImage function will load the image
    browseButton = uibutton(fig, 'push', 'Text', 'Browse','Position', [250, 500, 100, 30], 'ButtonPushedFcn', @(btn, event) loadtheImage());   

    % Axes to display the loaded image
    axes = uiaxes(fig, 'Position', [450 50 450 500]);
end
