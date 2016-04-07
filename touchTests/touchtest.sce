active_buttons = 2;
button_codes = 1,2;
default_font_size = 48;
default_font = "Arial";



begin;


#Array of 4 text object to serve as Selectors
array {
	text {
		 caption = "A";
		 width = 175;
		 height = 175;
		 font_color = 242,39,19;
	};

	text {
		 caption = "B";
		 width = 175;
		 height = 175;
		 font_color = 25,181,254;

	};

	text {
		 caption = "C";
		 width = 175;
		 height = 175;
		 font_color = 248,148,6;
		
	};

	text {
		 caption = "D";
		 width = 175;
		 height = 175;
		 font_color = 0,177,106;

	};
	
}optionsArray;

#Array of boxes to serve as borders for text options
array {
	box {
		 #caption = " ";
		 width = 179;
		 height = 180;
		 color = 242,39,19;
	};

	box {
		# caption = " ";
		 width = 179;
		 height = 179;
		  color = 25,181,254;

	};

	box {
		# caption = " ";
		 width = 179;
		 height = 179;
		 color = 248,148,6;
		
	};

	box {
		# caption = " ";
		 width = 180;
		 height = 180;
		 color = 0,177,106;

	};
	
}optionsArrayBorder;

#Text object to notify a new option pane is coming
text{
	caption = "Wait for next set"; 
}doNothingText;

#Do Nothing Picture to use in between video/selector trials
picture{
	text doNothingText;
	x=0; y=0;
	on_top = true;
}doNothingPic;

#Picture to hold selectors as options pane
picture{
	text { caption = " "; font_size = 12; };
   x = 0; y = 0;
} optionsPanePicture;

#Trial to "do nothing" in between videos/option panes
trial{
	picture doNothingPic;
	nothing {};
	time = 2000;
}doNothing;

#Trial when all video sets have been used
trial{
	picture{ text{caption = "Finished"; font_size = 40;}; x=0;y=0;}picFinished;
	nothing {};
	time = 2000;
}finished;

#Trial to show options pane
trial {
	
   picture optionsPanePicture;
   code = "select";
	
}showOptionsPane;









begin_pcl;

########## Declare the Freaking Varaible Babe ##########
int counter = 1; #Counter to determine which video set to choose from
int videoSets = 0; #Number of video sets
string cap; #To check caption of text object
double videoDuration = 0.0; 
double videoStart = 0.0;
double currentVideoTime = 0.0;
int startTime; #Generic start of timing loop
int currentTime; #Generic current position of timing loop
int resp_ct; #Reponse count
int pastX = 0; #Past X Coordinate of joystick
int pastY = 0; #Past Y Coordinate of joystick
int currentX = 0; #Current X Coordinate of joystick
int currentY = 0; #Current Y Coordinate of joystick
joystick userLocation = response_manager.get_joystick( 1 ); # Add Joystick
userLocation.poll(); #Find starting joystick postions
pastX = userLocation.x(); #Set starting X position
pastY = userLocation.y(); #Set starting X position
string videoName = "";#string to hold video filename
array<bool> used[5];#array to determine if opotion has been set
array<int> orderBoxes[5];#array to hold the positions of randomized option boxes
double watchTime; #double to hold the time(ms) watched for each video
########## ^ ^ ^ ^ ^ ##########



########## Create text file for output data ##########
output_file resultsFile = new output_file;
resultsFile.open("rPPLp10kghfhppL.txt", false); # <--Gotta change this file name each time
########## ^ ^ ^ ^ ^ ##########




########## Input video file names from text file ##########
#Declare arrays for video names
array<string> columnTitles[100];
array<string> videoA[100];
array<string> videoB[100];
array<string> videoC[100];
array<string> videoD[100];
int numVideoSets;

#Bring in input file
input_file in = new input_file;
in.open( "videoSelectors2.txt" );

#Get rid of titles in text file
in.set_delimiter( '\t' ); # for get_line()
columnTitles[1] = in.get_string(); #Trial#
columnTitles[2] = in.get_string(); #VideoA
columnTitles[3] = in.get_string(); #VideoB
columnTitles[4] = in.get_string(); #VideoC
columnTitles[5] = in.get_string(); #VideoD

#Add video file names to appropriate arrays
int inputCounter = 1;
loop until in.end_of_file()  begin
	in.set_delimiter( '\t' );
	numVideoSets = in.get_int();
	
	if(numVideoSets > 0) then
		videoA[numVideoSets] = in.get_string();
		videoB[numVideoSets] = in.get_string();
		videoC[numVideoSets] = in.get_string();
		videoD[numVideoSets] = in.get_string();
		videoSets = numVideoSets;
	end;
end;
########## ^ ^ ^ ^ ^ ##########










########## Play the Video! ##########
sub playVideo(int whichVideo) begin;
	
	
	#Determine which set to choose video from
	#Counter variable matches current iteration of video start 
	#^^AKA if counter==1, the first video of all 4 set will be played
	if(whichVideo == 1) then
		videoName = videoA[counter];
	elseif(whichVideo == 2) then
		videoName = videoB[counter];
	elseif(whichVideo == 3) then
		videoName = videoC[counter];
	elseif(whichVideo == 4) then
		videoName = videoD[counter];
	end;
	
	#Create new video player
	video video_1;
	video_1 = new video;
	video_1.set_filename(videoName);#Add video from set
	video_1.set_height(675);
	video_1.set_width(900);
	video_1.set_x(-175);
	video_1.prepare();
	video_player.play(video_1, "Video");
	videoDuration = video_1.duration();#Record length of video
	videoStart = clock.time_double();#Record starting time of video
	
	#Declare video specific variables
	bool stop = false;
	bool lift = false;
	bool drag = false;
	
	resp_ct = response_manager.total_response_count();#Reset response count
	
	loop until stop==true begin
		bool fullVideo = false;
		lift = false;#Reset in case of multiple false lifts
		
		currentVideoTime = clock.time_double();#Find current time
		
		#If video is played through end the player
		if(currentVideoTime > (videoStart+videoDuration)) then
			stop = true;
			fullVideo = true;
			
		#Response count will increase by 2 if finger is lifted
		elseif(response_manager.total_response_count() == resp_ct+2) then
			#Confirm finger is lifted
			response_data second = response_manager.get_response_data( resp_ct + 2);
			int theResponse = second.button();
			if (theResponse == 2) then
				lift = true;
				#Find location of last touch
				userLocation.poll();
				currentX = userLocation.x();
				currentY = userLocation.y();
				pastX = currentX;
				pastY = currentY;
				
				
				startTime = clock.time();
				currentTime = 0;
				
			
				bool putBack = false; #Variable for false lift
				
				#loop until finger is put back on or if it has been off screen for 1000ms
				loop until (putBack == true) || (currentTime > startTime+1000) begin
					#Change in touch position will signify finger touches screen again
					userLocation.poll();
					currentX = userLocation.x();
					currentY = userLocation.y();
					
					if(currentX != pastX) || (currentY != pastY) then
						putBack = true;
					end;
					
					currentTime = clock.time();#update time
				end;
				
				if(putBack == true) then
					resp_ct = response_manager.total_response_count();#update response count
					#Continue entire video loop
				else
					#if else, finger has been off for 1000ms
					#stop video
					stop = true;	
				end;
				
			end;	
		
		
		#Response count will increase by 1 if finger is dragged and released
		elseif(response_manager.total_response_count() == resp_ct+1) then
			#confirm finger is dragged
			response_data first = response_manager.get_response_data( resp_ct + 1);
			int theResponse = first.button();
			if (theResponse == 2) then
				
				### RUN ENTIRE LIFT SEQUENCE AS SHOWN IN PREVIOUS ELSEIF CONDITION ###
				
				lift = true;
				userLocation.poll();
				currentX = userLocation.x();
				currentY = userLocation.y();
				pastX = currentX;
				pastY = currentY;
				
				startTime = clock.time();
				currentTime = 0;
				
				bool putBack = false;
				
				loop until (putBack == true) || (currentTime > startTime+1000) begin
					
					userLocation.poll();
					currentX = userLocation.x();
					currentY = userLocation.y();
					
					if(currentX != pastX) || (currentY != pastY) then
						putBack = true;
					end;
					
					currentTime = clock.time();
				end;
				
				if(putBack == true) then
					resp_ct = response_manager.total_response_count();
					resp_ct = resp_ct - 1; #Subtract 1 from response count because of drag only instigates 1 response
				else
					stop = true;
				end;
			end;

		end;
	end;
	
	if(currentVideoTime > (videoStart+videoDuration)) then
		watchTime = videoDuration;
	else
		watchTime = currentTime-1000;
	end;
	
	#If out of loop, video is meant to be stopped
	video_player.stop();
	video_1.release();
	
	resultsFile.print(whichVideo);
	resultsFile.print("\t");
	resultsFile.print(watchTime);
	resultsFile.print("\n");
	
	counter = counter + 1;#Increase counter in order to play next video in each set for next video playback
	
	#Check if all sets have been played
	if counter > videoSets then
		#If so finish scenario
		finished.present();
	else
		#If not reset to option pane
		doNothingText.set_caption("Wait for next set");
		doNothingText.redraw();
		doNothing.present();
	end;
end;
########## ^ ^ ^ ^ ^ ##########










########## Make unselected options disappear from pane ##########
sub changeCaptions(int chooser) begin
	          
	
	int whichBox = orderBoxes[chooser];
	int k=1;
	loop until k>4 begin
		if k != whichBox then
			optionsArrayBorder[k].set_color(0,0,0);
			#optionsArrayBorder[k].redraw();
			optionsArray[k].set_font_color(0,0,0);
			optionsArray[k].redraw();
		else
			optionsArray[k].set_font_color(0,0,0);
			optionsArray[k].set_background_color(optionsArrayBorder[k].color());
			optionsArray[k].redraw();
			
			
		end;
		k = k+1
	end;

	
end;
########## ^ ^ ^ ^ ^ ##########










########## Subject must hold selector for 1000ms to play video ##########
sub edit_Touch(int selector) begin
	
	resp_ct = response_manager.total_response_count();#Reset response counter
	
	pastX = currentX;#Reset to last touch
	pastY = currentY;#Reset to last touch
	
	bool letOff = false;
	bool hold = false;#Boolean to see if selector is held
	startTime = clock.time();
	currentTime = 0;
	
	#Set loop to end if held for 1000ms of if let go
	loop until (letOff==true) || (currentTime > (startTime+1000)) begin
		currentTime = clock.time();#Update run time 
		
		#When Selector is held for 1000ms
		#if currentTime > (startTime+1000) then
			#Double check finger hasn't been lifted/dragged
			if(response_manager.total_response_count() == resp_ct + 1) then
				letOff = true;
			end;
		#end;
		
		
		
		#Update current touch location if changed
		userLocation.poll();
		currentX = userLocation.x();
		currentY = userLocation.y();
	end;

	if ((currentTime > (startTime+1000)) && (letOff == false)) then
			#Double check finger hasn't been lifted/dragged
		if(response_manager.total_response_count() == resp_ct + 0) then
				hold = true;
		end;
	end;


		#Play video if held
		if (hold == true) then
			#Match letter selection with correct video
			
			
		
			playVideo(selector);
			
		#if not held, let us know and reset option pane	
		else
			pastX = currentX;
			pastY = currentY;
			doNothingText.set_caption("Must hold for video. Resetting set");
			doNothingText.redraw();
			doNothing.present();
		end; 
end;
########## ^ ^ ^ ^ ^ ##########











########## Wait for Subject to Select Option from Pane ##########
sub waitForSelection begin
	
	#Get Location of touch
	userLocation.poll();
	currentX = userLocation.x();
	currentY = userLocation.y();
	pastX = currentX;
	pastY = currentY;
	
	#Location of touch will change in pressed on monitor
	#So basically we are looking for a new press
	loop until (pastX != currentX) || (pastY != currentY) begin
		userLocation.poll();
		currentX = userLocation.x();
		currentY = userLocation.y();
	end;
		

	pastX = currentX;#Reset to last touch
	pastY = currentY;#Reset to last touch
	
	int optionChooser;
	bool bad = false;

	#Determine where on screen subject pressed
	#Find caption of text object in order to determine what selector was chosen
	if 
		(currentX >= 725) && (currentX <= 965) && (currentY >= 20) && (currentY < 430)
	then
		cap = optionsArray[2].caption();
		changeCaptions(1);
		optionChooser = 1;
	elseif
		(currentX >= 445) && (currentX < 685) && (currentY > 20) && (currentY < 430)
	then
		cap = optionsArray[1].caption();
		optionChooser = 2;
		changeCaptions(2);
	elseif
		(currentX >= 445) && (currentX <= 685) && (currentY <= -20) && (currentY > -430)
	then
		cap = optionsArray[3].caption();
		
		optionChooser = 3;
		changeCaptions(3);
	elseif
		(currentX > 725) && (currentX <= 965) && (currentY < -20) && (currentY > -430)
	then
		cap = optionsArray[4].caption();
		optionChooser = 4;
		changeCaptions(4);
	else
		bad = true;
	end;
	
	#check for a quick click (no hold)
	#^^BAD^^#
	if((response_manager.total_response_count() == resp_ct+2) || (bad == true)) then
		pastX = currentX;
		pastY = currentY;
		doNothingText.set_caption("Must hold for video. Resetting set");
		doNothingText.redraw();
		doNothing.present();
	else
		#Make video selection align with shuffled options
		int k = 0;
		int holder = 0;
		holder = orderBoxes[optionChooser];
		cap = optionsArray[holder].caption();
		
		#Use selector caption to initiate playback sequence
		if cap == "A" then
			edit_Touch(1);
		elseif cap == "B" then
			edit_Touch(2);
		elseif cap == "C" then
			edit_Touch(3);
		elseif cap == "D" then
			edit_Touch(4);
		end;
	end;

end;
########## ^ ^ ^ ^ ^ ##########










########## Edit Video Options Pane ##########
sub setOptionsPane begin;
	
	resp_ct = response_manager.total_response_count();#Reset response count
	
	#Reset all letter colors
	int k = 0;
	loop until k == 4 begin
		k = k+1;
		if(optionsArray[k].caption() == "A") then
			optionsArray[k].set_font_color(242,39,19);
			optionsArray[k].set_background_color(0,0,0);
			optionsArrayBorder[k].set_color(242,39,19);
		elseif(optionsArray[k].caption() == "B") then
			optionsArray[k].set_font_color(25,181,254);
			optionsArray[k].set_background_color(0,0,0);
			optionsArrayBorder[k].set_color(25,181,254);
		elseif(optionsArray[k].caption() == "C") then
			optionsArray[k].set_font_color(248,148,6);
			optionsArray[k].set_background_color(0,0,0);
			optionsArrayBorder[k].set_color(248,148,6);
		elseif(optionsArray[k].caption() == "D") then
			optionsArray[k].set_font_color(0,177,106);
			optionsArray[k].set_background_color(0,0,0);
			optionsArrayBorder[k].set_color(0,177,106);
		end;
		optionsArray[k].redraw();
		#optionsArrayBorder[k].redraw();
	end;
		
		
	optionsPanePicture.set_part_x( 1, 0 );
	optionsPanePicture.set_part_y( 1, 0 );
	
	array<int> selectorXPos[5];
	array<int> selectorYPos[5];		
	selectorXPos[1] = 600;
	selectorXPos[2] = 400;
	selectorXPos[4] = 600;
	selectorXPos[3] = 400;
	selectorYPos[1] = 100;
	selectorYPos[2] = 100;
	selectorYPos[4] = -100;
	selectorYPos[3] = -100;
	k=1;
	
	used[1] = false;
	used[2] = false;
	used[3] = false;
	used[4] = false;
	
	loop until k > 4 begin
		int randomNumber;
		randomNumber = random(1,4);
		if(used[randomNumber] != true) then
			used[randomNumber] = true;
			orderBoxes[k] = randomNumber;
			optionsPanePicture.add_part(optionsArrayBorder[randomNumber], selectorXPos[k], selectorYPos[k]);
			optionsPanePicture.add_part(optionsArray[randomNumber], selectorXPos[k], selectorYPos[k]);
			k = k+1;
			
		end;
	end;
	
	
	#Present Selectors
	showOptionsPane.present();
	waitForSelection();
end;
########## ^ ^ ^ ^ ^ ##########	










########## Trial Looper ##########
loop until counter > videoSets begin
   setOptionsPane();
end;
########## ^ ^ ^ ^ ^ ##########























/*
          .--.
         / _  \  ___      .--.
        | ( _.-""   `'-.,' _  \
         \.'            '.  ) /
         /                \_.'
        /    .-.   .-.     \
        |   / o \ / o \    |
        ;   \.-'` `'-./    |
        /\      ._.       /
      ;-'';_   ,_Y_,   _.'
     /     \`--.___.--;.
    /|      '.__.---.  \\
   ;  \              \  ;'--. .-.
   |   '.    __..-._.'  |-,.-'  /
   |     `""`  .---._  / .--.  /
  / ;         /      `-;/  /|_/
  \_,\       |            | |
      '-...--'._     _..__\/
                `"""`