% Matlab startup routines for LabNPF workstations
%	GitHub repository: https://github.com/LabNPF/LabNPF_workstation
%
% Usage: 
%	Automatically runs when Matlab starts.
%	The folder where this file (startup.m) is located must be 
%   added to the Matlab path (typically "C:\LabNPF_workstation\matlab_toolboxes\").
%
% History:
%   2022-05-19: moved from personal to organisation repository [FFS]
%   2018-06-06: moving to GitHub for storage and automatic version control [FFS]
%   2018-06-04: first version of the script [FFS]
%


% 1) Call "labnpf_select_eeglab_version.m" - 
labnpf_select_eeglab_version('C:\LabNPF_workstation\matlab_toolboxes\');

% 2) Check if pop_readegi.m function has been altered to import Cz (129 electrodes)
% Original function renamed to "pop_readegi_ORIGINAL.m"
% Customized function takes name "pop_readegi.m"
disp(' ');
disp('*** LabNPF Warning ***');
disp(' ');
disp('Make sure you use the correct electrode locations for your data.');
disp('Typically in the LabNPF we use one of the following, but verify for your data:');
disp('   EGI 129-channels (includes Cz): GSN-HydroCel-129.sfp --> Recommended');
disp('   EGI 128-channels (excludes Cz): GSN-HydroCel-128.sfp');
disp('   ANT 32-channels: ANT_WG_standard_32.ced');
disp('   10-20 SI 19-channels: Standard-10-20-Cap19.ced');
disp(' ');
disp('Electrode location files at: C:\LabNPF_workstation\utils\eeglab_channel_locations');
disp(' ');
