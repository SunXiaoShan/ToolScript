#
#  XCodeColor.sh
#  XCodeColor
#
#  Created by Phineas_Huang on 2015/5/1.
#  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
#

FOLDER_NAME="XCodeColorsFolder"
ROOT_PATH=$(pwd)

function install_end()
{
	cd $ROOT_PATH
	rm -rf $ROOT_PATH/$FOLDER_NAME
}

# step 1: install git 
if test "x$(which git)" = "x"; then
    echo "install git"
    sudo apt-get install git
fi

# step 2: install command line tools
if test "x$(which xcodebuild)" = "x"; then
	echo "install xcode command line tools"
	xcode-select --install
fi

# step 3: check folder
if [ -d ./$FOLDER_NAME ]; then  
	echo "XCodeColorsFolder is exist, change name please"
	exit 
fi

# step 4: create folder
mkdir $FOLDER_NAME
cd ./$FOLDER_NAME

# step 5: git clone file
git clone "https://github.com/robbiehanson/XcodeColors.git"

# step 6: enter XcodeColors folder
if [ -d ./XcodeColors ]; then
	cd ./XcodeColors
else
	echo "XcodeColors is not exist"
	install_end;
	exit
fi

# step 6: build code
xcodebuild clean install
xcodebuild -project XcodeColors.xcodeproj -scheme XcodeColors -destination 'platform=OS X,arch=x86_64'

# step 7: remove XCodeColor project
install_end;
exit

