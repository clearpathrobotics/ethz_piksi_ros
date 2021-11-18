#!/bin/bash

#---------------- SBP ----------------
echo " "

if [ $ROS_PYTHON_VERSION == 2 ]; then
	echo "Installing on Python2"
	echo "Installing SBP library for Piksi Multi."

	REPO_TAG=v2.6.5 #version you want to checkout before installing
	
	sudo apt install python-pip
	sudo pip install sbp==$REPO_TAG

	echo "SBP Library Installed"

	echo "Installing ROS node requirements."
	sudo pip install numpy-quaternion==2020.11.2.17.0.49
	sudo pip install scipy==0.19.1
	sudo pip install pyproj==2.2.2

elif [ $ROS_PYTHON_VERSION == 3 ]; then
	echo "Installing on Python3"
	echo "Installing SBP library for Piksi Multi."
	
	REPO_TAG=v3.4.10 #version you want to checkout before installing
	
	sudo apt install python3-pip
	sudo pip3 install sbp==$REPO_TAG
	sudo pip3 install llvmlite --upgrade
	sudo pip3 install numba

	echo "SBP Library Installed"

	echo "Installing ROS node requirements."
	sudo pip3 install numpy-quaternion
	sudo pip3 install scipy
	sudo pip3 install pyproj
fi

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
