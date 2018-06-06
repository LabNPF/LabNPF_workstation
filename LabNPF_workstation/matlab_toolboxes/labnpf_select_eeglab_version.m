function labnpf_select_eeglab_version(toolboxes_path)
% labnpf_select_eeglab_version() - function to select an EEGLAB version for 
%			use in LabNPF workstations. The function scans the toolboxes_path 
%			for EEGLAB installations and allows the user to select the 
%			desired EEGLAB version. If only one EEGLAB version is installed, 
%			it is loaded by default, without requiring user input. The path 
%			added to the Matlab path is not saved. Should be called from a 
%			"startup.m" file that must be in the Matlab path in order to run
%			every time Matlab starts.
%
% Author:
%   Fernando Ferreira-Santos (http://ferreira-santos.eu), 2018-06
%   Laboratory of Neuropsychophysiology, University of Porto
%   GitHub repository: https://github.com/ferreira-santos/LabNPF_workstation
%
% Usage: 
%   labnpf_select_eeglab_version(toolboxes_path)
%
% Arguments:
%   toolboxes_path:    path to folder where EEGLAB toolboxes are installed.
% 
% History:
%	  2018-06-06: moving to GitHub for storage and automatic version control [FFS]
%   2018-06-04: first version of the script [FFS]
%


%% Initial output message
disp(' ');
disp('*** LabNPF startup EEGLAB version selection tool ***');
disp(' ');


%% Check if toolboxes_path is invalid path -- if invalid, end function
if isdir(toolboxes_path)==0
  disp('ERROR: The path to the toolboxes folder is invalid. Please verify that the folder exists.');
  disp('No EEGLAB version will be selected for this session');
  disp('');
  return;
end; 


%% LIST generated by scanning the toolboxes_path for EEGLAB installations:
disp(['Scanning ' toolboxes_path ' for installed EEGLAB versions...']);
disp('(To install more EEGLAB verions, place them in that same path)');
disp(' ');

eeglab_folders = dir(fullfile(toolboxes_path, 'eeglab*'));
eeglab_folders_index = find([eeglab_folders.isdir]);

if length(eeglab_folders_index)==0
    disp('WARNING: No installed EEGLAB versions found.');
    disp(' ');
    disp('If you think this is an error, make sure that:');
    disp('- eeglab is installed in the correct folder (as above)');
    disp('- the eeglab folder has its original name (as downloaded)');
    disp(' ');
else
    
for i=1:length(eeglab_folders_index)
    version_paths_list{i,1} = ['  ' num2str(i) ' -- ' eeglab_folders(eeglab_folders_index(i)).name]; % Version number/text to show
    version_paths_list{i,2} = [toolboxes_path eeglab_folders(eeglab_folders_index(i)).name]; % Path to EEGLAB version
end;


%% IF list length = 1 entry, then add that path and skip the rest

if length(version_paths_list(:,1))==1
    disp(['Found only 1 EEGLAB version installed: ' eeglab_folders(1).name]);
    disp(' ');
    disp('No user input required.');
    addpath(version_paths_list{1,2});
    disp(['Added to Matlab path:' version_paths_list{1,2}]);
    disp('Type eeglab to start.')
    disp(' ');
end;


%% ELSE Get user input on which EEGLAB version to load

if length(version_paths_list(:,1))>1

    disp(['Found ' num2str(length(version_paths_list(:,1))) ' EEGLAB versions. Select EEGLAB version to work with, from the list below:']);
    disp(' ');
    for j=1:length(version_paths_list(:,1))
        disp(version_paths_list{j,1})
    end;
    disp(' ');

    exit_loop = false;
    drawnow;
    
    
    while exit_loop == false
        selected_version = input('Select version (numeric input): ');
    
        if selected_version > 0 & selected_version <= length(version_paths_list(:,1))
            addpath(version_paths_list{selected_version,2});
            disp(' ');
            disp(['Added to Matlab path:' version_paths_list{selected_version,2}]);
            disp('Type eeglab to start.')
            disp(' ');
            exit_loop = true;
        else 
            disp(' ');
            disp('Error, please select one of the options indicated in the list by entering the correct number and pressing enter.');
            %disp(['Restart Matlab or run ' toolboxes_path '\startup.m again to select the correct EEGLAB version.']);
            disp(' ');
        end;
    end;    
end;

end; % ends IF no eeglab version are found
clear;
