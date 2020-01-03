#!/bin/bash

##############################

if [ "$EUID" -eq 0 ]
then
while [[ $ENDVARI != "n" ]]
do
clear

INPUT_SHELL=""
INPUT_DIR=""
INPUT_USER=""
INPUT_NEWUSER=""
INPUT_NEWGROUP=""
INPUT_COM=""
INPUT_CHOICE=""
LIST_USERS=""
LIST_USERID=""
ENDVARI=""
ENDVARI2=""
LINE="--------------------------------------------------"
STARS="**************************************************"
MENU_HEADER="SYSTEM MANAGER"
COUNT=1
MIN_VALUE="1000"
MAX_VALUE="60000"

#############################
	clear
	echo "$STARS"
	echo -e "\t\t$MENU_HEADER"
	echo $LINE
	echo -e "\e[31m1.\e[0m\tCreate User."
	echo -e "\e[31m2.\e[0m\tModify User."
	echo -e "\e[31m3.\e[0m\tList login Users."
	echo -e "\e[31m4.\e[0m\tList user attributes."
	echo -e "\e[31m5.\e[0m\tDelete User."
	echo -e "\e[31m6.\e[0m\tCreate Group."
	echo -e "\e[31m7.\e[0m\tList Groups."
	echo -e "\e[31m8.\e[0m\tSearch for a group."
	echo -e "\e[31m9.\e[0m\tDelete group."
	echo -e "\e[31m10.\e[0m\tModify Group Members."
	echo -e "\e[31m11.\e[0m\tAdd Directory."
	echo -e "\e[31m12.\e[0m\tList Directory."
	echo -e "\e[31m13.\e[0m\tModify Directory."
	echo -e "\e[31m14.\e[0m\tDelete Directory."
	echo -e "\e[31m15.\e[0m\tInstall or Uninstall SSH."
	echo -e "\e[31m16.\e[0m\tSSH status."
	echo -e "\e[31m0.\e[0m\tExit."
	echo $LINE
	echo -n "Choice: "
	read ENDVARI
##---------------------------------------------------------------
	case $ENDVARI in
	0) ## exits the program
                ENDVARI="n"
        ;;
	1) #skapa användare
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -e "\t\tUser Creation"
		echo $LINE
		echo -n "Enter new user name: "
		read INPUT_NEWUSER
		useradd -m -d /home/$INPUT_NEWUSER -s /bin/bash $INPUT_NEWUSER && echo Success || echo Failure
		echo "Press enter to continue..."
		read
	;;
	2) #modifiera användare
		while [[ $ENDVARI2 != "n" ]]
		do
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -e "\e[31m1.\e[0m\tUsername."
		echo -e "\e[31m2.\e[0m\tPassword."
		echo -e "\e[31m3.\e[0m\tUser ID."
		echo -e "\e[31m4.\e[0m\tGroup ID."
		echo -e "\e[31m5.\e[0m\tComment."
		echo -e "\e[31m6.\e[0m\tHome Directory."
		echo -e "\e[31m7.\e[0m\tDefault Shell."
		echo -e "\e[31m0.\e[0m\tCancel."
		echo $LINE
		echo -n "Choice: "
		read ENDVARI2
		case $ENDVARI2 in
		1) #byta namn
			echo -n "Choose which user to modify: "
			read INPUT_USER
			echo -n "Choose a new username: "
			read INPUT_NEWUSER
			groupadd $INPUT_NEWUSER
			(usermod -l $INPUT_NEWUSER -g $INPUT_NEWUSER -m -d /home/$INPUT_NEWUSER $INPUT_USER && groupdel $INPUT_USER) && echo Success || echo Failure
			echo $LINE
			echo -n "Press enter to continue..."
			read
		;;
		2) #Byta lösenord
			echo -n "Choose which user to modify: "
			read INPUT_USER
			passwd $INPUT_USER && echo Success || echo Failure
			echo $LINE
			echo -n "Press enter to continue..."
			read
		;;
		3) #Change user ID
			echo -n "Choose which user to modify: "
			read INPUT_USER
			echo -n "Choose new the new ID for the user betwen 1000-60000: "
			read  INPUT_ID
			if [ "$INPUT_ID" -ge "$MIN_VALUE" ] && [ "$INPUT_ID" -le "MAX_VALUE" ]
			then
				ID = $INPUT_ID
				usermod -u $INPUT_ID $INPUT_USER && echo Success || echo Failure
				echo $LINE
				echo -n "Press enter to continue..."
				read
			else
				echo "Invalid UID..."
				echo $LINE
				echo -n "Press enter to continue..."
				read
			fi
		;;
		4) # Change group ID
			echo -n "Choose which user to modify: "
			read INPUT_USER
			echo -n "Choose a new Group ID for the user betwen 1000-60000: "
			read INPUT_ID
			if [ "$INPUT_ID" -ge "$MIN_VALUE" ] && [ "$INPUT_ID" -le "$MAX_VALUE" ]
			then
				ID = $INPUT_ID
				groupmod -g $INPUT_ID $INPUT_USER
				echo $LINE
				echo -n "Press enter to continue..."
				read
			else
				echo "The group ID is invalid..."
				echo $LINE
				echo -n "Press enter to continue..."
				read
			fi
		;;
		5) # Write a comment!
			echo -n "Choose which user to modify: "
			read INPUT_USER
			echo -n  "Write your comment: "
			read INPUT_COM
			usermod -c "$INPUT_COM" $INPUT_USER && echo Success || echo Failure
			echo $LINE
			echo -n "Press enter to continue..."
			read
		;;
		6) ## change home directory
			echo -n "Choose which user to modify: "
			read INPUT_USERNAME
			echo -n "Choose a a new home directory name for the user: "
			read INPUT_DIR
			usermod -m -d /home/$INPUT_DIR $INPUT_USERNAME && echo Success || echo Failure
			echo $LINE
			echo -n "Press enter to continue..."
			read
		;;
		7) ## change the default shell
			echo "Choose which user to modify: "
			read INPUT_USERNAME
			echo "Choose the new shell: "
			read INPUT_SHELL
			usermod -s /bin/$INPUT_SHELL INPUT_USERNAME && echo Success || echo Failure
			echo $LINE
			echo -n "Press enter to continue..."
			read
		;;
		0)
			ENDVARI2="n"
		;;
		esac
		done
	;;
	3)	## lista login användare
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		LIST_USERS=$(getent passwd {1000..60000} | cut -d: -f1)
		for i in $LIST_USERS
		do
			echo -e "\e[31m$COUNT\e[0m\tUID: `getent passwd $i | cut -d: -f3` \t $i"
			COUNT=$(($COUNT+1))
		done
		echo ""
		echo $LINE
		echo "Press enter to continue..."
		read
	;;
	4) ## list attributes
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -n "Which user do you want to inspect: "
		read INPUT_USERNAME
		echo ""
		echo -e -n "\e[31mUsername: \e[0m\t\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f1)
		echo -e -n "\e[31mPassword: \e[0m\t\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f2)
		echo -e -n "\e[31mUser ID: \e[0m\t\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f3)
		echo -e -n "\e[31mGroup ID: \e[0m\t\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f4)
		echo -e -n "\e[31mComment: \e[0m\t\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f5)
		echo -e -n "\e[31mHome Directory: \e[0m\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f6)
		echo -e -n "\e[31mShell: \e[0m\t\t\t" && echo $(getent passwd $INPUT_USERNAME | cut -d: -f7)
		echo ""
		echo -e -n "\e[31mGroups: \e[0m\t\t" && groups $INPUT_USERNAME | cut -d\  -f3-4 | sed "s/ /, /g"
		echo $LINE
		echo "Press Enter to continue..."
		read

	;;
	5) ## Delete user
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -n "Specify the user you wish to delete: "
		read INPUT_USERNAME
		echo -n "Are you certain? y/n: "
		read INPUT_CHOICE
		if [[ $INPUT_CHOICE == "y" || $INPUT_CHOICE == "Y" || $INPUT_CHOICE == "Yes" || $INPUT_CHOICE == "yes" ]]
		then
			userdel -r $INPUT_USERNAME 2> /dev/null
			echo "$INPUT_USERNAME deleted."

		else
			echo "User not deleted."
		fi
	;;
	6)	#Greate group
		clear
		input=""
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -n "Enter new group name: "
		read input
		groupadd $input  && echo "successfully created group $input"
		echo "----------------------------------------------"
		echo "Press enter to continue..."
		read
		clear
	;;
	7)	#List groups

		clear

		user_groups=$(getent group {1000..60000} | cut -d: -f1)
		counter="1"

		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -e "Listing user made groups..."

		for i in $user_groups
		do

		        echo -e "\e[31m$counter.\e[0m \t ID: `getent group $i | cut -d: -f3` \t $i"
		        counter=$(($counter+1))
		done
		echo $LINE
		echo "Press enter to continue..."
		read
		clear
	;;
	8) 	#search groups
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		input=""
		COUNT="1"

		echo -n "Which group to list: "
		read input
		members=$(getent group $input | cut -d: -f4 | sed 's/,/ /g')
		echo ""

		if [ -n "$members" ] #Om $members inte är tom
		then
			echo "Listing members in the group '$input' "
			for i in $members
			do
				echo -e "$COUNT. \t$i"
				COUNT=$(($COUNT+1))
			done
		else
			echo "Invalid input"
		fi
		echo $LINE
		echo -n "Press enter key to continue..."
		read
		clear

	;;
	9) 	#Delete group
		input_del=""
		lowest_id="1000"
		max_id="60000"

		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE

		echo "Input which group you want to delete"
		echo -n "Choice: "
		read input_del
		delgroup $input_del
		echo ""
		echo $LINE
		echo ""
		echo "Press enter to continue..."
		read
		clear
	;;
	10) #Modify group members

		clear
		input_username=""
		addrem_group=""
		input_group=""
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo "Which user do you want to manage?"
		echo -n "Choice: "
		read input_username
		echo ""
		echo "Do you want to add $input_username to a group, or remove $input_username from a group? ( add / remove )"
		echo -n "Choice: "
		read addrem_group
		echo ""
		if [[ ${addrem_group} == "add" ]]
		then
			echo "Which group do you want to add $input_username to?"
			echo -n "Choice: "
	        	read input_group
		        usermod -aG $input_group $input_username && echo -e "\nSuccessfully added $input_username to $input_group"
		elif [[ ${addrem_group} == "remove" ]]
		then
		        echo "Which group do you want to remove $input_username from?"
		        echo -n "Choice: "
		        read input_group
		        gpasswd -d $input_username $input_group
		fi
		echo $LINE
		echo -n "Press enter to continue..."
		read
	;;
	11) #Create  folder
		clear
		input=""
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo "What do you want to name your folder?"
		echo -n "Choice: "
		read input
		mkdir $input && echo "Created folder $input" || echo "Failed to create folder"
		echo $LINE
		echo -n "Press any key to continue..."
		read
		clear
	;;
	12)	#Listing Directory items
		clear
		input=""
		command=""
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo "Which directory do you want to list?"
		echo -n "Choice: "
		read input
		echo ""
		ls -h -r -l --color=always $input
		echo $LINE
		echo "Press enter to continue..."
		read
		clear
	;;
	13) #Modifiera Folders/Directories
		clear
		file_select=""
		choice_var=""
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -n "Select folder to modify: "
		read file_select
		var=$(ls -ld $file_select)

		echo $LINE
		echo -ne "\e[31mOwner of the folder:\e[0m\t\t"
		echo $var | cut -d\  -f3
		echo ""

		echo -ne "\e[31mGroup owner of the folder:\e[0m\t"
		echo $var | cut -d\  -f4
		echo ""

		echo -en "\e[31mCurrent permissions:\e[0m"
		#User
		if [ $(echo $var | cut -d\  -f1 | cut -c2) == "r" ]
		then
		        echo -e "\t\tRead privileges exists for user"
		else
		        echo -e "\t\t\t\tNo read privileges"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c3) == "w" ]
		then
		        echo -e "\t\t\t\tWrite privileges exists for user"
		else
		        echo -e "\t\t\t\tNo write privileges for user"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c4) == "x" ] || [ $(echo $var | cut -d\  -f1 | cut -c4) == "s" ]
		then
		        echo -e "\t\t\t\tExecute privileges exists for user\n"
		else
		        echo -e "\t\t\t\tNo execute privileges for user\n"
		fi

		#Group
		if [ $(echo $var | cut -d\  -f1 | cut -c5) == "r" ]
		then
		        echo -e "\t\t\t\tRead privileges exists for group"
		else
		        echo -e "\t\t\t\tNo read privileges for group"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c6) == "w" ]
		then
		        echo -e "\t\t\t\tWrite privileges exists for group"
		else
		        echo -e "\t\t\t\tNo write privileges for group"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c7) == "x" ] || [ $(echo $var | cut -d\  -f1 | cut -c7) == "s" ]
		then
		        echo -e "\t\t\t\tExecute privileges exists for group\n"
		else
		        echo -e "\t\t\t\tNo execute privileges for group\n"
		fi

		#Other
		if [ $(echo $var | cut -d\  -f1 | cut -c8) == "r" ]
		then
		        echo -e "\t\t\t\tRead privileges exists for others"
		else
		        echo -e "\t\t\t\tNo read privileges for others"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c9) == "w" ]
		then
		        echo -e "\t\t\t\tWrite privileges exists for others"
		else
		        echo -e "\t\t\t\tNo write privileges for others"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c10) == "x" ] || [ $(echo $var | cut -d\  -f1 | cut -c10) == "t" ]
		then
		        echo -e "\t\t\t\tExecute privileges exists for others\n"
		else
		        echo -e "\t\t\t\tNo execute privileges for others\n"
		fi

		echo -ne "\e[31mSticky bit:\e[0m\t\t\t" #Sticky bit = t / T

		if [ $(echo $var | cut -d\  -f1 | cut -c10) == "t" ] ||  [ $(echo $var | cut -d\  -f1 | cut -c10) == "T" ]
		then
		        echo -e "Sticky bit is active\n"
		else
		        echo -e "Sticky bit is not active\n"
		fi

		echo -ne "\e[31mSetgid:\e[0m\t\t\t\t"   #setgid = s / S

		if [ $(echo $var | cut -d\  -f1 | cut -c4) == "s" ] || [ $(echo $var | cut -d\  -f1 | cut -c4) == "S" ]
		then
		        echo -e "Setgid is set for user"
		else
		        echo -e "No setgid is set for user"
		fi

		if [ $(echo $var | cut -d\  -f1 | cut -c7) == "s" ] || [ $(echo $var | cut -d\  -f1 | cut -c7) == "S" ]

		then
		        echo -e "\t\t\t\tSetgid is set for group\n"
		else
		        echo -e "\t\t\t\tNo setgid is set for group\n"
		fi

		echo -ne "\e[31mLast modified:\e[0m\t\t\t"
		echo $var | cut -d\  -f6-8
		echo $LINE
		echo "Do you wish to change any of these attributes?"
		echo -e "\e[31m1\e[0m - Change ownership"
		echo -e "\e[31m2\e[0m - Change group ownership"
		echo -e "\e[31m3\e[0m - Change permissions"
		echo -e "\e[31m4\e[0m - Enable or disable sticky bit\e[0m\t"
		echo -e "\e[31m5\e[0m - Enable or disable setgid\e[0m\t"
		echo -e "\e[31m6\e[0m - Modify latest time changed\e[0m\t"
		echo -e "\e[31m0\e[0m - Exit"
		echo ""
		echo -n "Input: "
		read choice_var
		echo $LINE
		clear
		case $choice_var in
		        1)
		        user_owner_var=""
		        echo "Set owner to which user?"
		        echo -n "New owner (username): "
		        read user_owner_var
		        chown $user_owner_var $file_select
		        ;;
		        2)
		        group_owner_var=""
		        echo "Set group ownership to which group?"
		        echo -n "New group owner (group name): "
		        read group_owner_var
		        chown :$group_owner_var $file_select
		        ;;
		        3) #Permissions - Kan behöva sudo!
		        permissions_var=""
		        echo "Input new permissions for the folder"
		        echo -e "r = read, w = write and x = execute\n"
		        echo "7 = rwx"
		        echo "6 = rw"
		        echo "5 = rx"
		        echo "4 = r"
		        echo "3 = wx"
		        echo "2 = w"
		        echo "1 = x"
		        echo -e "Example input: 777\n"
			echo "The example will grant user, group and other the privileges: read, write and execution of the file."
		        echo -n "New permissions: "
		        read permissions_var
		        chmod $permissions_var $file_select && echo "Successfully changed permissions" || echo "Failed to change permissions"
		        ;;
		        4) #Sticky bit
		        sticky_var=""
		        echo "Apply or remove sticky bit? ( apply or remove )"
		        echo -n "Choice: "
		        read sticky_var
		        if [ ${sticky_var,,} == "apply" ]
		        then
		                chmod +t $file_select

		        elif [ ${sticky_var,,} == "remove" ]
		        then
		                chmod -t $file_select
		        else
		                echo "Error"
		        fi
        ;;
            5) #Setgid
		        setgid_var=""
		        ug_var=""
		        echo "Apply or remove setgid? ( apply or remove )"
		        echo -n "Choice: "
		        read setgid_var

		        if [ ${setgid_var,,} == "apply" ]
		        then
		                echo "Apply to users or groups?"
		                echo -n "Choice: "
		                read ug_var
		                if [ ${ug_var,,} == "users" ]
		                then
		                        chmod u+s $file_select && echo "Successfully changed setgid" || echo "Failed to change setgid"

		                elif [ ${ug_var,,} == "groups" ]
		                then
		                        chmod g+s $file_select && echo "Successfully changed setgid" || echo "Failed to change setgid"
		                else
		                        echo "Error"
	                fi

		        elif [ ${setgid_var,,} == "remove" ]
		        then
		                echo "Remove from users or groups?"
		                echo -n "Choice: "
		                read ug_var

		                if [ ${ug_var,,} == "users" ]
		                then
		                        chmod u-s $file_select && echo "Successfully changed setgid" || echo "Failed to change setgid"

		                elif  [ ${ug_var,,} == "groups" ]
		                then
		                        chmod g-s $file_select && echo "Successfully changed setgid" || echo "Failed to change setgid"
		                else
		                        echo "Error"
		                fi
		        fi
		        ;;
		        6) #Last time modified
		        time_var=""
		        echo "Modify time, format: MMDDhhmm"
		        echo "Example: 10231337 = October 10th, time: 13:37"
		        echo -n "Input: "
		        read time_var
		        touch -t $time_var $file_select && echo "Successfully changed last time modified!"
		        ;;
		        0) #Exit
		        ;;
		        *)
		        echo "Error"
		esac
	;;
	14) #delete directory
		clear
		delete_folder=""
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo -n "Input directory to delete from the system: "
		read delete_folder

		rm -f -r -v $delete_folder

		echo $LINE
		echo -n "Press enter to continue..."
		read
		clear
	;;
	15) #Install and uninstall SSH
		input=""
		lowercase_input=""
		clear
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE
		echo ""
		echo "Do you wish to install or uninstall openSSH-server on your device?"
		echo "Enter install to initiate the install process,"
		echo -e "to uninstall openssh-server enter uninstall.\n"
		echo -n "Choice: "
		read input
		echo ""

		if [ ${input,,} == "install" ]
		then
		        sudo apt install openssh-server

		elif [ ${input,,} == "uninstall" ]
		then
		        sudo apt remove openssh-server

		else
		        echo "An error has occured!"
		fi

		echo ""
		echo $LINE
		echo "Press enter to continue..."
		read
		clear
	;;
	16) #SSH STATUS
		clear
		input=""
		current_status=$(service ssh status | egrep "Active" | cut -d: -f2-3)
		echo "$STARS"
		echo -e "\t\t$MENU_HEADER"
		echo $LINE

		echo -e "\e[31mCurrent status:\e[0m $current_status\n"

		echo "Do you wish to stop or start the SSH process?"
		echo "Enter start to start the SSH process, enter stop to stop the SSH process."
		echo -n "Choice: "
		read input
		echo ""
		if [ ${input,,} == "start" ] # (,,) hanges all letters to lowercase.
		then
			sudo service ssh start && echo "Starting the SSH service"

		elif [ ${input,,} == "stop" ]
		then
			service ssh stop && echo "Stopping the SSH service"

		else
			echo "Error"
		fi
		echo ""
		echo $LINE
		echo "Press enter to continue..."
		read
		clear
	;;
esac
done
else
	echo "Only sudo allowed users are allowed, Goodbye"
	read
	clear
fi
