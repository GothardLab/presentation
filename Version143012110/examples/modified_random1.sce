# does a pseudo-randomization with 3 sets of trials that are always preceded by 
# associated trials
no_logfile=true;
begin;

array {
   trial { nothing {}; code = "movc 1"; };
   trial { nothing {}; code = "movc 2"; };    
   trial { nothing {}; code = "movc 3"; };
   trial { nothing {}; code = "movc 4"; };
   trial { nothing {}; code = "movc 5"; };
   trial { nothing {}; code = "movc 6"; };
   trial { nothing {}; code = "movc 7"; };
   trial { nothing {}; code = "movc 8"; };  
} movc_trials;

array {      
   trial { nothing {}; code = "movi 1"; };
   trial { nothing {}; code = "movi 2"; };    
   trial { nothing {}; code = "movi 3"; };
   trial { nothing {}; code = "movi 4"; };
   trial { nothing {}; code = "movi 5"; };
   trial { nothing {}; code = "movi 6"; };
   trial { nothing {}; code = "movi 7"; };
   trial { nothing {}; code = "movi 8"; };  
} movi_trials;   

array {        
   trial { nothing {}; code = "movd 1"; };
   trial { nothing {}; code = "movd 2"; };    
   trial { nothing {}; code = "movd 3"; };
   trial { nothing {}; code = "movd 4"; };
   trial { nothing {}; code = "movd 5"; };
   trial { nothing {}; code = "movd 6"; };
   trial { nothing {}; code = "movd 7"; };
   trial { nothing {}; code = "movd 8"; };  
} movd_trials;   

trial { nothing {}; code = "std"; } std;
trial { nothing {}; code = "sti"; } sti;
trial { nothing {}; code = "stc"; } stc;

begin_pcl;

# number of times each mov trial is shown
int repeats = 8;  
# ratio of st trials to mov trials for each type 
int ratio = 4;   

# number of trials in each category
int num_movc = movc_trials.count() * repeats;
int num_movd = movd_trials.count() * repeats;
int num_movi = movi_trials.count() * repeats;      
# number of st trials not bound to a mov trial
int num_independent_stc = num_movc * (ratio - 1); 
int num_independent_std = num_movd * (ratio - 1);
int num_independent_sti = num_movi * (ratio - 1);

# for use in picking trial to show                 
int movc_index = num_movc;
int movd_index = movc_index + num_movd;
int movi_index = movd_index + num_movi;
int stc_index  = movi_index + num_independent_stc;
int std_index  = stc_index  + num_independent_std;
int sti_index  = std_index  + num_independent_sti;

# make an array with numbers from 1 to sti_index 
array<int> indices[sti_index];  
loop int i = 1 until i > sti_index begin
   indices[i] = i;  
   i = i + 1
end;     
# randomly shuffle the numbers
indices.shuffle();

loop
   int i = 1
until
   i > indices.count()
begin      
   # if index is in the movc range, show stc and one of the movc's
   if (indices[i] < movc_index) then  
      int mov_index = (indices[i] - 1) / movc_trials.count() + 1;
      stc.present();
      movc_trials[ mov_index ].present();   
   # if index is in the movd range, show std and one of the movd's
   elseif (indices[i] < movd_index) then  
      int mov_index = (indices[i] - movc_index - 1) / movd_trials.count() + 1;
      std.present();
      movd_trials[ mov_index ].present(); 
   # if index is in the movi range, show sti and one of the movi's
   elseif (indices[i] < movi_index) then  
      int mov_index = (indices[i] - movd_index - 1) / movi_trials.count() + 1;
      sti.present();
      movi_trials[ mov_index ].present();  
   # if index is in the stc range, show stc
   elseif (indices[i] < stc_index) then
      stc.present()              
   # if index is in the std range, show std
   elseif (indices[i] < std_index) then
      std.present() 
   # if index is in the sti range, show sti
   else
      sti.present()
   end;
   i = i + 1
end