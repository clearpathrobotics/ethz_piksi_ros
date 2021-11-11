#!/bin/bash

REPO_TAG=v2.6.5 #version you want to checkout before installing

#---------------- SBP ----------------
echo " "
echo "Installing SBP library for Piksi Multi."

sudo apt install python3-pip
sudo pip3 install sbp==$REPO_TAG
# sudo pip install llvmlite --upgrade

echo "SBP Library Installed"

echo "Installing ROS node requirements."
sudo pip3 install numpy-quaternion==2020.11.2.17.0.49
# sudo pip3 install scipy==0.19.1
sudo pip3 install pyproj==2.2.2
# sudo apt install python3-pyproj

#---------------- Dialout Group ----------------
if id -nG "$USER" | grep -qw dialout; then
    echo "User $USER is already included in 'dialout' group."
else
    # $USER does not belong to dialout
    echo " "
	echo "Do you wish to add the current user ($USER) to 'dialout' group? [y or Y to accept]"
	read add_user_to_dialout

	if [[ $add_user_to_dialout == "Y" || $add_user_to_dialout == "y" ]]; then
	    echo "Adding user $USER to 'dialout' group."
	    sudo adduser $(whoami) dialout
	    echo "Please logout and back in for the new group to take effect."
	fi

fi

echo " "
echo "Installation completed."
